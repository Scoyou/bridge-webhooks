import React, { Component } from "react";
import { Table, Container, Checkbox } from "semantic-ui-react";
import { ExternalLink } from "react-external-link";
import Moment from "moment";
import axios from "axios";

class RegistrationIndex extends Component {
  state = {
    registrations: [],
    filter: "",
  };

  componentDidMount() {
    let url =
      this.state.filter === ""
        ? "/api/registrations"
        : `/api/registrations?uid=${this.state.filter}`;
    axios
      .get(url)
      .then((res) => {
        this.setState({ registrations: res.data });
      })
      .catch((err) => {
        console.log(err);
      });
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    if (nextProps.filter !== prevState.filter) {
      return { filter: nextProps.filter };
    }
    return null;
  }

  changeAttendance = (id, domain, session_id, registration_id, is_attended) => {
    const url = `https://${domain}.bridgeapp.com/api/author/live_course_sessions/${session_id}/registrations/${registration_id}`;
    const proxyurl = "https://cors-anywhere.herokuapp.com/";

    const token = process.env.REACT_APP_BRIDGE_API_KEY;

    let config = {
      headers: {
        Authorization: token,
      },
    };

    let body = {
      live_course_session_registration: {
        marked_complete_at: is_attended ? null : Moment().format(),
      },
    };

    axios
      .patch(`/api/registrations/${id}`, { is_attended: !is_attended })
      .then(() =>
        axios
          .get("/api/registrations")
          .then((res) => {
            this.setState({ registrations: res.data });
          })
          .catch((err) => {
            console.log(err);
          })
      );
    axios.patch(proxyurl + url, body, config);
  };

  displayRegistrations = () => {
    const { registrations } = this.state;
    const domain = "syautocsv2";

    return (
      <Container fluid>
        <Table>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell>Attended</Table.HeaderCell>
              <Table.HeaderCell>Unique ID</Table.HeaderCell>
              <Table.HeaderCell>Live Course ID</Table.HeaderCell>
              <Table.HeaderCell>Title</Table.HeaderCell>
              <Table.HeaderCell>Start Time</Table.HeaderCell>
            </Table.Row>
          </Table.Header>
          {this.state.registrations ? (
            <Table.Body>
              {registrations.map((reg) => (
                <Table.Row key={reg.id}>
                  <Table.Cell collapsing>
                    <Checkbox
                      checked={reg.is_attended}
                      onClick={() =>
                        this.changeAttendance(
                          reg.id,
                          domain,
                          reg.live_course_session_id,
                          reg.bridge_registration_id,
                          reg.is_attended
                        )
                      }
                    />
                  </Table.Cell>

                  <Table.Cell>
                    <ExternalLink
                      key={reg.id}
                      href={`https://${domain}.bridgeapp.com/admin/users?search=${reg.uid}`}
                    >
                      {reg.uid}
                    </ExternalLink>
                  </Table.Cell>
                  <Table.Cell>{reg.live_course_id}</Table.Cell>
                  <Table.Cell>
                    <ExternalLink
                      key={reg.id}
                      href={`https://${domain}.bridgeapp.com/author/training/${reg.live_course_id}`}
                    >
                      {reg.live_course_title}
                    </ExternalLink>
                  </Table.Cell>
                  <Table.Cell>{Moment(reg.session_start_time).format('LLLL')}</Table.Cell>
                </Table.Row>
              ))}
            </Table.Body>
          ) : (
            <p>No users found</p>
          )}
        </Table>
      </Container>
    );
  };

  render() {
    return <div>{this.displayRegistrations()}</div>;
  }
}

export default RegistrationIndex;

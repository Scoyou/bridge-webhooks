import React, { Component } from "react";
import { Table, Container, Checkbox } from "semantic-ui-react";
import { ExternalLink } from "react-external-link";
import moment from "moment";

import axios from "axios";

class RegistrationIndex extends Component {
  state = {
    registrations: [],
  };

  componentDidMount() {
    axios
      .get("/api/registrations")
      .then((res) => {
        this.setState({ registrations: res.data });
      })
      .catch((err) => {
        console.log(err);
      });
  }

  changeAttendance = (id, domain, session_id, registration_id, is_attended) => {
    console.log(session_id, registration_id)
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
        marked_complete_at: is_attended ? null : moment().format(),
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
              <Table.HeaderCell>Session ID</Table.HeaderCell>
              <Table.HeaderCell>Registration ID</Table.HeaderCell>
            </Table.Row>
          </Table.Header>
          <Table.Body>
            {registrations.map((reg) => (
              <Table.Row key={reg.id}>
                <Table.Cell collapsing>
                  <Checkbox
                    slider
                    checked={reg.is_attended}
                    onClick={() =>
                      this.changeAttendance(
                        reg.id,
                        domain,
                        reg.session_id,
                        reg.registration_id,
                        reg.is_attended
                      )
                    }
                  />
                </Table.Cell>

                <Table.Cell>
                  <ExternalLink
                    key={reg.id}
                    href={`https://${domain}.bridgeapp.com/author/training/${reg.live_course_id}/sessions/${reg.live_course_session_id}?search=${reg.uid}`}
                  >
                    {reg.uid}
                  </ExternalLink>
                </Table.Cell>
                <Table.Cell>{reg.live_course_id}</Table.Cell>
                <Table.Cell>{reg.live_course_session_id}</Table.Cell>
                <Table.Cell>{reg.bridge_registration_id}</Table.Cell>
              </Table.Row>
            ))}
          </Table.Body>
        </Table>
      </Container>
    );
  };

  render() {
    return <div>{this.displayRegistrations()}</div>;
  }
}

export default RegistrationIndex;

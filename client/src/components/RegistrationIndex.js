import React, { Component } from "react";
import { 
    Table, 
    Container,
    Checkbox 
} from "semantic-ui-react";
import { ExternalLink } from "react-external-link";
import moment from 'moment';

import axios from "axios";

class RegistrationIndex extends Component {
  state = { registrations: [] };

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

  markAttended = (domain, session_id, registration_id) => {
    const token = process.env.REACT_APP_BRIDGE_API_KEY

    let config = {
        headers: {
          Authorization: token,
        }
      }

      let body = {"live_course_session_registration":{"marked_complete_at": moment().format() }}
      
      axios.patch(`https://${domain}.bridgeapp.com/api/author/live_course_sessions/${session_id}/registrations/${registration_id}`, body, config)
  }

  displayRegistrations = () => {
    const { registrations } = this.state;
    const domain = "syautocsv2";

    return (
      <Container fluid>
        <Table>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell>Unique ID</Table.HeaderCell>
              <Table.HeaderCell>Live Course ID</Table.HeaderCell>
              <Table.HeaderCell>Session ID</Table.HeaderCell>
              <Table.HeaderCell>Registration ID</Table.HeaderCell>
            </Table.Row>
          </Table.Header>
          <Table.Body>
            {registrations.map((reg) => (
              <Table.Row>
                <Table.Cell collapsing>
                  <Checkbox slider onClick={() => this.markAttended(domain, reg.live_course_session_id, reg.bridge_registration_id)}/>
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

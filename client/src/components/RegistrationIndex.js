import React, { Component } from 'react';
import { Container } from 'semantic-ui-react';
import { ExternalLink } from 'react-external-link';


import axios from 'axios';

class RegistrationIndex extends Component {

    state = { registrations: [] }

    componentDidMount() {
        axios.get('/api/registrations')
        .then(res => {
            this.setState({ registrations: res.data })
        }).catch( err =>{
            console.log(err)
        })
    }

    displayRegistrations = () => {
        const { registrations } = this.state
        const domain = 'syautocsv2'
        return registrations.map(reg => (
            <ExternalLink 
            href={`https://${domain}.bridgeapp.com/author/training/${reg.live_course_id}/sessions/${reg.live_course_session_id}?search=${reg.uid}`}>
                <Container key={reg.id}>
                    <ul>
                        <li>UID: {reg.uid}</li>
                        <li>Live_course_id: {reg.live_course_id}</li>
                        <li>Session_id: {reg.live_course_session_id}</li>
                        <li>Registration_id: {reg.bridge_registration_id}</li>
                    </ul>
                </Container>
            </ExternalLink>
        ))
    }

	render() {
		return(
            <div>
                {this.displayRegistrations()}
            </div>
        )
	}

}

export default RegistrationIndex;
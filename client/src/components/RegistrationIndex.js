import React, { Component } from 'react';

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
        return registrations.map(registration => (
            <div key={registration.id}>
                <ul>
                    <li>UID: {registration.uid}</li>
                    <li>Live_course_id: {registration.live_course_id}</li>
                    <li>Session_id: {registration.live_course_session_id}</li>
                    <li>Registration_id: {registration.bridge_registration_id}</li>
                </ul>
            </div>
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
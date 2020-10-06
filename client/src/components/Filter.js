import React, { Component } from 'react';
import { Input } from 'semantic-ui-react'
import RegistrationIndex from './RegistrationIndex'


class Filter extends Component {
    constructor(props) {
        super(props);
        this.state = { uid: '' };
      }

      myChangeHandler = (event) => {
        this.setState({uid: event.target.value});
      }

	render() {


		return(
            <div>
                <Input placeholder='Enter UID' onChange={this.myChangeHandler}/>
                <RegistrationIndex key={this.state.uid} filter={this.state.uid}/>
            </div>
        )
	}

}

export default Filter;
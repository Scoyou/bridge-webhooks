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
        console.log(this.state.uid)
      }

	render() {


		return(
            <div>
                <Input placeholder='Search...' onChange={this.myChangeHandler}/>
                <RegistrationIndex filter={this.state.uid}/>
            </div>
        )
	}

}

export default Filter;
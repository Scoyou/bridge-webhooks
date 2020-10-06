import React, { Component } from "react";
import { Input } from "semantic-ui-react";
import RegistrationIndex from "./RegistrationIndex";
import styled from "styled-components";

const Header = styled.div`
  background-color: #f6f7f9;
  height: 100px;
  padding: 30px;
`;

class Filter extends Component {
  constructor(props) {
    super(props);
    this.state = { uid: "" };
  }

  myChangeHandler = (event) => {
    this.setState({ uid: event.target.value });
  };

  render() {
    return (
      <div>
        <Header>
          <Input placeholder="Enter UID" onChange={this.myChangeHandler} />
        </Header>
        <RegistrationIndex key={this.state.uid} filter={this.state.uid} />
      </div>
    );
  }
}

export default Filter;

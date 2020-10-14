import React, { useState } from "react";
import { Input } from "semantic-ui-react";
import RegistrationIndex from "./RegistrationIndex";
import styled from "styled-components";

const Header = styled.div`
  background-color: #f6f7f9;
  height: 100px;
  padding: 30px;
`;


const Filter = () => {
  const [uid, setUid] = useState('')
    return (
      <div>
        <Header>
          <Input placeholder="Enter UID" onChange={e => setUid(e.target.value)} />
          {console.log(uid)}
        </Header>
        <RegistrationIndex key={uid} filter={uid} />
      </div>
    );
}

export default Filter;

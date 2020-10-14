import React, { useState, useEffect } from "react";
import { Table, Container, Checkbox } from "semantic-ui-react";
import { ExternalLink } from "react-external-link";
import Moment from "moment";
import axios from "axios";
import { usePaginatedQuery } from "react-query";
import { Input } from "semantic-ui-react";
import styled from "styled-components";

const fetchRegistrations = async (key, page) => {
  const res = await fetch(`/api/registrations?page=${page}`);
  return res.json();
};

const changeAttendance = (
  id,
  domain,
  session_id,
  registration_id,
  is_attended,
  refetch
) => {
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
    .then(() => {
      refetch();
    });
  axios.patch(proxyurl + url, body, config);
};

const displayRegistrations = (registrations, refetch) => {
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
        {registrations ? (
          <Table.Body>
            {registrations.map((reg) => (
              <Table.Row key={reg.id}>
                <Table.Cell collapsing>
                  <Checkbox
                    checked={reg.is_attended}
                    onClick={() =>
                      changeAttendance(
                        reg.id,
                        domain,
                        reg.live_course_session_id,
                        reg.bridge_registration_id,
                        reg.is_attended,
                        refetch
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
                <Table.Cell>
                  {Moment(reg.session_start_time).format("LLLL")}
                </Table.Cell>
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

const Header = styled.div`
  background-color: #f6f7f9;
  height: 100px;
  padding: 30px;
`;

const RegistrationIndex = () => {
  const [page, setPage] = useState(1);
  const [searchResults, setSearchResults] = useState([]);
  const [uid, setUid] = useState("");
  const handleChange = (event) => {
    setUid(event.target.value);
  };

  const { resolvedData, latestData, status, refetch } = usePaginatedQuery(
    ["registrations", page],
    fetchRegistrations
  );

  useEffect(() => {
    let re = new RegExp(`${uid}.*`, "g");
    const results =
      resolvedData && resolvedData.results.filter((data) => data.uid.match(re));
    setSearchResults(results);
  }, [uid, resolvedData, refetch]);
  return (
    <div>
      {status === "loading" && <div>Loading data...</div>}
      {status === "error" && <div>Error fetching data</div>}
      {status === "success" && (
        <>
          <Header>
            <Input
              placeholder="Enter UID"
              value={uid}
              onChange={handleChange}
            />
          </Header>
          <div>
            {displayRegistrations(
              (searchResults && searchResults.length === 0) || !searchResults
                ? resolvedData.results
                : searchResults,
              refetch
            )}
          </div>
          <button
            onClick={() => setPage((old) => Math.max(old - 1, 1))}
            disabled={page === 1}
          >
            Previous Page
          </button>
          <span>
            {page} of {resolvedData.total_pages}
          </span>
          <button
            onClick={() => setPage(page + 1)}
            disabled={page === resolvedData.total_pages}
          >
            Next Page
          </button>
        </>
      )}
    </div>
  );
};

export default RegistrationIndex;

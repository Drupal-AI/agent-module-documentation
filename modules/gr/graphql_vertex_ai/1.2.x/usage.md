<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Vertex AI provides a GraphQL endpoint for Vertex AI.

---

GraphQL Vertex AI **provides a GraphQL endpoint for Google Vertex AI Search** — exposing Vertex AI Search
(and autocomplete) queries through GraphQL so a decoupled front-end can search a Vertex AI index. It depends on
the GraphQL and Key modules, provides its own permissions.

Use it to serve Vertex AI Search to a front-end. It is an AI/decoupled feature. Security/data handling: the
Vertex AI **service-account credential** is stored via the **Key** module (correct — secret provider) and used
**server-side** (not exposed to clients); queries are **sent to Google Vertex AI** (external egress + API cost),
so **gate the GraphQL query/endpoint** so only intended clients can run searches (an open GraphQL query becomes
a cost/abuse vector), and the settings route is admin-gated (`administer graphql_vertex_ai`). It has no
access-control role beyond that. Configure the Vertex AI credentials and GraphQL access.

---

- Expose Vertex AI Search via GraphQL.
- Serve search/autocomplete queries.
- Serve decoupled front-ends.
- Depend on GraphQL and Key.
- Provide its own permissions.
- Query a Vertex AI index.
- Store the service-account credential via Key (correct).
- Use the credential server-side (not client-exposed).
- Send queries to Vertex AI (egress + cost).
- GATE the GraphQL query/endpoint (cost/abuse).
- Admin-gate the settings route.
- Configure credentials + GraphQL access.
- Handle Vertex AI GraphQL.
- Serve search.
- Configure the endpoint.
- Query Vertex AI.
- Handle the integration.
- Search the index.
- Secure the credential (Key).
- Provide GraphQL Vertex AI.

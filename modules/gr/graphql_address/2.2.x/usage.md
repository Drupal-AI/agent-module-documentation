<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Address provides a GraphQL schema for the Address module.

---

GraphQL Address **exposes Address-module data via GraphQL** — providing a schema so a decoupled front-end
can query address fields (country, admin area, locality, postal code, etc.) through the GraphQL module. It
depends on the GraphQL and Address modules, in the Graphql package.

Use it to serve address data to a headless front-end. It is a decoupled/integration feature. Security note:
GraphQL delivery **exposes data over the API** — the GraphQL schema/server governs what's queryable, so ensure
address data is only exposed where intended and the GraphQL endpoint's access is configured appropriately. It
has no access-control role of its own. Configure the GraphQL schema.

---

- Expose Address data via GraphQL.
- Provide an address schema.
- Query country/locality/postal code.
- Depend on GraphQL and Address.
- Serve decoupled front-ends.
- Add address types.
- EXPOSE data over the API.
- Expose address data only where intended.
- Configure the GraphQL endpoint access.
- Have no access-control role of its own.
- Configure the schema.
- Handle address GraphQL.
- Serve addresses.
- Configure the query.
- Expose addresses.
- Handle the integration.
- Query addresses.
- Provide the schema.
- Review API exposure.
- Provide GraphQL address.

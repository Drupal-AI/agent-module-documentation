# GraphQL Address — manual setup guide

**GraphQL Address** (`graphql_address`) adds **GraphQL support for the Address
module**. It exposes Drupal address‑field data — country, administrative area,
locality, postal code and the rest — as a GraphQL schema, so a decoupled
(headless) front end can query addresses through the GraphQL module. It provides a
ready‑made **SchemaExtension** and a **DataProducer** (`graphql_address_field_values`)
that you can use as‑is or extend with your own code.

This is a **decoupled/integration** module. It sits on top of the
[GraphQL](https://www.drupal.org/project/graphql) and
[Address](https://www.drupal.org/project/address) modules and has no admin form of
its own — you turn it on and wire it up through the GraphQL server configuration.

One thing to keep in mind: exposing data over GraphQL means it becomes queryable
through the API. The GraphQL schema and server govern **what** is queryable and
**who** can query it, so make sure address data is only exposed where you intend
and that your GraphQL endpoint's access is configured appropriately. This module
adds no access‑control of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   ensure GraphQL and Address are present, and enable it.

There is **no dedicated settings form**. Setup happens on your GraphQL server's
configuration and on the address field's resolver — see "How to use it" below.

## How to use it

1. Install and enable the module (it pulls in GraphQL and Address).
2. On your **GraphQL server's edit page**, enable the **"GraphQL Address"
   SchemaExtension**.
3. Configure any **Address field** on an entity to be resolved by the provided
   `graphql_address_field_values` DataProducer.
4. Include the field on the relevant GraphQL **Type**, resolved as
   `AddressAddress`.
5. Query away from your decoupled front end.

If you prefer, you can **replace or extend** the included SchemaExtension with your
own code — the provided DataProducers remain useful either way.

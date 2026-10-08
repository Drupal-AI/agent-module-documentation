# GraphQL Vertex AI — manual setup guide

**GraphQL Vertex AI** (`graphql_vertex_ai`) provides a GraphQL endpoint for
**Google Vertex AI Search**. It lets a decoupled or headless front end run
search and autocomplete queries against a Vertex AI cloud index through your
Drupal site's GraphQL schema — including Gemini-generated summaries alongside
search results. (Facet support is planned for a future version.)

The heavy lifting happens in Google Cloud: you set up a Vertex AI data store and
agent builder there, and this module talks to it from Drupal. Your Google Cloud
**service-account credential** is the sensitive piece, and the module handles it
correctly — it is stored through the **Key** module (a proper secret provider)
and used **server-side only**, so it is never exposed to a browser or a GraphQL
client. Queries themselves are forwarded to Google Vertex AI, which means real
network egress and per-query cost.

Because every query costs money and leaves your infrastructure, the most
important operational rule is to **gate the GraphQL endpoint and the search
query** so only your intended clients can run it. An open, unauthenticated
GraphQL search field backed by a paid AI service is a cost- and abuse-magnet.
The module's own settings form is admin-gated behind the `administer
graphql_vertex_ai` permission, but you are responsible for restricting the
GraphQL query/endpoint that clients actually hit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside GraphQL and Key.
2. [Configuration](configuration/index.md) — store the service-account
   credential with Key, point the module at your Vertex AI data store, and lock
   down the endpoint.

## Where it lives in the admin menu

The module adds a settings form protected by the **Administer GraphQL Vertex
AI** (`administer graphql_vertex_ai`) permission, reached from the site's
Configuration area. See [Configuration](configuration/index.md) for what to fill
in. To expose the search itself, add the module's schema extension to your GraphQL
schema (or use its data producers to build your own field).

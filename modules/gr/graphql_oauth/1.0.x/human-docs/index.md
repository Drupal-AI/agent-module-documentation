# GraphQL OAuth — manual setup guide

**GraphQL OAuth** (`graphql_oauth`) adds **OAuth directive** support to the
GraphQL module, so you can require an OAuth scope on individual GraphQL schema
fields and types. In plain terms: it lets you mark parts of your GraphQL API as
"you may only read this if the request presents an OAuth token carrying the
right scope," and it enforces that check when the query runs.

This is an authorization tool for decoupled and web-service APIs. You annotate a
field or type in your schema with the module's OAuth directive naming the scope
it needs; a request without a valid token, or with a token that lacks that
scope, is denied access to that field. The scope check builds on the Simple
OAuth module, which issues and validates the tokens, so the two work together —
GraphQL OAuth decides *which* scopes a field demands, and Simple OAuth is what
proves a request actually holds them.

Two points are essential to using it safely. First, protection is opt-in per
field: **a field you do not annotate is not scope-gated**, so it stays as open
as the rest of your schema allows. When you adopt this, apply the directive to
*every* field that needs protecting, not just the obvious ones. Second, the
scope check is only ever as strong as the token validation behind it — make sure
your Simple OAuth provider and its token/scope configuration are correct, or a
directive can appear to protect a field while letting a malformed token through.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside GraphQL and Simple OAuth.

There is **no configuration page** for this module. The directives are applied
in your GraphQL **schema** (in code / your schema definition), and OAuth scopes
and clients are managed by the **Simple OAuth** module, not here.

## How to use it

1. Set up **Simple OAuth** (`simple_oauth`, version 6.0 or newer): create your
   OAuth consumers, define the scopes your API uses, and confirm tokens are
   being issued and validated correctly.
2. In your GraphQL schema, annotate the fields and types you want to protect
   with the OAuth directive this module provides, naming the scope each one
   requires.
3. Have clients send their OAuth token with each GraphQL request. The directive
   allows the field when the token carries the required scope and denies it
   otherwise.

> **Note:** This is a `1.0.0-alpha` release and requires GraphQL 4.1+ and Simple
> OAuth 6.0+. Audit your schema to confirm that no sensitive field was left
> un-annotated.

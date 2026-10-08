# Simple OAuth Claims — manual setup guide

**Simple OAuth Claims** (`simple_oauth_claims`) lets you add extra pieces of
user information — "claims" — to the tokens that the [Simple OAuth](https://www.drupal.org/project/simple_oauth)
module hands out. Instead of writing custom code with hooks, you create small
**Claim** configuration entities in the admin UI, each one mapping a user field
(say, the user's first name or a "department" field) to a named claim that gets
injected into the OAuth access token and/or the OpenID Connect (OIDC) user
response.

In plain terms: an API client authenticates through Simple OAuth and receives a
token. Normally that token carries only the standard information. With this
module you can enrich it, so the client also receives the profile data you have
chosen to expose — without touching a line of PHP. Each claim can be marked as
an **OIDC** claim (returned from the OpenID Connect endpoints), a **private**
JWT claim (embedded in the token itself), or left undetermined, and each one can
be enabled or disabled individually.

The module does nothing until you create at least one Claim, so it needs
configuration to be useful. It depends on the **Simple OAuth** module and has no
submodules of its own.

A word of caution worth reading before you configure anything: an enabled claim
is added for **the token's user regardless of which client requested it or what
scope was granted**. That means if you map a sensitive user field to a claim,
you are exposing that field to *every* OAuth client that receives a token. Map
only fields you are comfortable sharing broadly, and think carefully before
adding anything private.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Simple OAuth.
2. [Configuration](configuration/index.md) — create and manage Claim entities,
   field by field.

## Where it lives in the admin menu

Once enabled, claims are managed on the **Claims** listing page at
`/admin/structure/claims` (route `entity.claim.collection`). You need the
**Administer claims** permission — an administrator by default — to see and edit
it.

## How to use it

Create a Claim, choose the user field it reads from, give it a claim name and a
type (OIDC or private), and enable it. From then on, tokens issued by Simple
OAuth carry that claim's value for whichever user the token belongs to. When you
add, change, or remove claims, Drupal rebuilds its service container so the new
OIDC claim names are registered for discovery — this happens as part of a normal
cache rebuild.

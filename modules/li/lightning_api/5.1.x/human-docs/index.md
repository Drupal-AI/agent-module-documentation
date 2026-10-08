# Content API (Lightning API) — manual setup guide

**Content API** (`lightning_api`, from the Lightning distribution) is a thin
"glue" module that sets up a standards-based content API for progressive or fully
decoupled Drupal. It ties together core **JSON:API** and — optionally — **Simple
OAuth** for token authentication and **OpenAPI** tooling for browsable docs, so a
mobile app, single-page app, or other front end can read your site's content over a
standard API.

The module itself is deliberably small: the heavy lifting is done by its
dependencies. Its own contribution is a couple of convenience toggles and a helper
form. The two settings toggles add operation links for editors: **"View JSON"** on
content entities (linking to an entity's JSON:API output, handy for previewing what
the API returns) and **"View API Documentation"** on bundles like content types. A
second form generates an OAuth2 public/private **key pair** for Simple OAuth and
saves the key paths for you, so you don't have to run `openssl` and hand-edit
config. On install, if the OpenAPI + ReDoc modules are present, it even creates a
friendly `/api-docs` path for the API documentation.

In short: enable this module to get a sensible JSON:API baseline, optionally add
Simple OAuth for authenticated API access (generating keys through the provided
form), and toggle the two convenience links as you like. It requires core's
**JSON:API** and **Path alias** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional integrations.
2. [Configuration](configuration/index.md) — the two settings toggles and the
   OAuth key-generation form.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Lightning → API**
(`/admin/config/system/lightning/api`), requiring the **Administer site
configuration** permission. When Simple OAuth is installed, an OAuth **key
generation** form appears at `/admin/config/system/lightning/api/keys`, requiring
the **Administer simple_oauth entities** permission.

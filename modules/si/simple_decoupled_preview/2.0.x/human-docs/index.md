# Simple Decoupled Preview — manual setup guide

**Simple Decoupled Preview** (`simple_decoupled_preview`) lets editors preview
**unsaved** content in a decoupled (headless) front end. When an editor clicks
Preview in Drupal, the module sends the front end to a configured preview route
with enough context to request the draft through JSON:API, and it records every
preview attempt as a log entity so problems can be traced later. It works with any
front‑end framework (Next.js, Gatsby, or your own).

Preview is the hardest thing to keep working in a headless build: the editor is in
Drupal, the rendering happens elsewhere, and the content being previewed does not
yet exist in any saved form the front end could normally fetch. This module's answer
is to leverage Drupal's core preview system and expose node previews on JSON:API
(via the bundled **Simple Decoupled Preview JSON:API** submodule,
`simple_decoupled_preview_jsonapi`), then hand the front end a callback URL plus the
context it needs to pull the draft. In the settings you choose that callback URL,
which content types (bundles) are covered, and which relationships (JSON:API
includes) travel in the payload.

The logging half is what makes it operable. Every preview creates a
`preview_log_entity` with its own listing and Views data, so when an editor reports
"preview is broken" there is a record of what was requested and when. These log
entities are meant to be temporary: a cron task clears them, with expiry defaulting
to one day and automatic deletion on by default, so the table does not grow without
bound. Permissions are cleanly separated between administering the preview
configuration and reading the logs.

To serve previews to the front end you enable the **Simple Decoupled Preview JSON**
REST resource (GET, `json` format, and the authentication provider your front end
uses) and grant its access permission to the front end's role — the
[Configuration](configuration/index.md) guide walks through this. Note the module
has a hard dependency on **RESTUI** (`restui`) — a UI module for REST resources —
which is unusual to see in a runtime dependency list and means enabling this brings
the REST resource UI along with it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it and its JSON:API submodule, and grant the permissions.
2. [Configuration](configuration/index.md) — the settings form (callback URL,
   bundles, includes, log expiry) field by field.

## Where it lives in the admin menu

Once enabled, the settings form sits under **Configuration → Web services**:

- Settings:
  `/admin/config/services/simple_decoupled_preview/settings`
- Preview logs:
  `/admin/config/services/simple_decoupled_preview/preview/logs`

# AT-LS — manual setup guide

**AT-LS** (`at_ls`) connects Drupal to the **AT-LS translation service**. Content
and interface strings are packaged as translation requests, sent to AT-LS for
translation, and the results are imported back — all driven through a queued
workflow so large jobs process in the background rather than blocking a page load.

Under the hood the module models a *translation‑request* entity and *string*
entities, moves them through a state machine, and processes the work with the
**Advanced Queue** module. It talks to the AT-LS API using HTTP basic
authentication, and its credentials are handled through the **Key** module backed
by an environment variable — so the secret is never stored in plain, committed
configuration. It supports Drupal 9, 10, and 11.

Because it exchanges real content with an external service and holds API
credentials, treat setup carefully: keep the AT-LS secret in an environment
variable / Key entity (never in exported config or version control), and grant the
module's permissions only to the roles that should request or administer
translations.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, then enable it.
2. [Configuration](configuration/index.md) — connect to AT-LS, store the
   credentials securely, and set up the translation workflow.

## Where it lives in the admin menu

AT-LS adds translation‑request management and a connection configuration screen,
gated by its own permissions (the request form, configuration, and administering
strings/requests each have a permission). Because it builds on **Advanced Queue**,
its jobs run through the queue system at **Configuration → Advanced Queue**.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Store your AT-LS credentials in an environment variable and a Key entity, then
   enter the connection details (see [Configuration](configuration/index.md)).
3. Create translation requests for the content or strings you want translated;
   Advanced Queue sends them to AT-LS and imports the results back when ready.

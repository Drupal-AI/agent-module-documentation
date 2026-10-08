# Drupitor Client — manual setup guide

**Drupitor Client** (`drupitor_client`) exposes a secure API endpoint that
reports which Composer package updates are available for your Drupal
installation. It is the site-side companion to the external **Drupitor**
monitoring service: Drupitor calls the endpoint, reads the list of available
updates, and lets you track update status for many sites centrally.

Under the hood the module runs Composer on your server (via PHP's `proc_open()`)
to work out which packages have newer versions, then returns that list as JSON at
`/drupitor/api/v1/updates`. Because that information reveals exactly which modules
and versions you run — useful fingerprinting data for an attacker — the module
ships **disabled by default** and must be turned on deliberately, and access is
gated behind an API token. It depends only on core's System and User modules and
supports Drupal 10 and 11.

This module needs configuration before it does anything: you must enable its
functionality, set the path to your Composer executable, and provide an API
token. All of that is covered in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the endpoint, set the
   Composer path and timeout, and manage the API token.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → Development → Drupitor
Client** (`/admin/config/development/drupitor-client`).

## How to use it

After you have enabled and configured the module (see
[Configuration](configuration/index.md)), the external Drupitor service — or any
authorized client — makes an HTTP request to `/drupitor/api/v1/updates` including
the configured API token. The recommended way to pass the token is in a request
**header**; passing it as a query parameter also works but is discouraged because
it can leak into logs. The endpoint responds with JSON describing the available
Composer updates. Every operation is written to the `drupitor_client` log channel
so you can audit access and troubleshoot from **Reports → Recent log messages**.

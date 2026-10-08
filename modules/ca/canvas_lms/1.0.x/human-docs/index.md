# Canvas LMS — manual setup guide

**Canvas LMS** (`canvas_lms`) is a small base module that holds the shared
settings used by the CanvasApi family of integration modules. Here "Canvas" means
the **Canvas learning management system** (the Instructure LMS) — this is not the
Experience Builder page builder that other `canvas_*` modules extend.

On its own the module does very little: it centralises the connection
configuration (such as the Canvas API base URL and shared options) in one place,
so that the modules that actually talk to the Canvas LMS API — for example a
companion Canvas API module — all read from the same settings rather than each
carrying its own copy. Install it as the foundation when you are building a Canvas
LMS integration on your Drupal site.

Because it centralises the connection details other modules use to call the
Canvas API, keep the base URL correct, and handle any API credentials as
**secrets**: store an API token in an environment variable (with DDEV,
`ddev dotenv set .ddev/.env --canvas-api-token=<value>` then `ddev restart`) and
reference it through a Key entity in the consuming module — never paste a token
into exported configuration or commit it to version control. It has no
access‑control role of its own.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Canvas LMS is a foundation module for the CanvasApi integration modules; it
provides the shared settings those modules read. Its value comes through the
modules that consume it, so install it alongside whichever CanvasApi integration
module you actually need and configure the Canvas connection there.

## How to use it

Enable this module first, then install and enable the CanvasApi integration
module(s) that do the real work. Point the shared Canvas connection at your Canvas
LMS instance (base URL) and supply the API credentials as secrets as described
above. From then on, the integration modules use that single shared connection.

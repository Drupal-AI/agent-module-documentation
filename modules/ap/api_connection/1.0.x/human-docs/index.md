<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Connection — manual setup guide

**API Connection** (`api_connection`) is a helper module that provides a generic,
reusable way to configure and make outbound API calls — a common
connection/configuration layer that other modules can build on instead of each
integration reinventing its own HTTP client and credential handling. On its own it
adds no end-user feature; its value is to the modules that consume it.

It ships an **`api_connection_example`** submodule that demonstrates the pattern,
and its own settings are configured through the module's settings form. Building an
integration on top of it means pointing it at your endpoints and credentials and
letting it handle the request plumbing.

Because it exists to make outbound API calls, the security considerations are the
usual ones for an outbound API helper: store credentials as secrets (environment
variables or a Key entity, never hard-coded), and leave TLS certificate
verification on — the secure default — never disabling it. The module provides its
own permission for administering the connection settings. It supports Drupal 10.2
and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (optionally with the example submodule).
2. [Configuration](configuration/index.md) — the connection settings form and the
   secure way to handle credentials.

## Where it lives in the admin menu

The settings form is provided by the `api_connection.settings_form` route and is
gated by the module's own administration permission. See
[Configuration](configuration/index.md) for details.

## How to use it

API Connection is infrastructure: you configure the connection settings once, then
build (or install) modules that call external APIs through the shared layer.
Install the bundled `api_connection_example` submodule to see a working
demonstration of the pattern before wiring it into your own integration.

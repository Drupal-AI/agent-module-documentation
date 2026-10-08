# Server IP — manual setup guide

**Server IP** (`server_ip`) is a simple diagnostic module that displays the IP
address of the server handling a request. On modern hosting, a single site is
often served by several cloud servers with different IP addresses across regions,
and Server IP helps developers see exactly which backend answered — invaluable
when you are debugging a load-balanced or multi-server setup, or checking cache
and server affinity.

Out of the box it shows a handful of details useful for quick debugging: the
database host name, the database name, the current theme, the path to the theme,
and the base URL. Beyond those defaults, you can pick additional PHP `$_SERVER`
variables on a settings form, and the ones you choose are then shown on the server
details page.

This module needs a small amount of setup: it provides its own permissions, and by
default only the administrator role can reach its pages. It has no other module
dependencies and works on Drupal 8 and up.

A security note worth taking seriously: a server's IP address is minor but real
infrastructure information. Keep its display gated to trusted administrators via
the module's permissions, and do not expose backend IPs publicly — they can help
an attacker map your infrastructure. The module plays no access-control role
beyond its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which `$_SERVER` variables to
   show and control who can see them.

## Where it lives in the admin menu

- **Server Settings** — **Configuration → Server Settings** (choose which
  variables to display).
- **Server Details** — **Configuration → Server Settings → Server Details** (the
  page that shows the server IP and the selected details).

## How to use it

Open **Server Details** to see the server's IP address and the configured details.
On a load-balanced site, reloading and watching which IP appears tells you which
backend served the request.

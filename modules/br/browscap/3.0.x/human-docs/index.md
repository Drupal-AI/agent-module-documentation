# Browscap — manual setup guide

**Browscap** (`browscap`) provides a replacement for PHP's built‑in
`get_browser()` function. It detects a visitor's browser and device capabilities
from the user‑agent string using data from the
[Browser Capabilities Project](https://browscap.org/), so your code can find out
what browser or device someone is using — and what it supports — **without**
relying on the server's PHP `browscap` configuration being set up.

Instead of depending on server‑level configuration, the module maintains its own
copy of the browscap data, which is downloaded and refreshed periodically. Your
code queries that data to make presentation or feature decisions based on the
visitor's browser.

One caveat worth keeping in mind: browser detection is based on the user‑agent
string, which is a heuristic and can be spoofed. Use the results for presentation
and feature choices, not for anything security‑sensitive — the module has no
content‑access role. It provides its own permissions and belongs to the Developer
Tools package, supporting Drupal 8.8 through 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — the settings page for the browscap
   data source and how the data is kept up to date.

## Where it lives in the admin menu

Browscap's settings form is registered at the `browscap.admin` route, reached under
**Configuration → Development** (Browscap settings). Its permission is granted under
**People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings page and confirm the data source and update behavior (see
   [Configuration](configuration/index.md)), then let the module download the
   browscap data.
3. From your own code, query the module for the visitor's browser/device
   capabilities and use the result for presentation or feature decisions.

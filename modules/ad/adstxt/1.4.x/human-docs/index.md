# ads.txt — manual setup guide

**ads.txt** (`adstxt`) lets you manage the IAB **`ads.txt`** and **`app-ads.txt`**
files for a Drupal site from the admin UI. Instead of dropping static files into
your docroot, the module serves them dynamically at `/ads.txt` and `/app-ads.txt`
straight from Drupal configuration. That's particularly handy in multisite setups,
where each site needs its own file, and for teams who'd rather edit the
authorized‑sellers list through the web UI than over SSH.

`ads.txt` (Authorized Digital Sellers) is an IAB standard that lets publishers
declare which ad exchanges and resellers are allowed to sell their inventory,
reducing ad fraud. `app-ads.txt` is the equivalent for mobile and connected‑TV app
inventory. This module keeps both under Drupal's configuration management, so they
are exportable and can be promoted between environments like any other config.

Developers can also append lines programmatically from other modules via
`hook_adstxt()` and `hook_app_adstxt()`, so a base list in config can be combined
with dynamically computed lines. On install, the module seeds its content from any
existing `ads.txt` it finds in the docroot, and it runs health checks that warn you
about common misconfigurations (see below). It has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the two output
   URLs, and the requirements checks.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → System → ads.txt**
(`/admin/config/system/adstxt`), gated by the **Administer ads.txt** permission.
The generated files are served publicly at `/ads.txt` and `/app-ads.txt`.

## How to use it

Grant the **Administer ads.txt** permission to whoever manages ad partners (this
can be a non‑developer marketing/ops role), open the settings form, paste in your
authorized‑sellers lines, and save. The files are then live at `/ads.txt` and
`/app-ads.txt`. See [Configuration](configuration/index.md) for details, including
two important health‑check warnings.

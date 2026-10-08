# Prod Should not Redirect to Installer — manual setup guide

**Prod Should not Redirect to Installer** (`prod_no_redirect`) is a small
production-hardening module. It stops a production site from redirecting visitors
to `install.php`. If a production Drupal site ever loses its database or all of
its tables in an emergency, core's default behaviour is to redirect everyone to
the installer — which turns a bad moment worse by exposing the install page (and
the risk of an installation hijack or information disclosure) to the public. This
module prevents that redirect so a broken production site fails safe instead of
offering itself up to be re-installed.

It's purely an operations/security safeguard: it carries no content, adds no
front-end features, and has no access-control role of its own. It supports Drupal
9, 10, and 11.

One thing sets this module apart from a normal "enable and go" module: making it
effective requires a **small manual edit to your site's front controller**
(`index.php`), described in Installation. Enabling the module alone is not enough.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   make the required `index.php` change.

There is **no configuration page** for this module — the only setup beyond
enabling it is the front-controller edit described in Installation.

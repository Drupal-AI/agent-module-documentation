# W3C Validator — manual setup guide

**W3C Validator** (`w3c_validator`) runs your site's own pages through a W3C
Markup Validator and reports how standards-compliant the HTML is. It gathers the
front page plus every node (and, if you ask, admin and routed pages), submits
each one to a validator endpoint, and shows the results — errors, warnings and
info — in a colour-coded admin report under **Reports**. A batch "re-validate all
pages" operation refreshes the whole set in one run.

Under the hood it wraps the `rexxars/html-validator` PHP library (installed with
the module via Composer) and stores each page's outcome so the report can show
which pages are Valid, Invalid, Outdated or Unknown, with the specific messages
expandable per row. You point it at a validator endpoint in the settings form; if
you leave that blank it falls back to the public `validator.nu` service, which is
fine for the occasional check but rate-limited — for any volume the module
recommends (and warns you toward) a self-hosted `w3c_markup_validator` instance.

An optional token feature lets the validator see access-restricted pages "as the
current user" during a run, so it validates the real markup an editor would see
rather than an anonymous view. Everything is gated behind a restricted admin
permission. There are no submodules and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its validator
   library with Composer, and enable it.
2. [Configuration](configuration/index.md) — the settings form (endpoint, token,
   admin pages) and how to run a validation batch, field by field.

## Where it lives in the admin menu

- **Settings:** **Configuration → Development → W3C Validator**
  (`/admin/config/development/w3c_validator`).
- **Report & validation runs:** **Reports → W3C Validator**
  (`/admin/reports/w3c_validator`).

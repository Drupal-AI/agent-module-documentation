# monday.com CRM integration — manual setup guide

**monday.com CRM integration** (`monday_crm_integration`) relays Drupal
**Webform** submissions straight into [monday.com](https://monday.com) boards
through monday.com's GraphQL API. Each submission becomes a tracked board item,
with a field-to-column mapping you control — so a contact form, application form
or request form on your site can feed leads and tasks directly into the board
your team already works from.

The relay is implemented as a **Webform handler plugin**, not a global feature.
You attach the "monday.com — Create board item" handler to any webform, and each
attachment is configured independently: which board to target, how each Drupal
field maps to a monday.com column, how the item's name is built from submitted
values, and what should happen if monday.com is briefly unreachable. You can
attach it to as many webforms as you like, each pointing at a different board with
a different mapping.

This module needs configuration before it does anything: you provide your
monday.com **API token** (kept out of exported config — see below) and then set up
the handler on each webform. It depends on the contributed **Webform** module and
core's **Options** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your API token safely, attach the
   handler to a webform, and map fields to columns.

## Where it lives in the admin menu

There is **no global configuration page**. Every setting lives on the handler you
attach to an individual webform, under **Structure → Webforms → *(your form)* →
Settings → Emails / Handlers**. The monday.com API token is not stored in the UI
at all — it is read from Drupal's Settings API (`settings.php`), so it never lands
in `config:export` output or your repository. See
[Configuration](configuration/index.md).

# Make Integration — manual setup guide

**Make Integration** (`make`) connects your Drupal site to the Norwegian
[Make](https://make.as) newsletter service. Once configured, it can fetch your
Make subscriber lists, present a signup form to your visitors, and push new
subscribers straight into Make.as — so people who sign up on your site land in
the mailing list you manage there.

You supply your Make **User ID** and **API Key**, authenticate, then choose which
subscriber list new signups should join and which fields the signup form should
collect. The form itself is placed on your site through the **Make Signup Block**,
which you can drop into any block region.

At the moment the module covers newsletter integration only; the maintainers note
that SMS integration is on the roadmap but not yet built. It depends on core's
**Field** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Make credentials, pick a
   subscriber list, choose form fields, and place the signup block.

## Where it lives in the admin menu

Settings live at **Configuration → Web services → Make**
(`/admin/config/services/make`). The subscription form is placed separately from
**Structure → Block layout**, where you add the **Make Signup Block** to a
region.

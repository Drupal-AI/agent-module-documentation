# Sendinblue - Digital Marketing Tools — manual setup guide

**Sendinblue - Digital Marketing Tools** (`sendinblue_api`) connects your Drupal
site to **Sendinblue** — now rebranded **Brevo** — using version 3 of its
marketing API. It lets you push contacts from Drupal into Sendinblue/Brevo lists,
embed newsletter signup forms and blocks, and connect Drupal to Sendinblue's
transactional and marketing email (and, where supported, SMS) features.

Once you've added your API key and authorized the connection, you enable the
Sendinblue lists you care about. Each enabled list becomes available as a **block
derivative** you can place on the site, as a target for a **Webform handler**
(so form submissions add subscribers), and as a **content‑type field** so you can
attach list membership to content. There's also an optional **REST endpoint** for
sending signups to enabled lists.

The API key authenticates every call and should be stored as a secret — the module
supports adding it to `settings.php` (a `$settings['sendinblue_api']` array) or via
the admin UI. Two things to know from the module's own notes: its info file has a
typo in the dependencies key (`depencencies`), so its declared dependence on the
core **Block** and **REST** modules may not be enforced automatically — make sure
those are enabled if you need them. And because contact data (emails, names) is
transmitted to and stored by Sendinblue/Brevo, mind the usual consent/GDPR
considerations. The module provides a permission to administer its settings, runs
on Drupal 10.1+ and 11, and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and enable the Block/REST dependencies you need.
2. [Configuration](configuration/index.md) — add your API key, enable lists, and
   wire up blocks, webform handlers, and fields.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Web services → Sendinblue**
(`admin/config/services/sendinblue-api`, the `sendinblue_api.config` route), with
the list‑management screen at `admin/config/services/sendinblue-api/lists`.

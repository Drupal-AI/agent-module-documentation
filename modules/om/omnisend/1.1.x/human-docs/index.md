# Omnisend — manual setup guide

**Omnisend** (`omnisend`) connects your Drupal site to the
[Omnisend](https://www.omnisend.com) email/SMS marketing platform. Its main job is to
capture form submissions and push them into Omnisend as contacts, so signups
collected on your site flow straight into your marketing automations. It also
surfaces your Omnisend lists and campaigns in an admin dashboard inside Drupal.

The integration is built around the
[Webform](https://www.drupal.org/project/webform) module: it provides a **Webform
handler** you add to a form, which sends each submission to Omnisend on submit,
creating or subscribing the contact. You map which webform fields become which
Omnisend contact properties — standard fields (email, name, address, demographics)
via a select list, or custom fields via a small YAML mapping syntax. Behind the
scenes an `OmnisendApi` service talks to Omnisend's REST API to sync contacts and
fetch lists and campaigns.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Webform.
2. [Configuration](configuration/index.md) — add your Omnisend API key and connect a
   Webform.

## Where it lives in the admin menu

- Settings (API key): **Configuration → Web services → Omnisend**
  (`/admin/config/services/omnisend`), behind the **Administer site configuration**
  permission.
- Campaign dashboard: `/admin/omnisend/campaigns`.

> **Heads‑up on the dashboard permission:** the dashboard/campaign routes reference an
> `access omnisend dashboard` permission that isn't actually defined by the module, so
> in practice those pages are reachable only by the superuser (user 1) until that
> permission is provided.

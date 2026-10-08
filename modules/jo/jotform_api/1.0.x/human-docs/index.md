# Jotform API — manual setup guide

**Jotform API** (`jotform_api`) renders Jotform forms as **native Drupal forms**
via the Jotform REST API — no iframes and no embed codes. The form's structure,
validation rules, and thank‑you behaviour are read live from your Jotform account,
and submissions are processed inside Drupal, then explicitly handed off to trigger
your Jotform automations so downstream CRM and workflow steps don't get dropped.

Because forms are real Drupal forms rather than embeds, you get server‑side
validation and proper integration with the rest of your site. Highlights include:

- **API‑driven rendering** with 15 built‑in field‑type renderers, extensible for
  custom widgets via a plugin.
- **Three placement options** — as a **block**, as a **content‑entity field**, or
  auto‑routed at **`/jotform/{form_id}`**.
- A **webhook receiver**, IP **rate limiting**, and a configurable **cache** with an
  admin "Refresh" action.
- Event‑driven extension points, so tracking integrations (Meta CAPI, GTM,
  Rudderstack, and so on) can plug in without forking the module.

Your Jotform **API key is stored securely through the Key module** (never committed
to code), and the module depends on core `system` and on `key`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it needs the Key module).
2. [Configuration](configuration/index.md) — store your API key, configure the
   connection, and place a form.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Jotform API**
(`/admin/config/services/jotform-api`). The module also provides its own
permissions, managed at **People → Permissions**.

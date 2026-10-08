# Decoupled JSON Log — manual setup guide

**Decoupled JSON Log** (`decoupled_json_log`) gives you a self‑hosted place to
collect **front‑end error logs** from a decoupled or mobile app — directly into
Drupal, with no third‑party logging service and no per‑event billing. It is aimed
at small‑scale apps where you would rather keep your users' crash data on your own
server (and perhaps save a little money) than ship it off to a SaaS.

It works by providing a **`log_json` content entity type** with REST and JSON:API
endpoints for uploading logs. Your front end POSTs a JSON payload — typically a
stringified JavaScript `Error` plus some device info, stored in two JSON fields
(`log` and `device_info`) — and Drupal stores it as an entity. Because logs are
just ordinary entities, you can use Views, bulk operations, and other contrib
modules (for example ECA) to build dashboards or trigger email alerts on new
entries. The default bundle is `error`, and you can create additional log‑type
bundles (say `warning` or `notification`) to categorize what you collect.

The security posture is intentionally locked down. A route subscriber removes the
JSON:API **PATCH** and **DELETE** routes and gates **GET** behind the *Administer
log_json types* permission, so entries can be **written but not listed, edited, or
deleted through the API** — reviewing and managing logs is an admin‑only,
in‑Drupal task. Only POST/create is exposed (REST offers POST only too). A per‑user
**rate limit** caps how many entries each account (and the shared anonymous
account) may create per rolling interval, and a **payload‑size cap** rejects
oversized entries. Server‑side, `preSave()` always stamps the author (`uid`) and
creation time (`created`), so clients cannot spoof them to dodge the limit. Because
it stores entries as JSON, the module depends on the **JSON Field** module
(`json_field`).

> **What's new in 1.1.x (versus 1.0.x).** This release runs on **Drupal 11.3+ or
> Drupal 12** and requires **PHP 8.5+** and JSON Field **^1.7** (1.0.x targets
> Drupal 11.2). The rate limit is now applied **per log type (bundle)**, so one
> bundle's traffic can never consume another's allowance, and **each log type can
> override** its own count and interval — setting a type's count to `0` rejects
> every client submission to it, which is handy for server‑only log types
> (programmatic `save()` skips entity validation, so server writes still succeed).
> Payload‑size enforcement is handled by a dedicated `MaxPayloadSize` validation
> constraint on both JSON fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (and JSON Field),
   enable it, and grant the create permission.
2. [Configuration](configuration/index.md) — the rate‑limit and payload‑size
   settings, per‑type overrides, permissions, and log types.

## Where it lives in the admin menu

- **Settings** (default rate limits, payload sizes):
  **`/admin/config/decoupled_json_log`** (permission *Administer log_json types*).
- **Log types (bundles)** and their per‑type overrides:
  **`/admin/structure/log_json_types`**.
- **Permissions:** **People → Permissions** (`/admin/people/permissions`) — grant
  *Create json logs* to the roles that should be able to log.
- **Review entries:** as an admin at **`/admin/content/log-json`** — not through
  the API.

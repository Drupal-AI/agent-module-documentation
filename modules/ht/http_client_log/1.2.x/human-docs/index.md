# HTTP Client Log — manual setup guide

**HTTP Client Log** (`http_client_log`) records the outbound HTTP requests your
site makes through Drupal's HTTP client (`\Drupal::httpClient()`) and stores each
one as an entity, with a listing and per-request detail pages you can browse in the
admin UI. When an integration misbehaves — a payment gateway rejects a call, a CRM
sync writes the wrong records, an API returns a 400 whose body nobody kept — this
log shows you exactly what your site sent and what came back. The provider's own
dashboard only ever shows their side, and never shows what your site actually
transmitted.

Because the log is made of entities, access is controlled through Drupal's entity
access system rather than a single flat permission, and you get a proper listing
with filters and detail views at **`/admin/reports/http-client-log`**.

**Please read the privacy warning first, because a request log is the most
sensitive log a Drupal site can keep.** Outbound requests carry `Authorization`
headers, API keys and bearer tokens; their bodies carry whatever is being
synchronized — which for a CRM or payment integration is personal and financial
data — and the responses carry the same. A complete log is therefore effectively a
**credential store and a copy of your data**, sitting in the database, in every
backup, readable by anyone who holds the permission. Three practical consequences:

1. **Redact headers and bodies rather than storing them whole**, or accept that the
   log needs the same protection as the credentials inside it.
2. **Keep it off production** — or enable it deliberately and briefly for a specific
   investigation. That is exactly what its "Development" package placement implies.
3. **Set a retention limit.** With no expiry, a busy integration will grow this
   into the largest table in your database.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and the log viewer,
   with the privacy precautions to take.

## Where it lives in the admin menu

The log viewer sits under **Reports → HTTP Client Log**
(`/admin/reports/http-client-log`). From there you can filter the logged requests
and open any entry to see its full details.

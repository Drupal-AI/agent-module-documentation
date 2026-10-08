# Site — manual setup guide

**Site** (`site`) gives your Drupal site a "self-awareness" entity. When you enable
it, the module creates a **Site entity** that records facts about this very
installation — its Drupal and PHP versions, install time, last cron run, Git remote
and reference, host provider, the site UUID, HTTP status, and more — together with an
overall **Site State** of *OK*, *Warning*, or *Error* and a human-readable reason for
that verdict. Because the entity is revisionable, each saved snapshot becomes a
historical record you can look back through.

The state itself is computed by pluggable handlers: core's own Status Report, the
Site Audit module's checks, or custom SiteState/SiteProperty plugins you write. A
status indicator appears in the admin toolbar, and Status, History, Settings, and
Edit pages live under `/admin/site`. The entity is also fieldable, so you can attach
any extra information you want to track and display.

Where Site becomes powerful is remote reporting. It can POST its data to a central
**Site Manager** instance (self-hosted, or the hosted Sites.Watch service) so many
sites and environments report into one dashboard — a lightweight CI/operations view.
It exposes a Site API over JSON:API (`/jsonapi/self`, and `/jsonapi/action/{plugin_id}`
to run Site Action plugins), and a receiving Site Manager can optionally push back
overrides for selected config, fields, or state. It is part of the wider Drupal
Operations Platform. Note that Site pulls in several dependencies — `key_auth`,
`rest`, `jsonapi`, `serialization`, `eva`, `options`, `field_ui`, and
`admin_toolbar_tools` — so it is a more substantial install than a single-purpose
module.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its dependencies.
2. [Configuration](configuration/index.md) — the first-run setup at `/admin/site`,
   state handlers, remote reporting, and the Site API.

## Where it lives in the admin menu

Once enabled, a site-status indicator sits in the **admin toolbar**, and the Site
entity's own pages live under **`/admin/site`** — the Status/About page at
`/admin/site/about`, plus History, Edit, and Save actions, each gated by its own
permission.

## A note on access and the API

Every Site UI and API route is permission-gated, and the JSON:API endpoints require
explicit permissions (`access site data api`, `access site actions pages`) and
support basic-auth, cookie, `key_auth`, and IP-consumer authentication. One
permission to grant sparingly is `bypass site action user login password
requirement`, which relaxes the password check on the built-in User Login action —
only hand it out when you deliberately intend that behavior.

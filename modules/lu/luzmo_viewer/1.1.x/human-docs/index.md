# Luzmo Viewer — manual setup guide

**Luzmo Viewer** (`luzmo_viewer`) adds a custom **field** that embeds a
[Luzmo](https://www.luzmo.com) dashboard on your content. Luzmo is an embedded
business‑intelligence / analytics platform; with this module a content editor can
drop an interactive Luzmo dashboard — charts, reports, filters — straight into a
node or any other fieldable entity, rendered through Luzmo's JavaScript embed API.

Dashboards can be shown in two ways. The simplest uses an **integration key and
token** created in your Luzmo account to display a specific dashboard. For more
control — for example when different visitors should see different data — you can
have the field request an **authorisation** (an embed token) at display time,
passing per‑user information so Luzmo returns data scoped to that viewer.

Setup has two halves: configure the module‑wide connection settings once (your
Luzmo API key and token, and where the Luzmo embed library and app server live),
then add a Luzmo viewer field to your entity and enter a dashboard ID on each
piece of content.

> **Handle the Luzmo credentials as secrets.** The API key and token are
> account‑level credentials that must never be committed to your repository —
> store them in an environment variable and, where possible, a Key entity. The
> [Configuration](configuration/index.md) page covers this. Also be aware the
> embed calls reach out to Luzmo's servers, so the site (and, for remote library
> use, the visitor's browser) needs outbound access to Luzmo.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Luzmo connection details
   (stored securely), then add and display a Luzmo viewer field.

## Where it lives in the admin menu

The module‑wide settings are at **Configuration → System → Luzmo settings**
(`/admin/config/system/luzmo-settings`). The field itself is added and displayed
through the normal **Manage fields** / **Manage display** screens on your content
type or other entity.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your Luzmo API key and token in the settings form and save (see
   [Configuration](configuration/index.md)).
3. In Luzmo, create an integration
   ([app.luzmo.com/integrations](https://app.luzmo.com/integrations)), pick the
   dashboard(s) to embed, and note the key and token. (You can add more
   dashboards later without regenerating the key and token.)
4. Add a **Luzmo viewer** field to your content type, then enter a dashboard ID
   on each piece of content. On the field's display you can choose whether the
   formatter should request an authorisation.

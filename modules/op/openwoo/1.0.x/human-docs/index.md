# OpenWoo — manual setup guide

**OpenWoo** (`openwoo`) helps Dutch government organisations meet their obligations
under the **Wet open overheid** (WOO — the Dutch Open Government Act) by publishing
and searching open-government publications in the standard WOO format. It is built
as a **pluggable framework**: the base module holds your organisation's details,
and content providers (search and publish targets) are added as plugins. The first
supported provider is [OpenWoo.app](https://openwoo.app/), with a WooGLe
integration planned.

The base module gives you an **organisation settings** page whose fields can be
pre-filled from the Dutch [OIN register](https://oinregister.logius.nl/). Two
submodules build on it:

- **OpenWoo Search** — adds a pluggable search provider and a **search block** with
  filters for year, category, and a free-text field, so visitors can search
  published WOO documents.
- **OpenWoo Publish** — adds a custom publication entity type, shown as a tab on the
  **Content** page with basic create/edit/delete and a published/unpublished
  toggle. Files are attached as a dedicated media type with the required metadata,
  and when a publication is created the publish plugin pushes it to the configured
  provider (OpenWoo.app) on the next cron run.

By design this module **publishes public government documents** — that is its whole
purpose — so the content it exposes is meant to be open. What needs care is the
**API key** used to talk to OpenWoo.app: it is a credential and is entered in
`settings.php` rather than the UI. See [Configuration](configuration/index.md) for
how to set it and keep it out of version control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Development status:** OpenWoo is under active development and this is a beta
> release. Planned features (resumable large-file uploads, external attachment
> storage, and a WooGLe plugin) are not all in place yet.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose the Search and/or Publish submodules.
2. [Configuration](configuration/index.md) — set up the organisation, choose a
   client, add the API key, and place the search block.

## Where it lives in the admin menu

- **Configuration → Web services → OpenWoo** (`/admin/config/services/openwoo`) —
  the organisation settings.
- **Configuration → Web services → OpenWoo → OpenWoo Search**
  (`/admin/config/services/openwoo/openwoo-search`) — choose the search client.
- **Configuration → Web services → OpenWoo → OpenWoo Publish**
  (`/admin/config/services/openwoo/openwoo-publish`) — choose the publish client
  and endpoint.
- **People → Permissions** (`/admin/people/permissions#module-openwoo`) — the
  module's permissions.
- **Content → OpenWoo publications** (`/admin/content/openwoo/publications`) —
  create and manage publications (Publish submodule).
- **Structure → Block layout** (`/admin/structure/block`) — place the OpenWoo
  search block (Search submodule).

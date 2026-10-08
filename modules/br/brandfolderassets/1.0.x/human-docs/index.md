# Brandfolder Assets — manual setup guide

**Brandfolder Assets** (`brandfolderassets`) lets editors pick media from the
Brandfolder digital asset management (DAM) service and attach it to content
through a field. It adds a field type, a widget, and a formatter, plus an AJAX
modal that lists Brandfolder assets — images, videos, PDFs — with search and
pagination. When an editor selects an asset, the module downloads it from
Brandfolder's CDN into your site's files directory and stores it as a managed
file.

It builds on the separate **Brandfolder** module (`brandfolder`), and it reuses
that module's API key to talk to Brandfolder — so you configure the connection in
the Brandfolder module first, then use this one to place a picker field on your
content types.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (including the Brandfolder
   module), installing with Composer, and enabling the module.
2. [Configuration](configuration/index.md) — the settings form, plus adding the
   field to a content type.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → Media → Brandfolder
Assets** (`/admin/config/media/brandfolderassets`). The Brandfolder API key
itself is configured in the **Brandfolder** module, not here. You place the field
on content types through the **Field UI**.

## How to use it

First configure the Brandfolder connection (API key, default brandfolder) in the
Brandfolder module. Then add a **Brandfolder Assets** field to a content type via
the Field UI. When editing content, the field opens a modal that lists your
Brandfolder library; search or page through it, pick an asset, and the module
downloads it into your site's files and stores it as a managed file that your
content references.

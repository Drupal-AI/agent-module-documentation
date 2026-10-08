# AI Single Page Importer — manual setup guide

**AI Single Page Importer** (`ai_single_page_importer`) lets an editor paste in
an external web page URL; the module fetches that page and uses AI to read its
content and populate the fields of a new **article** node — title, body, and
any other fields you have mapped. It is a fast way to turn a single web page
into structured Drupal content instead of copying and pasting by hand.

Two things are worth understanding before you use it. First, the site's server
makes an outbound HTTP request to the URL an editor supplies, so grant the
import permission only to **trusted editors** and import only from **sources you
trust**. Second, the fetched page content is sent to the configured AI provider
to be mapped into fields, which is an external call that **costs money** per use
and means the content leaves your site.

The module depends on core's **Node** module and the **AI** module, and it
supports Drupal 10, 11, and 12. The provider API key is stored as a secret in
the AI module's configuration, never by this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the AI module and permissions are set up.

## Where it lives in the admin menu

Access is governed by two permissions:

- **`use ai single page importer`** — lets a user open the importer and run an
  import. Grant this only to editors you trust, because they choose the URL the
  server will fetch.
- **`administer ai single page importer settings`** — lets an administrator
  manage the importer's settings, including how the page's content is mapped
  onto article fields.

An AI **provider** must also be configured under **Configuration → AI**
(`/admin/config/ai`) with its API key stored as a secret.

## How to use it

An editor with the use permission supplies the URL of a web page. The module
fetches the page server-side, sends its content to the AI provider, and fills in
the mapped fields for the editor to review. Always **review the imported content
before publishing** — the mapping is produced by a language model and may
misread or misplace content — and only import from sources you trust, since the
URL is fetched by your server.

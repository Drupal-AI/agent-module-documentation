# Ray Enterprise Translation (Lingotek) — manual setup guide

**Ray Enterprise Translation** (`lingotek`, formerly branded **Lingotek**)
connects your Drupal site to the Ray Enterprise **Translation Management System
(TMS)**. Rather than translating everything by hand in Drupal's own UI, you enrol
content in **translation profiles** that decide when it uploads, whether it is
translated by machine or by professional translators, and which target languages
apply. A dashboard tracks the state of every document, and a job‑management layer
groups work for a translation vendor.

It handles the whole multilingual pipeline in one place: **content entities**
(nodes, comments, taxonomy terms, paragraphs, and more), **configuration entities
and items** (fields, blocks, views, site name, system emails, and so on), and the
**interface strings** — all uploaded, translated, and pulled back through the same
system. The integration is bidirectional: Ray Enterprise calls a webhook on your
site (`/lingotek/notify`) when a document changes state, so translations flow back
automatically.

> **This module sends your content to a third‑party service.** When content,
> configuration, or interface strings are uploaded for translation, that data
> leaves your site and is processed by the Ray Enterprise TMS (and any translation
> vendor you use). Make sure that is acceptable for the material you are
> translating before you connect an account, and treat your Lingotek/Ray
> Enterprise API credentials as secrets — store them in an environment variable
> and a Key entity, never hard‑coded or committed. The
> [Installation](installation/index.md) page shows the DDEV‑friendly way to do
> this.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and its multilingual dependencies, and store your credentials safely.
2. [Configuration](configuration/index.md) — connect your account, set up
   translation profiles, enable content and config for translation, and wire up
   the notification callback.

## Where it lives in the admin menu

The module's dashboard and settings live under **Translation** at
`/admin/lingotek` (the configure route is `lingotek.settings`). Content and
configuration translation are managed from there and from the standard core
translation UIs.

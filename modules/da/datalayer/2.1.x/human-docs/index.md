# Data Layer — manual setup guide

**Data Layer** (`datalayer`) builds a JavaScript `window.dataLayer` array on each
page and pushes an object of Drupal page and entity metadata into it. That gives
client-side tools — Google Tag Manager, analytics scripts, personalization and
A/B testing vendors — a structured, server-rendered snapshot of what the visitor
is looking at, without you writing any custom dataLayer JavaScript.

On every non-admin page the module prints a small inline `<script>` at the bottom
that runs `window.dataLayer = window.dataLayer || []; window.dataLayer.push({…})`.
The pushed object always includes site-wide defaults (site name, language,
country, and the current user's uid). When a content entity is the subject of the
page's route, it also adds that entity's metadata: type, bundle, id, and title,
plus any entity properties, referenced taxonomy terms, and individually opted-in
field values you have configured.

Almost everything about the output is configurable from one settings form. You can
turn entity metadata on or off, include taxonomy terms, expose specific fields,
emit information-architecture categories derived from the URL, expose limited
current-user detail on chosen URL patterns, and load Google's optional
`data-layer-helper` library. Crucially, the **JSON key names are configurable**
too (for example renaming `entityType` to `contentType`), so you can match an
existing GTM data-layer contract. The payload is assembled in a lazy builder with
a per-user cache context, so it stays correct for each user while the rest of the
page still caches.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus how to expose an individual field's value.

## Where it lives in the admin menu

The settings form sits at **Configuration → Search and metadata → Data Layer**
(`/admin/config/search/datalayer`), gated by the core *Administer site
configuration* permission.

## How to use it

Enable the module, open the settings form, and choose what to include in the
payload. Then verify the result by loading a page and reading `window.dataLayer`
in your browser's console — or by configuring your tag manager to read the keys
you have exposed. The [Configuration](configuration/index.md) page covers each
option.

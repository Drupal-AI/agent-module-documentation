# Cocoon Media Management — manual setup guide

**Cocoon Media Management** (`cocoon_media`) connects Drupal to the **Cocoon**
digital asset management (DAM) service at use-cocoon.nl. It is the official
integration: editors browse the assets stored in your hosted Cocoon account —
searching by tag or set — and import the ones they need straight into Drupal's
media library, where they become ordinary media entities. Brand assets stay
centrally managed in Cocoon, but they are reachable from inside the Drupal media
UI.

It works as a media source and browser backed by Cocoon's SOAP web service.
Editors search Cocoon tags/sets and pick files; the module fetches thumbnails and
originals from your Cocoon subdomain and creates media entities for the imported
items. Results are cached to reduce round-trips to the Cocoon service.

The module needs configuration before it does anything: you enter your Cocoon
**subdomain**, **username**, and **API secret key**, which it uses to
authenticate to the SOAP service over HTTPS (requests are signed with a SHA1
hash). Only the media itself is exchanged — per the maintainers, no personal data
is sent to the web service. The secret key is stored in module configuration, so
treat exported configuration as sensitive.

A couple of things to be aware of: the module needs the PHP **SOAP extension**
enabled on your server, and it exposes one small **tag-autocomplete endpoint that
is open to anonymous users** — it returns Cocoon tag names, a minor disclosure
worth knowing about if your tag names are themselves sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, confirm the PHP
   SOAP extension, and enable the module.
2. [Configuration](configuration/index.md) — enter your Cocoon subdomain,
   username, and API secret key, and grant the import permission.

## Where it lives in the admin menu

The settings form sits at **Configuration → Media → Cocoon Media**
(`/admin/config/media/cocoon_media_settings`), reachable by users with the
**Administer Cocoon media configuration** permission. Editors add assets at
`/media/add/cocoon_media_add` if they have the **Add Cocoon media items**
permission.

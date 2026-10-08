# Site Verification — manual setup guide

**Site Verification** (`site_verify`) helps you prove to search engines and webmaster
services — Google Search Console, Bing Webmaster Tools, Yandex Webmaster, and others —
that you own the site. Those services ask you to confirm ownership in one of two ways:
add a special `<meta>` tag to your home page, or serve a small verification file at a
specific path off your domain root. This module handles both, without you having to
edit a theme template or drop a file onto the server.

Each verification you set up is stored as a small configuration record. A record is
either a **meta** type (a `<meta name="…" content="…">` tag that the module injects
into the front page only) or a **file** type (plain-text content served at a route
matching the filename the service gave you, for example `/BingSiteAuth.xml`). You can
add, edit, temporarily disable, re-enable, and delete these records from one admin
listing. The add/edit form is forgiving: you can type the values in by hand, paste the
whole `<meta …>` tag copied from a webmaster console and let the module parse it, or
upload the verification file and let it read the name and contents for you.

The module works once enabled, but it does nothing visible until you create at least
one verification and enable it — only enabled records are attached to the front page
or served as a file route. It has no third-party dependencies and adds no submodules.
Access is split across two permissions so you can let a broad role manage meta-tag
verifications while keeping the more sensitive file-serving type to trusted users only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the config entity fields,
routes, and validation constraints — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add and manage verifications, and the
   difference between meta-tag and file verification.

## Where it lives in the admin menu

Once enabled, the verifications listing sits at **Configuration → Search and metadata
→ Verifications** (`/admin/config/search/verifications`). That one page is where you
add, edit, enable, disable, and delete every verification record. There is no separate
global settings page — the listing and the add/edit forms are the entire UI.

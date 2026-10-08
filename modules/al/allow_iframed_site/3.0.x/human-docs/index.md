# Allow site to be iframed — manual setup guide

**Allow site to be iframed** (`allow_iframed_site`) lets you embed chosen pages of
your Drupal site inside an `<iframe>` on another website. By default Drupal sends an
`X-Frame-Options: SAMEORIGIN` header on every page, which browsers honor by
**refusing** to display those pages inside a frame on a different domain — a
deliberate protection against clickjacking. This module removes that header on the
specific paths you nominate, so those — and only those — pages become embeddable.

The typical use is a page you *want* other people to embed: a widget, a status
board, an interactive map, or an `/embed/*` path built specifically to be dropped
into a partner's site or a CMS you don't control. You list those paths on a small
settings form, and Drupal keeps protecting everything else.

Path selection uses Drupal's familiar **Request path** condition, so you can list
exact paths, use wildcards like `/embed/*`, reference the front page with
`<front>`, and optionally **negate** the match (strip the header everywhere *except*
the listed pages).

**A word of caution, because it is the whole point of the module:** removing
`X-Frame-Options` re-exposes those pages to clickjacking, where an attacker frames
your page invisibly and tricks a user into clicking something. Scope the allowed
paths as tightly as you can, and never open up authenticated or admin pages for
framing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which paths may be framed, and
   understand the security trade-offs.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Allow site to be iframed**
(`/admin/config/system/allow_iframed_site`), gated by the core **Administer site
configuration** permission (the module defines no permissions of its own).

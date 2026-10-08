# Segmentio — manual setup guide

**Segmentio** (`segmentio`) integrates Segment's `analytics.js` into your Drupal
site so you can pipe analytics events to any service Segment connects to — Google
Analytics, Mixpanel, and many others — using only a **write key**, with no
per-service code. Set up Segment once, and you can add or swap downstream
analytics and marketing tools by changing the Segment configuration rather than
touching your site.

Segment lets you send `identify`, `page`, `track`, `group`, and `alias` calls to
many destinations from a single snippet. This module attaches Segment's library to
your pages and passes the configured write key plus a payload of tracking data
into `drupalSettings`, where the JavaScript picks it up. The payload is assembled
from pluggable callbacks: out of the box, one adds the current user's ID plus
their **name and email** as identify traits, and another adds page category, name,
and node properties on node pages. Which callbacks run is up to you — you enable
them on the settings form. There is also a privacy option, on by default, that
suppresses tracking when the browser sends a Do-Not-Track (`DNT`) header, and
developers can queue custom `track` events from code.

One thing to weigh before enabling the user callback: when it is on, the
authenticated **user's name and email are written into the page's `drupalSettings`
(visible in the page source) and sent to Segment**. That is a privacy and GDPR
consideration — treat it as PII leaving your site. Note too that a Segment write
key is, by design, public on the client side; that is how `analytics.js` works and
is not a flaw, but it does mean the key is not a secret.

This module is **maintenance-only** and is seeking a co-maintainer; it works, but
do not expect active feature development.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent — including the developer API for custom
tracking callbacks — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form: write key,
   privacy/Do-Not-Track, and which tracking callbacks to enable.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Segmentio**
(`/admin/config/system/segmentio`), gated by the **Administer Segmentio**
(`administer segmentio`) permission. Once a write key is set, the Segment snippet
is attached to your pages automatically.

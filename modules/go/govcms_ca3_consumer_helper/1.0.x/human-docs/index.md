# GovCMS CA3 Consumer Helper — manual setup guide

**GovCMS CA3 Consumer Helper** (`govcms_ca3_consumer_helper`) prepares a GovCMS site
to consume media from the **CA3** (Content API) service. On installation it
registers CA3 as an **oEmbed provider** and sets up the CA3 media fields, so a site
that consumes CA3 can embed CA3 media through oEmbed with the required fields
configured out of the box — no manual field wiring needed.

It builds on core's **Media** and **Link** modules and supports Drupal 10 and 11.
The module does its work at install time and through its provided configuration;
there is no ongoing settings form to fill in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media/Link dependencies.

There is **no configuration page** — the module has no settings form. Enabling it
registers the CA3 oEmbed provider and creates the CA3 media fields for you.

## How to use it

Once enabled, CA3 is available as an oEmbed provider and the CA3 media fields are in
place. Use Drupal's standard media workflow to embed CA3 media — for example through
a media field or the media library — and the content is consumed from the CA3
service via oEmbed.

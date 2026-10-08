# Project Browser Localizer — manual setup guide

**Project Browser Localizer** (`pb_localizer`) brings Drupal's core **Project
Browser** into your users' own language. The Project Browser pulls module metadata
from Drupal.org in real time — but that data is English-only, which is a real
barrier for non-English site builders, agencies, and their clients. PB Localizer
fixes that by transparently overlaying the browser with **live translations** of
module titles, summaries, full descriptions (including code samples), and category
names.

It works as a kind of "shadow API" proxy: it intercepts the Project Browser's
JSON:API responses and merges in translated metadata fetched from a central **PB
Translation Hub**, without touching Drupal core. In the 3.x line the official,
community-held hub is **preconfigured** — install the module and translations are
there instantly, with no setup required. A settings form lets you fine-tune the
behavior (translation badges, a custom hub, category sync) if you want to.

Because it fetches translations from an external hub, be aware that the module
makes outbound network requests to that hub. Only reviewed translations are shown,
and strict cache isolation keeps languages from bleeding into each other on
multilingual sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the optional settings form
   (translation badge, custom hub, category sync), field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → Services → Project Browser Localizer**
(`/admin/config/services/pb-localizer`). Because the official hub is preset, you can
leave everything at its defaults and the module simply works.

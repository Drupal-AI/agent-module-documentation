# FullStory Integration — manual setup guide

**FullStory Integration** (`fullstory`) adds the FullStory tracking JavaScript
snippet to your site. FullStory is a digital-experience analytics product that
captures **session recordings**, heatmaps, and detailed interaction data — how
visitors click, scroll, navigate, and (potentially) type into forms — so your teams
can study real user behaviour. This module's job is simply to inject the snippet;
the analysis happens in FullStory itself.

Setup is short: you create a FullStory account, find your **organization (org) ID**
in the snippet FullStory gives you, and enter it in the module's settings. The
module provides its own permissions and a settings form at
`fullstory.admin_settings_form`.

> **Privacy is the central consideration here.** Session recording captures detailed
> user interaction and can inadvertently record **sensitive input** — passwords,
> personal data typed into forms — unless those elements are masked. Before you
> enable this on a real site: use FullStory's field-masking/exclusion features for
> sensitive elements, disclose the tracking in your privacy policy, and gate it
> behind your cookie/consent management (this is third-party tracking, with GDPR/CCPA
> implications). The module has no access-control role beyond its permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your org ID and set up masking,
   with the privacy considerations spelled out.

## Where it lives in the admin menu

Once enabled, configure the module at its settings form (config route
`fullstory.admin_settings_form`). After you save your org ID there, the FullStory
snippet is added to your pages and recording begins.

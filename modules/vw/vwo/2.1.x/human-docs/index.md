# VWO (Wingify) — manual setup guide

**VWO (Wingify)** (`vwo`) injects the VWO / Wingify "Smart Code" JavaScript snippet
into your site's pages so you can run A/B, split-URL and multivariate experiments
(and use VWO features like heatmaps and session recordings). You give it your VWO
account ID, decide which pages and users the code loads on, and choose how the
library loads — the module handles adding the snippet to the right pages.

It is a thin, well-behaved front-end integration built around a single
configuration object. A set of **visibility** rules lets you limit the snippet to
specific content types, roles, or paths, and optionally give individual users an
opt-in or opt-out checkbox on their profile. **Loading** options let you switch
between asynchronous loading (with a preconnect and an anti-flicker timeout) and
synchronous loading. There is also a handy **Extract Account ID** helper: paste a
full Smart Code snippet and it pulls the numeric account ID out for you.

The module defines a single permission, **Administer VWO**, which gates all of its
admin forms. It has no plugins and no Drush commands. Note that you need an active
VWO account and ID for the snippet to actually do anything.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the account ID, visibility rules,
   loading options, and the Extract Account ID helper.

## Where it lives in the admin menu

Once enabled, VWO's settings sit at **Configuration → System → VWO**
(`/admin/config/system/vwo`), with sibling forms for **Visibility**
(`/admin/config/system/vwo/visibility`) and **Extract Account ID**
(`/admin/config/system/vwo/vwoid`). All three require the **Administer VWO**
permission — grant it only to trusted administrators, since it controls a
site-wide third-party tracking snippet.

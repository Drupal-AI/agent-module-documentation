# Lytics — manual setup guide

**Lytics** (`lytics`) connects your Drupal site to the
[Lytics](https://www.lytics.com) **Customer Data Platform (CDP)**. Once
connected, it does three main things: it injects the **Lytics JavaScript tag** on
your non‑admin pages so visitor behaviour flows into Lytics profiles; it lets
editors build **Pathfora personalization widgets** — modals, bars, slide‑outs,
recommendations — targeted at Lytics audiences; and it ships a **Content
Recommendation block** that shows each visitor content picked by Lytics interest
engines and content collections.

Use it when you already have a Lytics account and want on‑site personalization,
audience‑segment targeting, and content recommendations driven by Lytics
profiles. The module unifies visitor identities across devices and sessions,
collects behavioural data in real time, and lets you tailor what different
segments see.

Setup is short: install the module, open its settings form, and paste a Lytics
**Access Token**. The module then calls the Lytics account API to resolve and
store your account name, id, and domain. From there you toggle tag behaviour and
build widgets.

> **Treat the Lytics Access Token as a secret.** It is an account credential.
> Store it in an environment variable rather than committing it, as the
> [Configuration](configuration/index.md) page describes. Note also that the
> widget‑manager screen embeds the token into the page HTML for users who hold the
> **manage lytics connection** permission — so grant that permission only to
> trusted administrators. The module makes server‑side API calls to Lytics, so the
> site needs outbound access to `api.lytics.io`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your Lytics account, tune
   the tag, and build widgets and recommendations.

## Where it lives in the admin menu

The connection settings are at **Configuration → System → Lytics**
(`/admin/config/system/lytics`). Widgets are managed at
`/admin/structure/lytics_widgets/manage`. The Content Recommendation block is
placed through the normal **Block layout** screen.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your Lytics Access Token in the settings form; the module resolves your
   account details automatically (see [Configuration](configuration/index.md)).
3. Enable the tag, and (optionally) tune debug mode and whether admin users are
   tracked.
4. Build Pathfora widgets in the widget wizard and/or place the **Lytics Content
   Recommendation** block where you want per‑visitor recommendations.

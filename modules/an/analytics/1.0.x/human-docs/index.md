# Analytics API — manual setup guide

**Analytics API** (`analytics`, shown as "Analytics API") is a common framework
and admin UI for adding third‑party analytics and tracking services to a Drupal
site. Rather than installing a separate module for each vendor, you manage all of
them from one place — **Configuration → Services → Analytics** — with shared
privacy controls (Do Not Track and IP anonymization) that apply across every
service.

Out of the box the base module includes plugins for **Google Tag Manager** (with a
container ID, an optional JSON data layer, and an optional Google Optimize
anti‑flicker snippet) and **Google Optimize**. Three bundled submodules add more:
**Analytics: Google Analytics** (`analytics_google`) for Google Analytics,
**Analytics: AMP** (`analytics_amp`) for AMP analytics and tracking pixels
(requires the separate `amp` module), and **Analytics: Piwik** (`analytics_piwik`)
for Piwik/Matomo. Each configured service is a **config entity**, so your tracking
setup can be exported and deployed like any other Drupal config. Because it's a
plugin framework, developers can also add their own analytics service plugin.

At runtime, each enabled service whose "can track" check passes has its snippet
appended to the bottom of the page. That check automatically **suppresses tracking
on admin routes** and for users who hold the *bypass all analytics services*
permission. The shared privacy settings can wrap every snippet in a
`navigator.doNotTrack` guard and request IP anonymization, and a single toggle can
disable all analytics output globally. The base module has no external
dependencies and runs on Drupal 10.3+ / 11.

> **A note on what this module emits.** The tracking snippets are, by design,
> **admin‑authored JavaScript injected on every front‑end page** — that's the
> whole point of an analytics tag. Everything is gated behind the *Administer
> analytics* permission, so grant that permission only to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the
`analytics_service` plugin interface — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose which vendor submodules you need.
2. [Configuration](configuration/index.md) — add and configure a service, the
   shared privacy settings, and the permissions involved.

## Where it lives in the admin menu

- The list of configured services is at **Configuration → Services → Analytics**
  (`/admin/config/services/analytics`).
- The shared privacy/behaviour settings are at **Configuration → Services →
  Analytics → Settings** (`/admin/config/services/analytics/settings`).
- Both are gated by the *Administer analytics* permission.

## How to use it

Enable the base module (and any vendor submodule you need), then add a service on
the Analytics page, pick the vendor plugin, and fill in its details (for example a
GTM container ID). Set your privacy preferences on the Settings tab, and grant the
permissions. The step‑by‑step is in [Configuration](configuration/index.md).

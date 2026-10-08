# Rankcrew — manual setup guide

**Rankcrew** (`rankcrew`) connects your Drupal site to the third-party
[RankCrew](https://www.rankcrew.ai/) content platform. RankCrew writes
ready-to-publish, multilingual articles — text, SEO copy, and images — and this
module exposes the REST endpoints that let RankCrew push that content straight
into your site as nodes, so new posts appear without you copying anything by hand.

Technically, the module provides a set of core **REST resources**. The main one
(`POST /api/rankcrew`) accepts a JSON payload with a content type and a `data` map
keyed by language: it creates a base node in the first language and adds a
translation for each additional valid, translatable language in the same request.
Images arrive base64-encoded inside the payload and are decoded into managed files
on your image field. Two companion resources let the platform list your
vocabularies and categories so it can map content correctly.

Because these are core REST resources, they are **inert until you enable them**,
and access is governed by Drupal's REST framework: an incoming request must
authenticate (the module depends on `basic_auth`) and hold the matching REST
permission. In other words, RankCrew connects to your site by signing in as a
Drupal user account you create for it.

This is a third-party integration: content is authored on RankCrew's servers and
sent into your site, and you share details of your content types with the
platform. Treat the connecting account as a privileged, trusted credential and
review RankCrew's own documentation and data-handling before switching it on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its REST dependencies.
2. [Configuration](configuration/index.md) — enable the REST resources, create a
   dedicated API account, and grant the right permission.

## Where it lives in the admin menu

There is no dedicated settings page. You configure the integration through core's
REST tools — **Configuration → Web services → REST**
(`/admin/config/services/rest`, most easily via the contributed **REST UI**
module) — plus **People** for the API account and **People → Permissions** for
access. See [Configuration](configuration/index.md).

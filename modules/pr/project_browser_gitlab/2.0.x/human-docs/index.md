# Project Browser Gitlab — manual setup guide

**Project Browser Gitlab** (`project_browser_gitlab`) is a **source plugin for
the core [Project Browser](https://www.drupal.org/project/project_browser)**. It
lets Project Browser list — and, in future, install — modules from a GitLab
instance in addition to drupal.org. That makes it a good fit for a private or
company module registry hosted on your own GitLab: your site builders can browse
those modules from inside Drupal's admin, just as they browse drupal.org
projects.

Setup has three parts: you install this module, define a GitLab source (its
endpoint and, if the instance is private, a token), and then enable that source
in Project Browser so it shows up when browsing modules.

> **Heads-up:** Both Project Browser and this module are under active development.
> The maintainers caution against expecting a stable release before Project
> Browser lands in core, so treat it as evolving.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Project Browser.
2. [Configuration](configuration/index.md) — define a GitLab source (endpoint and
   token), then enable it in Project Browser.

## Where it lives in the admin menu

You configure a GitLab source at **Configuration → Development → Project Browser
Gitlab** (`/admin/config/development/project_browser_gitlab`). You then enable
that source at **Configuration → Development → Project Browser**
(`/admin/config/development/project_browser`). Once enabled, it appears when you
browse modules at **Extend → Browse** (`/admin/modules/browse`).

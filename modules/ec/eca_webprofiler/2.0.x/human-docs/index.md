# ECA Webprofiler — manual setup guide

**ECA Webprofiler** (`eca_webprofiler`) is a developer debugging aid that
integrates Drupal's no‑code [ECA](https://www.drupal.org/project/eca)
automation engine with the
[Webprofiler](https://www.drupal.org/project/webprofiler) module. It surfaces ECA
event/condition/action execution in the Webprofiler toolbar and panel, so you can
see **which ECA models fired on a request** — invaluable when you're trying to
understand why an automation did (or didn't) run.

Like other ECA integration modules, it has no settings form of its own; enabling
it adds the ECA information to Webprofiler's existing panels.

Treat this as a **development‑only tool**. Webprofiler itself is meant for local
and development environments — it adds overhead and exposes internal details of
your application — so do not enable this (or Webprofiler) on production. The module
has no content or access‑control role. It depends on ECA and Webprofiler and
supports Drupal 10.4 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA and Webprofiler in a development environment.

There is **no configuration page** for this module. It adds information to
Webprofiler's panels; see "How to use it" below.

## Where it lives in the admin menu

ECA Webprofiler adds no admin page of its own. Its output appears in the
**Webprofiler** developer toolbar and its detail panels, which Webprofiler renders
at the bottom of pages (and in its report pages) in a development environment.

## How to use it

1. In a **development** environment, make sure ECA and Webprofiler are installed
   and Webprofiler's toolbar is enabled.
2. Enable ECA Webprofiler.
3. Load a page that triggers ECA models, then open the Webprofiler toolbar/panel
   for that request and look at the ECA section to see which events, conditions
   and actions fired.
4. Keep this off production — Webprofiler is a development tool and exposes
   internal details.

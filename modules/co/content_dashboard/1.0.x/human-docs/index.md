# Content Dashboard — manual setup guide

**Content Dashboard** (`content_dashboard`) gives editors a single "My Dashboard"
landing screen for day‑to‑day content work. Instead of hunting through the admin
menu for the right content list, editors open one page that gathers the most
common editorial tasks in one place — links to each content type's filtered
content list, each media type's listing, and quick links to configuration and
administration pages such as the users list, webforms, taxonomies, and site
settings.

The dashboard is personalized by role: each section only appears to users whose
role has access to it, so the page an editor sees reflects exactly what they are
allowed to manage. The content and media lists themselves respect Drupal's
normal access checks, so the dashboard never exposes anything a user could not
already reach — it simply makes the things they *can* reach easier to find.

The module works as soon as you enable it and grant the right permission. There
is no settings form to fill in; the one setup step is deciding which roles get
the **access content dashboard** permission (covered in
[Configuration](configuration/index.md)). It has no dependencies beyond Drupal
core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — grant the dashboard permission and
   understand how role access shapes what each editor sees.

## Where it lives in the admin menu

Once enabled and permitted, the dashboard is reachable from the **My Dashboard**
item in the main administration menu. There is no separate settings page — the
only "configuration" is the permission described in
[Configuration](configuration/index.md).

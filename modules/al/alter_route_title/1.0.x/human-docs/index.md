# Alter Route Title — manual setup guide

**Alter Route Title** (`alter_route_title`) lets you **change the page title of
specific routes** — that is, override the heading shown at the top of chosen pages
(admin screens or front-end pages) without writing custom code. It's handy for
branding or clarity: renaming a page whose default title doesn't quite fit your
site's wording.

It's a small site-building utility. The titles are admin-configured, and the module
has no content or access-control role of its own — it only changes what a page's
title reads.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module stores route-title overrides in configuration. Reach its settings from
the module's **Configure** link on the **Extend** page (`/admin/modules`) if a
direct menu link isn't shown.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the module's route-title settings.
3. Specify the route(s) whose title you want to change and the replacement title.
4. Save. The chosen pages now display your custom title instead of the default.

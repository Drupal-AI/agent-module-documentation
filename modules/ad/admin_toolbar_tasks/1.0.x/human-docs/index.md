# Admin Toolbar Tasks — manual setup guide

**Admin Toolbar Tasks** (`admin_toolbar_tasks`) moves administrative **local
tasks** — the *View / Edit / Revisions / Translate / Devel* style tabs — out of
the content area and into the site toolbar. Those tabs are Drupal's contextual
actions for whatever you are looking at, and by default they render as a strip of
tabs near the top of the page body.

That default works fine on an admin theme but often works badly on a front-end
theme, where the tabs either collide with the site's design or get suppressed by
it and become unreachable. Putting them in the toolbar solves both problems at
once: the toolbar is already the administrative surface, it looks the same across
every theme, and a theme no longer has to be designed around a set of tabs it
never wanted. The practical payoff lands on any site where editors work in the
front-end theme — editors stop hunting for the edit tab, and the theme is freed
from styling tabs.

The module depends only on core's **Toolbar** module and targets Drupal 10 and 11.

Two things are worth checking on a real site rather than on a stock install.
First, the toolbar is not infinitely wide: a content type that carries
translation, moderation, revisions, Devel, and a few contrib tabs can produce more
local tasks than comfortably fit, so look at that busy case. Second, local tasks
are **access-filtered per route**, so what appears varies by user — which is
correct, and means you should test with an ordinary **editor account rather than
as user 1**, since user 1 sees everything and therefore tests nothing.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. Once enabled, local tasks simply appear in the toolbar
across the site.

## How to use it

Install and enable it — there is nothing to configure. From then on, the local
tasks for the page you are viewing appear in the toolbar instead of as tabs in the
content area. To verify, log in as an editor, open a node, and confirm you can
reach its *Edit* and *Revisions* actions from the toolbar. It pairs naturally with
an admin toolbar module such as [Admin Toolbar](https://www.drupal.org/project/admin_toolbar).

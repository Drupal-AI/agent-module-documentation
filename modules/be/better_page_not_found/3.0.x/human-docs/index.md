# Better Page Not Found — manual setup guide

**Better Page Not Found** (`better_page_not_found`) gives your site nicer, more
branded **error pages** — the **404 (page not found)**, **403 (access denied)**,
and general error pages — in place of Drupal core's plain default output. When a
visitor hits a missing or forbidden page, they see a more polished, styled page
instead of a bare message.

This is a presentation improvement only. It changes how the error pages *look*,
not what they *mean*: a 403 is still a 403, and the module has no role in access
decisions or in what content a visitor is allowed to reach. It simply makes the
moment a visitor lands on an error page feel like part of your site rather than a
dead end.

It works across Drupal 8, 9, 10, and 11 and has no dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Enable the module and the improved styling applies to the 404, 403, and error
pages automatically — there is nothing you must set up for the nicer pages to
appear. To see it, enable the module and then visit a URL that does not exist on
your site; you should get the styled not‑found page rather than core's plain one.

> **Note:** the available agent docs for this module are thin and do not describe
> a settings screen or its options. If your installed version exposes styling
> options, look for them under **Configuration** in the admin menu after enabling
> the module.

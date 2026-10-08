# Barba JS — manual setup guide

**Barba JS** (`barbajs`) integrates the
[Barba.js](https://barba.js.org) JavaScript library to give your site smooth,
fluid transitions between pages. Instead of a full white-flash reload on every
click, Barba.js loads the next page's content in the background via AJAX and
animates the swap, so navigation feels more like an app than a traditional site.

It is a front-end / theming enhancement, applied site-wide. It has no content or
access role, adds no permissions, and stores nothing sensitive — it simply brings
the library to Drupal so your theme can use it. It runs on Drupal 9.5, 10 and 11.
This version is an early **1.0.0-alpha1** release.

This guide is written for a **human** working on the site. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

There is no settings page. Once the module is enabled it makes the Barba.js
library available; the transitions apply as you navigate the front end. Because
Barba.js works by wrapping your page content in container/wrapper markup, getting
the nicest results usually involves a little theme-level work — making sure your
theme's markup matches Barba's expected containers and, if you want custom
animations, defining transitions in your theme's JavaScript. If you use it as-is,
you get the library's default AJAX page-swap behaviour without full reloads.

# ACH Attach JS — manual setup guide

**ACH Attach JS** (`ach_attach_js`) is a small developer helper. It provides a
JavaScript library for calling `Drupal.attachBehaviors` on content that is added to
the page dynamically — markup loaded over AJAX or injected by your own JavaScript.
Drupal attaches its behaviors (widgets, event handlers, and so on) automatically
when a page loads, but it does not cover markup that appears later; this library
lets you re-run behavior attachment on that new markup so it works like the rest of
the page.

It is a front-end / developer library. It has no admin interface, no content, and no
access-control role — it is a building block for developers writing custom
JavaScript. It supports Drupal 9.2, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

This module is meant to be used from custom JavaScript, not through the admin UI.
Enable it, add its library as a dependency of your own JavaScript, and call the
provided helper to run `Drupal.attachBehaviors` on the container element you have
just added to the DOM. There is no settings form. Note this release is an alpha
(`8.x-1.0-alpha6`), so test it against your target Drupal version.

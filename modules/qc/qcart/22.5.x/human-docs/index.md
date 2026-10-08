# Qcart — manual setup guide

**Qcart** (`qcart`) is a thin loader that adds the hosted **Qcart** shopping-cart
button to your Drupal site. The entire module is a single hook that attaches one
external JavaScript file — `https://qcart.app/btn.js` — to every page, so the
third-party Qcart widget renders site-wide. All of the actual cart logic and state
lives in that remote script and in Qcart's own backend, not in Drupal.

Because everything is delegated to the hosted service, there is nothing to
configure: enable the module and the button appears. There are no settings forms,
routes, permissions, or services, and no Drupal-side pricing or order handling to
manage.

> **Supply-chain and privacy note.** This module loads and runs **remote,
> third-party JavaScript on every page** of your site. That script is served over
> HTTPS, but it can change at any time and can observe every page a visitor loads.
> Review the Qcart service and its script before using it in production, and be
> aware of the privacy implications of embedding it site-wide. This project is
> minimally maintained with no further development, and is not covered by Drupal's
> security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings.

## How to use it

Enabling the module is all it takes: the Qcart button loads automatically on every
page. To **remove** the widget, disable or uninstall the module. To **scope** the
script to only certain pages, you have to edit the module's `qcart_page_attachments()`
hook and add your own conditions there — there is no UI for page targeting.

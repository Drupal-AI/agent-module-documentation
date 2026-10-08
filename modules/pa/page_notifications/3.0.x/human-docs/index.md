# Page Notifications — manual setup guide

**Page Notifications** (`page_notifications`) lets visitors "watch" a page. A
visitor subscribes by email address to a node (or a taxonomy term) and receives an
email whenever that content is updated — no account required. Subscribers manage
their own subscriptions through tokenized links, so they can view everything they
watch, unsubscribe from one page, or cancel all of it without ever logging in.
Administrators get subscription reports, editable email templates, and migration
tools.

Notifications go out immediately: when an editor saves a watched node with the
notify checkbox ticked, subscribers are emailed right away with any note about the
change. The module works with the **CAPTCHA** and **reCAPTCHA** modules — it
detects reCAPTCHA automatically once that module is installed and enabled — which
is highly recommended on the public subscribe form to keep bots out. It depends on
core's **Node** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the subscribe block, set the
   admin permissions, tune the settings and email templates, and add CAPTCHA.

## Where it lives in the admin menu

The subscribe form is provided as a **block** (placed from **Structure → Block
layout**). Admin tooling — settings, email templates, subscription lists, and
migration forms — lives under **`/admin/page-notifications/*`** (settings config
route `page_notifications.tabs`), behind a restricted permission. Permissions are
set under **People → Permissions** (`/admin/people/permissions`).

## How it works for a subscriber

A visitor enters their email on the subscribe block and receives a confirmation
(double opt‑in) email. From the tokenized links in their emails they can open a
"my subscriptions" page listing every page they watch, cancel a single
subscription, or cancel all of them — all without an account.

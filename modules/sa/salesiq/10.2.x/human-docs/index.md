# Zoho SalesIQ — manual setup guide

**Zoho SalesIQ** (machine name `zohosalesiq`) embeds the Zoho SalesIQ live-chat and
visitor-tracking widget on your Drupal site. Zoho SalesIQ is a hosted live-chat and
chatbot platform with visitor tracking and analytics; this module is the thin
Drupal bridge that injects the widget snippet you copy from your Zoho account into
your site's pages, so you do not have to edit templates or manage the script by
hand.

> **A naming quirk worth knowing up front:** the project (and Composer package) is
> **`salesiq`** — you install `drupal/salesiq` — but the module's machine name is
> **`zohosalesiq`**, so that is the name you enable with Drush and the name that
> appears in configuration paths. This guide points out where each applies.

You paste your Zoho-provided widget code into a single admin field, and the module
outputs it as an inline script in the page head, automatically tagging the traffic
with `plugin_source=drupal`. It can run in **tracking-only mode** (hiding the chat
float button) and can be limited to front-end view pages, so it stays off admin and
node-edit screens. For logged-in users it also pre-fills the chat with that user's
own display name and email, so they do not have to type them.

The module needs a small amount of configuration — you must paste in the widget
code before anything appears. It has no module dependencies, no submodules, and no
third-party PHP libraries. It makes no server-side HTTP calls to Zoho from PHP; the
widget talks to Zoho directly from the browser.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — Composer and enabling the module (mind
   the `salesiq` vs `zohosalesiq` naming).
2. [Configuration](configuration/index.md) — pasting the widget code and choosing
   the display options.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Zoho SalesIQ**
(`/admin/config/services/zohosalesiq`, config route `zohosalesiq.settings`),
protected by the **Administer Zoho SalesIQ** (`administer zohosalesiq`) permission.

## A note on security

The widget code is only settable by an administrator holding the **Administer Zoho
SalesIQ** permission. The visitor name and email the module pre-fills belong to the
*viewing user themselves*. No secrets are handled in PHP and no server-side calls are
made to Zoho.

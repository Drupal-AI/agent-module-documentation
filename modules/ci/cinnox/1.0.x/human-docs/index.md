# CINNOX — manual setup guide

**CINNOX** (`cinnox`) adds the [CINNOX](https://www.cinnox.com) omnichannel
engagement widget — a live call and chat launcher — to your Drupal site. When
configured, a small floating launcher appears on your public pages so visitors can
start a chat, call, or message that is routed to your CINNOX agents. Under the
hood the module simply injects CINNOX's JavaScript snippet into your front-end
pages; all of the conversation handling happens on the CINNOX platform.

The problem it solves is the plumbing: rather than pasting a third-party script
into your theme by hand, you enter your CINNOX widget identifier once on a settings
form and the module attaches the script for you — on public pages only, skipping
admin pages, and skipping injection entirely until it has been configured.

To use it you need a CINNOX service account (a free trial is available) and the
widget ID / snippet details CINNOX gives you. The module stores that identifier in
its own configuration and needs no other dependencies. It has no effect until you
fill in the settings form, so nothing changes on your site the moment you enable
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your CINNOX widget details so
   the launcher appears on your site.

## Where it lives in the admin menu

The settings form sits at **Configuration → CINNOX → Settings**
(`/admin/config/cinnox/settings`) and is gated by the **Administer site
configuration** permission, so keep it to administrators.

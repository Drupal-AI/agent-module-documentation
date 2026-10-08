# Chat:LiveHelperChat — manual setup guide

**Chat:LiveHelperChat** (`chat_livehelperchat`) embeds a self‑hosted
[Live Helper Chat](https://livehelperchat.com/) (LHC) server's chat widget — and
optionally its FAQ — into your Drupal pages, with rules that control where the
widget appears. Live Helper Chat is an open‑source live‑support chat platform; this
module is the bridge that injects its embed markup and JavaScript into your site.

You configure it in one of two ways: visually through the admin form (pick the LHC
domain, widget height/size, subject, and so on), or by pasting the JavaScript
snippet that your LHC server generates (from its own admin, under System → HTML
code), which is then embedded in the page header. Either way, the chat traffic
itself goes to your LHC server; Drupal's job is to place the embed.

On top of that, the module uses Drupal's condition plugins to control widget
**visibility** — by page/path, by user role, and by content type — so you can show
the widget only where it belongs. It defines three permissions, all of which are
restricted (admin‑level) because two of them enable powerful behaviour: injecting
server‑generated JavaScript into the page, and (for advanced cases) evaluating PHP
snippets as a visibility condition. Grant those only to fully trusted
administrators, and treat any PHP visibility snippet you add with the same caution
as core's old PHP filter — it runs with site privileges.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the right permissions.
2. [Configuration](configuration/index.md) — the settings form and visibility
   rules, field by field.

## Where it lives in the admin menu

The settings form is at
`/admin/config/chat_livehelperchat/livehelperchatformsettings`
(route `chat_livehelperchat.live_helper_chat_form_settings`), reachable by users
with the **Administer chat_livehelperchat** permission.

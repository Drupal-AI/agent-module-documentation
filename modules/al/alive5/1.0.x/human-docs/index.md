# Alive5 — manual setup guide

**Alive5** (`alive5`) adds the [Alive5](https://www.alive5.com/) live-chat widget
to your Drupal site, and lets you control which pages it appears on entirely from
the admin UI — no theme edits, template changes, or custom code required.

You paste your Alive5 widget ID into the settings form, and the module's widget
manager decides, per request, whether to attach the chat script. It evaluates
configurable display rules — which paths to show it on, whether to exclude admin
screens, and which user roles or audiences should see it — and it does this in a
cache-safe way so the rules keep working even with page caching on.

That makes it easy to do things like: show chat only on high-intent pages
(contact, pricing), hide it on legal or policy pages, limit it to logged-in users,
or switch it off site-wide without uninstalling. The only outbound element is the
third-party Alive5 script, whose address is configured in the admin UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your widget ID and set the
   display rules.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Alive5**
(`/admin/config/system/alive5`), gated by the **Administer Alive5** permission
(a restricted permission — grant it to trusted administrators only).

## How to use it

Enable the module, open the settings form, paste your Alive5 widget ID, and
choose where the widget should appear (paths, admin exclusion, roles). Save, and
the chat widget loads on the pages your rules allow. Because the configuration is
standard Drupal config, you can export it with configuration management and move
it between environments.

# Maintenance Page Node — manual setup guide

**Maintenance Page Node** (`maintenance_page_node`) lets you pick an ordinary
Drupal node to display on the maintenance-mode page, in place of Drupal's plain
default "site under maintenance" message. Instead of editing templates or code,
you build your offline page as normal content — with images, formatted text, a
status message, contact details, whatever you like — and simply point the module
at that node.

When maintenance mode is on, the module renders your chosen node as the
maintenance page. Leave the setting empty and you get Drupal's default message
back, so it's completely opt-in. Because the offline page is just a node, you
control its look through normal node editing and view-mode configuration, and you
can translate it like any other content.

The module adds no page of its own. It slips a single **Maintenance Node**
autocomplete field onto core's maintenance settings form; picking a node there is
all it takes. Choosing the node is guarded by core's *administer site
configuration* permission, so only trusted administrators can change it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — create a node and select it on the
   maintenance settings form.

## Where it lives in the admin menu

The module adds its **Maintenance Node** field to core's maintenance settings at
**Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`).

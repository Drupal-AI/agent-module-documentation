# Block Permissions — manual setup guide

**Block Permissions** (`block_permissions`) breaks Drupal's single, all-or-nothing
**Administer blocks** permission into a set of fine-grained permissions — one for
each enabled theme, and one for each source (provider) of blocks. That lets you hand
a client or an editor control over the blocks on your public theme while keeping the
admin theme and the system blocks safely out of reach, or let a marketing role place
only custom (block content) blocks and nothing else.

The permissions are generated **dynamically**, so the list keeps itself in sync with
your site. Enable a new theme and a permission for that theme appears; install a
module that provides blocks (Views, Webform, Commerce, and so on) and a permission
for managing *its* blocks appears. Uninstall the theme or module and the matching
permission quietly goes away.

Crucially, these permissions **refine** core's Administer blocks rather than
replacing it. A user still needs the core permission to reach the Block layout page
at all — the new permissions then narrow *which* themes and *which* block families
they can actually touch. The module enforces this across the block admin screens:
rows a user can't manage are frozen on the drag-and-drop layout table, and blocks
they can't place are hidden from the "Place block" library. It has no dependencies
beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the two permission families, how to
   grant and combine them, and the common "403 on Block layout" gotcha.

## Where it lives in the admin menu

There is no settings page of its own. You configure everything on the standard
**People → Permissions** page (`/admin/people/permissions`), where the module's
per-theme and per-provider permissions appear. The rules then take effect on the
core **Structure → Block layout** screens (`/admin/structure/block`).

## How to use it

Enable the module, then go to **People → Permissions** and grant a role the
permissions it should have: core **Administer blocks** (still required), the theme(s)
whose block layout it may manage, and the provider(s) whose blocks it may place or
edit. See [Configuration](configuration/index.md) for exactly how these combine —
and why a role can get an unexpected 403 if you forget the default theme's
permission.

# Idle — manual setup guide

**Idle** (`idle`) gives Drupal's maintenance mode a makeover and makes turning it
on and off effortless. It replaces the default maintenance page with a
distinctive, television‑style design — colorful test bars with your message in
the center — and adds a one‑click toggle so you no longer have to open the
maintenance settings page and fiddle with checkboxes every time.

The message shown on the retro‑TV page is pulled dynamically from your existing
core maintenance settings, so you set the wording in one familiar place and Idle
handles the presentation. The one‑click toggle lives on a menu item, letting an
administrator flip maintenance mode on or off in a single action.

Keep in mind that this module fronts **core's** maintenance mode: putting the
site into maintenance restricts access to privileged users, which is standard
Drupal behavior. Idle changes the look and the toggling convenience, not who is
allowed in. It depends on the **Service** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no settings form of its own** — the maintenance message comes
from core's maintenance settings, described below.

## Where it lives in the admin menu

Idle adds a **maintenance‑mode toggle** as a menu item, so you can enable or
disable maintenance mode with one click. The maintenance *message* itself is
still edited at core's **Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`).

## How to use it

1. Set the wording of your maintenance message at **Configuration → Development →
   Maintenance mode** — Idle displays this text on its retro‑TV page.
2. Use Idle's one‑click menu toggle to switch maintenance mode on or off as
   needed.

> **Note:** because the maintenance page's message is sourced from the core
> settings, to change those settings you may need to temporarily disable the
> module, adjust them, and re‑enable it.

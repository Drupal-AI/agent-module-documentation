# Crisis mode — manual setup guide

**Crisis mode** (`crisis_mode`) gives your site a predefined, configurable
communication block that you can switch on and off in a hurry — exactly what you
want when there is an emergency, an outage, or any situation that needs an urgent
message in front of every visitor immediately. You set up the message once, in
calm conditions, and then a single toggle (or one Drush command) makes it appear
site-wide when a crisis hits, and hides it again when the crisis passes.

When you enable the module a new block is added to the content region, but it stays
**disabled and shows nothing** until you both configure it and explicitly activate
the crisis situation. The block can display a crisis title, a body of text shown
everywhere, and an optional link to a page with more information.

Activation is the operational heart of the module, so it is worth understanding
before you rely on it. There are two ways to turn the message on: tick the **Crisis
Situation** checkbox on the settings page and save, or run `drush crisis-mode on`.
Both make the block visible and clear caches. To stand down, untick the box (and
save) or run `drush crisis-mode off`. Because activation shows a message on every
page and clears caches, treat it as a deliberate, high-visibility action — and make
sure the people who might need to flip it in an emergency know where the toggle is.

The module provides its own permissions, has no dependencies, and supports Drupal
8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — write your crisis message and learn
   the two ways to activate and deactivate it.

## Where it lives in the admin menu

The settings and the activation toggle both live at **Configuration → System →
Crisis mode** (`/admin/config/system/crisis_mode`).

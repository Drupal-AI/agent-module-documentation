# Sticky Local Tasks — manual setup guide

**Sticky Local Tasks** (`sticky_local_tasks`) keeps Drupal's local task tabs —
*View*, *Edit*, *Revisions*, *Delete* and the like — within reach as you scroll a
long page. Normally those tabs render once at the top of a node and then scroll
away, so on a long article or a Layout Builder screen you have to scroll all the
way back up just to switch from *Edit* to *View*. This module collects those same
tabs into a small sticky control (by default a floating icon in a corner of the
viewport) that stays put no matter how far down the page you are.

It is purely presentational: it changes *where* the existing local tasks appear,
never which tabs exist or who is allowed to reach them. There are no module
dependencies beyond Drupal core, and it needs PHP 8.1 or newer.

The module gives you a settings form to choose which corner the sticky tabs sit in
and whether to keep Drupal's original top-of-page tabs alongside the sticky copy.
One thing worth knowing before you dig into permissions: the module declares a
permission called *administer sticky local tasks*, but the settings form is
actually gated by core's **Administer site configuration** permission — so that
module-specific permission is declared but unused, and granting it does not open
the form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the tab position and whether
   to keep the default tabs.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Sticky Local Tasks**
(`/admin/config/user-interface/sticky-local-tasks`). Access is controlled by the
**Administer site configuration** permission.

## How to use it

Once enabled, the sticky tabs appear automatically on pages that have local tasks
(content edit/view screens, for example). Visit a long node as an editor and you
will see the sticky control holding the *View / Edit / Revisions / Delete* tabs,
staying visible as you scroll. Theming is handled by the two Twig templates the
module ships, and other modules can extend the task list through the hooks
documented in `sticky_local_tasks.api.php`.

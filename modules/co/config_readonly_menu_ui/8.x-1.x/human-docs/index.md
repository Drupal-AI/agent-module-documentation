# Configuration Read-only Menu UI — manual setup guide

**Configuration Read-only Menu UI** (`config_readonly_menu_ui`) carves a narrow, deliberate
exception into the [Config Read-only](https://www.drupal.org/project/config_readonly) module
so that editors can still **reorder content menu links** on a locked‑down production site.

To understand why this is needed, it helps to know what Config Read-only does. It makes
production configuration immutable: with it enabled, configuration forms refuse to save, so
the only way configuration changes is through a deployment. That is the right posture for a
site with a real deployment pipeline, because it removes the whole class of problem where
someone edits a setting on production and the next config import silently reverts it. But it
creates one very common friction point. A Drupal menu mixes two kinds of storage: the menu
itself is *configuration*, while its **content menu links** are *content entities*. The menu
administration form saves both at once — so Config Read-only blocks a purely editorial
"drag this menu item up" action, because saving that form touches configuration. Editors
experience this as "I can't move a menu item on the live site", which is a fair complaint.

This module allows that specific operation through. When there are no read‑only (config) menu
links in the list, you get the normal drag‑and‑drop reordering back. When there *is* at least
one config menu link present (for example a View whose menu link is defined in the View's
configuration), it still lets you change the weight of the **content** menu links — but via a
weight field rather than drag‑and‑drop, since drag‑and‑drop could otherwise have to move the
config links too. It requires **Config Read-only**, core's **Menu UI**, and **Menu Link
Content**, and works on Drupal `^8 || ^9 || ^10 || ^11`.

Two things are worth understanding before you rely on it:

- **Every exception to a lock is a hole in the lock.** The value of running Config Read-only
  at all depends on this exception staying narrow. It permits reordering *content* menu
  links, not editing the whole menu form — confirm that this matches your governance policy.
- **Menu link weights are content here, so they do not travel with a configuration export.**
  A reorder made on production stays on production; it will not appear in a config export and
  will not deploy to other environments. That is the intended consequence, and anyone who
  expects all environments to match needs to understand it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (Config
   Read-only first).

There is **no configuration page** for this module — it has no settings form. It changes how
the menu administration form behaves the moment it is enabled, as described above.

## How to use it

There is nothing to configure. With Config Read-only active and this module enabled, go to
**Structure → Menus → *(a menu)* → Edit menu** and you will find you can reorder its content
menu links again — by drag‑and‑drop when the menu contains only content links, or via a
weight field when it also contains one or more config‑defined links. Everything else about
Config Read-only's lock stays in force.

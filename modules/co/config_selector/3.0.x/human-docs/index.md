# Configuration Selector — manual setup guide

**Configuration Selector** (`config_selector`) is a developer / distribution utility that lets a
module or install profile ship several alternative versions of the *same* optional
configuration and have Drupal automatically enable the right one. The classic example: you ship
four variants of a listing View — one that integrates with Search API, one with Content Lock,
one with both, and one with neither — and Configuration Selector enables whichever variant fits
the modules actually installed, choosing between competing variants by a priority number.

It works entirely through configuration YAML, not a point-and-click UI. A config entity opts
into a "feature" by adding two third-party settings — a shared **feature** name and an integer
**priority** — plus `config_selector` in its module dependencies. All variants that share a
feature name compete; whenever a module is installed or uninstalled, the module recalculates and
keeps the single highest-priority variant that is currently enabled, disabling the rest.
Crucially, it only ever **disables** configuration, never deletes it, so the switch is
reversible and any editor customizations on a losing variant survive.

Out of the box it provides config schema for core **Views** (`views.view.*`) and **Blocks**
(`block.block.*`), so those two work with zero extra effort; other config entity types need a
small schema addition of their own and must be *disable-able* (many config entities, such as
fields or node types, cannot be disabled and are unsupported). There is an admin list at
`/admin/structure/config_selector` showing which variant is active per feature, but the
add/edit forms are intentionally stubbed — this is a module for developers editing YAML, not a
click-driven configurator. It has **no permissions of its own** (the admin list reuses core's
*Administer site configuration*) and **no Drush commands**, and works on Drupal 10.2+ / 11.

This guide is written for a **human** — here, a developer or site builder. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the feature/priority YAML pattern, how selection
   works on install and uninstall, adding schema for other entity types, and the admin list.

## Where it lives in the admin menu

A read-only-ish overview lives at **Structure → Configuration Selector**
(`/admin/structure/config_selector`), gated by *Administer site configuration*. The menu link
only appears once at least one feature exists. All real work is done in your module's or
profile's configuration YAML — see [Configuration](configuration/index.md).

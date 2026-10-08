# Config Distro — manual setup guide

**Config Distro** (`config_distro`) is a framework for a very specific problem:
you run a Drupal **distribution** (or a set of modules) that ships its own default
configuration, a new release changes that configuration, and you want to pull
those updates into a live site — *without* trampling the customizations that site
has made. Core's configuration import is all-or-nothing against your sync
directory; Config Distro provides a separate, event-driven pipeline dedicated to
distribution updates.

The way it works is modeled on Configuration Split. Config Distro exposes a
"distribution" configuration storage. Each time that storage is read, it starts
from a copy of your active configuration and fires a **transform** event;
companion modules subscribe to that event and rewrite the storage to represent the
configuration the distribution now wants. Config Distro then compares that desired
state against your active configuration and lets you preview and import just the
differences — through a UI or a Drush command. When an import finishes, it fires
an **import** event so other modules can react.

An important thing to understand: **on its own, Config Distro does nothing
visible.** It is infrastructure. Without a companion module to populate the
distribution storage — most commonly
[Configuration Synchronizer](https://www.drupal.org/project/config_sync)
(`config_sync`) — the distribution storage is identical to your active
configuration, so the update screen and the Drush command will both report "no
changes to import." You install Config Distro because a distribution or a
companion tool needs it.

It ships two submodules: **config_distro_filter** (a deprecated bridge that runs
Config Filter plugins during the transform) and **config_distro_ignore** (lets you
retain specific configuration during distribution imports so your customizations
survive).

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the distro storage service, the transform and
import events, and the exact route/form details — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, add a companion like Config Sync, and choose the submodules you
   need.

## Where it lives in the admin menu

Config Distro adds a **Distribution Update** screen under
**Configuration → Development → Distribution Update**
(`/admin/config/development/distro`), with a *Synchronize* tab. This is not a
settings page — it is the review-and-import screen for pending distribution
changes. It has no settings form and no configuration object of its own; its
behavior comes entirely from the transform-event subscribers provided by
companion modules.

Access to the screen (and its diff pages) is gated by the **Synchronize distro
configuration** permission (`synchronize distro configuration`), which is
security-sensitive — grant it only to trusted administrators.

## How to use it

Once a companion module (such as Config Sync) is populating the distribution
storage, there are two ways to apply pending updates:

- **Through the UI.** Go to **Configuration → Development → Distribution Update**
  (`/admin/config/development/distro`). The screen lists the differences between
  the distribution's desired configuration and your active configuration; you can
  view a unified diff for any item and then import the changes.

- **From the command line** with Drush:

  ```bash
  drush config-distro-update          # alias: cd-update
  drush cd-update --preview=diff      # show a unified diff instead of a change list
  ```

  This previews the pending changes and, after you confirm, imports them — exactly
  what the UI does. The `--preview` option takes `list` (the default change table)
  or `diff` (a unified diff). If there is nothing to import, it reports so and
  stops.

To protect specific configuration from being overwritten during these imports,
enable the **config_distro_ignore** submodule (see
[Installation](installation/index.md)).

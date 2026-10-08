# Snipper — manual setup guide

**Snipper** (`snipper`) adds single‑item import and export to Drupal's
Configuration Synchronization page. Normally a config import is all‑or‑nothing:
you either import everything that is staged or nothing. That is fine for a
deployment, but it is awkward during development when one fix is ready and forty
other changes are not. Snipper lets you act on **one configuration item at a
time**, right from the sync page.

Once enabled, every item listed on **Configuration → Development →
Configuration synchronization** gains three extra operation links next to the
existing *View differences* link: **Import** (write that single item from the
sync directory into the active/database configuration), **Export** (write the
active version of that item back to the sync directory), and **Download YML**
(download the item as a `.yml` file on the spot). No separate page, no
copy‑pasting YAML, and no Drush command required. It works with configuration
collections (such as language) too.

The module is genuinely zero‑configuration: install it, enable it, and the links
appear. Its only dependency is core's **Configuration Manager** (`config`)
module, which is enabled by default. A couple of things are worth knowing before
you rely on it. First, Import and Export write directly to the active or sync
storage **without running the full configuration import pipeline** — hooks,
validators, and dependency ordering are not invoked, so these operations suit
individual settings, fields, views, and display modes rather than enabling or
disabling modules or themes. Second, exported configuration can contain sensitive
settings, so review an item's contents before you share or import it, to avoid
leaking or overwriting a secret. Both Import and Export show a confirmation page
before making any change.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings form. After enabling the module, go to **Configuration →
Development → Configuration synchronization** (`/admin/config/development/configuration`).
Each configuration item that differs between the active site and the sync
directory now shows **Import**, **Export**, and **Download YML** links alongside
*View differences*. Click the one you need, confirm on the following page (for
Import and Export), and Snipper applies just that single item.

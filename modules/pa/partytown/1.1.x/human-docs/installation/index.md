# Installation

Getting Partytown running is a three‑part job: install the module, install the
Partytown JavaScript library, and then configure which scripts to offload (the
last step is covered in [Configuration](../configuration/index.md)).

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Partytown JavaScript library** — the module attaches and configures
  Partytown, but the library itself is a separate front‑end asset you must install
  (see below).

## Install the module with Composer

From the project root:

```bash
composer require drupal/partytown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/partytown -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the Partytown JavaScript library

Partytown relocates scripts using a locally hosted worker, so the Partytown
library files need to be available to your site. Follow the module's project‑page
instructions for placing the library (for example under your libraries directory).
Without the library present, the module has nothing to hand your scripts to.

## Enable the module

```bash
drush en partytown -y
```

## Verify it worked

After enabling, open the Partytown settings UI (see
[Configuration](../configuration/index.md)) and confirm the form loads. Once you
have offloaded a script, load a front‑end page and use your browser's developer
tools to confirm the third‑party script is executing from the Partytown web worker
rather than the main thread.

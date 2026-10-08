# Config Override Core Fields — manual setup guide

**Config Override Core Fields** (`config_override_core_fields`) is a small helper
module that annotates Drupal's core configuration forms so that each form field
declares **which config object and key it edits**. It adds a hint of the form
`config.object:key` to the relevant elements — for example, tagging the *Site name*
field on the Basic site settings form as `system.site:name`.

On its own it does nothing you can see. It provides no user-facing feature, no
settings, and no permissions — it is purely a **data provider** for other modules.
The main consumer is [COI (Config Override Inspector)](https://www.drupal.org/project/coi),
which reads these hints to detect when a field's value has been overridden (for
example in `settings.php`) and then flag, disable, or hide that field so admins
don't waste time editing a value that won't take effect.

The module covers a fixed list of core system settings forms — site information,
performance, cron, file system, logging, maintenance mode, themes, update manager,
user settings, search, and the Views UI settings — and safely includes a few
contrib-aware keys only when those modules are present. You normally install it
because another module (usually COI) requires it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure and nothing to click — enabling the module simply
adds the config-key metadata to core's system settings forms. To get a visible
benefit, install and enable a **consumer** module that reads the hints, most
commonly [COI](https://www.drupal.org/project/coi). Once COI is enabled and a
config override exists, overridden core fields are flagged automatically on their
settings pages.

If you are a developer, you can extend the coverage to your own forms by setting a
`#config['key']` hint on a form element in your module's `hook_form_alter()` — see
the [`agent/`](../agent/start.md) docs for the exact convention.

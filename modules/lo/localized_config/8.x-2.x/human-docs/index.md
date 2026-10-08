# Localized Configuration — manual setup guide

**Localized Configuration** (`localized_config`) is a **developer framework** that
sits on top of Drupal's configuration system and lets a module define settings
that can be stored **globally or per language/locale** from a single, centralized
interface. It is especially useful in multilingual and multisite setups, where you
want some values shared across the board and others to differ by language —
marketing strings, legal text, contact details — without maintaining a full
string-translation workflow for each one.

It is important to be clear about the audience: **this module does not do anything
useful for a site builder on its own.** It provides the plumbing — a plugin type
(`LocalizedConfigPluginManager`), storage that writes global values to
`localized_config.PLUGINNAME.yml` and per-language values under
`languages/LANGCODE/localized_config.PLUGINNAME.yml`, a helper service for reading
values back with the right per-language priority, a decorator that feeds those
values into Drupal's config overrides, and a Twig extension so templates can read
them. A developer writes a plugin against that framework; the framework handles
the rest. A bundled example submodule, **Localized Configuration Example**, shows a
working plugin you can copy from.

Access is properly gated. The general interface requires the **Access localized
config** permission, the settings form requires **Access localized config
settings**, and each enabled plugin gets its own generated edit permission — so
you can grant specific roles the ability to edit specific localized settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and, for a working example, the example submodule).
2. [Configuration](configuration/index.md) — the settings form (language filtering
   and enabling plugins) and where to edit values.

## Where it lives in the admin menu

- **Settings:** **Configuration → Localized configuration → Settings**
  (`/admin/config/localized/settings`) — controls language filtering and which
  plugins are enabled.
- **Editing values:** `/admin/config/localized/{language}` — the localized editing
  form, with a tab per language you're allowed to edit, backed by
  `LocalizedConfigForm`.

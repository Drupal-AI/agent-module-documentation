# Locale: Config import — manual setup guide

**Locale: Config import** (`config_import_locale`) gives you control over what
happens to your *interface translations* when Drupal imports configuration. Out
of the box, core re-applies any translations that are shipped inside imported
config, which can silently overwrite — or even wipe — the UI string
translations you carefully edited under *Translate interface*. This module steps
in and lets you decide whether that happens.

It works by quietly swapping two core services (`locale.config_subscriber` and
`locale.config_manager`) for its own versions. Those versions consult a small
settings form before they write anything: you can keep Drupal's default
behaviour, keep existing translations while still allowing brand-new ones to be
added, or freeze interface translations entirely so a config import never touches
them. You can also limit the chosen policy to a single context — only the command
line (for example `drush config:import` during a deployment), only the web UI, or
everywhere.

This is a small, focused module aimed at multilingual sites that deploy
configuration between environments. If a translation team's hand-tuned strings
keep getting clobbered every time you sync config, this is the fix. It has no
plugins, no Drush commands, and just one config object and one permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and clear caches so the service swap takes effect.
2. [Configuration](configuration/index.md) — the two settings (overwrite
   behaviour and context), field by field.

## Where it lives in the admin menu

The settings form sits under *Translate interface* as a tab, at
**Configuration → Regional and language → User interface translation →
Config import settings**
(`/admin/config/regional/translate/config-import-settings`). Access is gated by
the **Administer config import locale** permission.

## How to use it

Enable the module, clear caches (`drush cr`) so Drupal rebuilds the service
container with the module's replacement services, then open the settings form and
choose your policy. Most sites that want to protect translations set the
behaviour to **No overwrites** (keep what editors customised, still allow new
strings) and, if translations only get clobbered during deployments, limit it to
the **CLI** context. From then on, config imports respect your choice.

# Config Split — manual setup guide

**Config Split** (`config_split`) lets you split part of your configuration into
separate sets that are active only in certain environments — for example, enable
the **Devel** module on your dev site but not on production — while still keeping
one shared configuration export. Drupal's core configuration management assumes a
single sync directory that is identical across every environment, which makes it
awkward to carry developer-only modules or per-environment settings. Config Split
solves this by defining **Configuration Split** entities, each describing a subset
of configuration (chosen by module, by theme, or by explicit config-name lists) and
a storage location to hold it. When a split is active, that subset is filtered out
of the main export and written to the split's own storage; on import the split's
config is merged back in.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to creating your first
split and activating it per environment. Config Split builds on core's
**Configuration Manager**, so it plugs straight into the normal
`drush config:export` / `config:import` workflow. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Configuration Split setting list page with the Add button](images/list.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Development → Configuration
synchronization → Configuration Split**
(`/admin/config/development/configuration/config-split`). That page lists every
split defined on the site and gives you an **+ Add Configuration Split setting**
button to create a new one.

## Contents

1. [Installation](installation/index.md) — install Config Split with Composer and
   enable it alongside core's Configuration Manager.
2. [Configuration](configuration/index.md) — the splits list and how splits take
   part in configuration import and export.
3. [Creating a split](creating-a-split/index.md) — add a split, choose its storage
   and the config it contains, and activate it per environment.

# Configuration Filter — manual setup guide

**Configuration Filter** (`config_filter`) is an **API‑only** module. It lets
other modules intercept and transform Drupal's configuration as it is imported
from — or exported to — the sync storage, using `ConfigFilter` plugins. On its
own it changes nothing about your site; you install it because another module
needs it, or because you are a developer building config transformations.

Drupal core (since 8.8) has a config storage *transformation* API that fires
events when configuration is synchronized between the active database and the
exported YAML files. Configuration Filter wraps that low‑level API in a simpler,
pluggable interface. A `ConfigFilter` is a plugin that can **rewrite, add,
remove, or hide** configuration on read and write operations against a storage
(typically `config.storage.sync`). The module provides the plugin type
(annotation, interface, base class, and plugin manager), a `FilteredStorage`
decorator that applies an ordered chain of filters to any storage, and a factory
that assembles the filtered sync storage. Filters are sorted by weight, can be
switched on or off with a `status` flag, and can target specific storages.

The module has **no UI, no permissions, no settings, and no dependencies** of
its own — there is genuinely nothing to configure. You never really "use" it
directly; you depend on it from a module that supplies filters. Its best‑known
consumer is **Configuration Split** (`config_split`), which uses filters to
split site configuration per environment (dev/stage/prod). For providers outside
the plugin system, the module also ships handy `ReadOnlyStorage` and
`GhostStorage` decorators and a way to register an alternative filter manager.

This guide is written for a **human** installing the module. If you are a
developer who wants to write a filter — or an AI coding agent — read the sibling
[`agent/`](../agent/start.md) docs, which cover the plugin, the storage
decorators, and the service API.

## Contents

1. [Installation](installation/index.md) — install and enable the module (and
   the note that there is nothing to configure).

## How to use it

Configuration Filter has **no settings page** (`configure` is `null`) and adds
nothing to the admin menu. It becomes useful in one of two ways:

- **As a dependency.** Install a module that provides `ConfigFilter` plugins —
  most commonly **Configuration Split** — and Configuration Filter quietly does
  its job during `drush config:import` / `config:export` (and the UI equivalents
  at **Configuration → Development → Configuration synchronization**). You do not
  interact with Configuration Filter itself.
- **As a developer.** Provide your own `ConfigFilter` plugin (for example, to
  strip API keys and passwords out of exported config, or to inject
  environment‑specific values on import). See the sibling
  [`agent/`](../agent/start.md) docs for the plugin interface, the
  `config_filter.storage_factory` service, and the storage decorators.

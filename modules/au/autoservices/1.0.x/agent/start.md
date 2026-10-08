<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autoservices (autoservices) — agent index

A developer-only module with **no runtime surface** (no routes, forms, permissions, config, or
`*.services.yml`). It ships a single Symfony `ServiceProvider`
(`Drupal\autoservices\AutoservicesServiceProvider`, auto-discovered by the `<Module>ServiceProvider`
class-name convention) that runs at **container-compile time** and registers classes into the
container **by directory convention** — no YAML definition needed. For every installed module it
scans three sub-directories of that module's `src/` and registers each `*.php` class it finds under
the class's **fully qualified name** as the service id (`setPublic(TRUE)`); an id already defined
(e.g. by an explicit `*.services.yml`) is left untouched (`register()` skips it,
`AutoservicesServiceProvider.php:46`). Its own README states it *"does nothing by itself and it
should be installed as a dependency."*

The three convention directories (`AutoservicesServiceProvider.php:22-60`): **`src/Autoservice/`** →
autowired plain `Definition`; **`src/AutoPluginManager/`** → `ChildDefinition` of
`default_plugin_manager`, **not** autowired; **`src/AutoEventSubscriber/`** → autowired and tagged
`event_subscriber`. Separately, `aliasInterfaces()` (`:67`) walks every existing definition whose id
**starts with a lowercase letter** (i.e. a conventional service id, not a FQCN one) and, when a
`<serviceClass>Interface` exists and is not already aliased, registers an alias from that interface
name to the service id — so autowiring can resolve a constructor type-hinted on the interface. That
alias set is the substantive work; it is what to check when a particular interface fails to autowire.

- Depends on: nothing (no `dependencies:` in info.yml). Core: `^10 || ^11`. Package: `Container`.
- **No** settings page / `configure` route, **no** permissions, **no** drush, **no** config schema,
  **no** plugin types defined, **no** hooks. It does not register itself in any `*.services.yml`.
- Trade-off to weigh: convention-registered services appear in **no YAML file**, so `drush`
  service listings and a text search for the service id will not find them.

## What you'd do → where

- **Register a service / plugin manager / event subscriber with no YAML, and understand the exact
  service ids, tags, autowiring, and interface-alias rule** → [api/conventions.md](api/conventions.md)

## Key facts (real machine names)

- Service provider class: `Drupal\autoservices\AutoservicesServiceProvider`
  (`src/AutoservicesServiceProvider.php`) — no `*.services.yml`, discovered by naming convention.
- Convention directories (relative to any module's `src/`): `Autoservice/`, `AutoPluginManager/`,
  `AutoEventSubscriber/`.
- Registered service id = the class's fully qualified name, e.g.
  `Drupal\<module>\Autoservice\<ClassName>`. All registered definitions are `public`.
- `Autoservice/` → `autowire: TRUE`. `AutoPluginManager/` → parent `default_plugin_manager`,
  `autowire: FALSE`. `AutoEventSubscriber/` → `autowire: TRUE`, tag `event_subscriber`.
- Interface-alias rule: alias `\<ServiceClass>Interface` → `<service_id>`, only for service ids that
  begin with a lowercase letter, when the `Interface`-suffixed class exists and no alias exists yet.
- Note: the README still calls the third directory `AutoEventListener` with an `event_listener` tag;
  the **source** uses `AutoEventSubscriber` and the `event_subscriber` tag — the source is correct.

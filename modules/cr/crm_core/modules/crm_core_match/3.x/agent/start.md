<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core Match (crm_core_match) — agent index

A framework for finding duplicate CRM Core contacts. Provides a `crm_core_match` config entity
(Matcher) plus two plugin frameworks — **matching engines** and **field handlers** — and a shipped
**Default Matching Engine**. Part of the CRM Core suite. Core `^9 || ^10 || ^11`, GPL-2.0-or-later.

Depends on: `crm_core_contact`, core `options`, `datetime`. `configure` route id
`crm_core_match.match` (per `info.yml`); the actual list route is `entity.crm_core_match.collection`
at `/admin/config/crm-core/match`.

## Config entity

- **`crm_core_match`** (`src/Entity/Matcher.php`) — `@ConfigEntityType`, `config_prefix =
  "matcher"`, `admin_permission = "administer matchers"`. Exported keys: `id`, `label`,
  `description`, `plugin_id`, `configuration`. `getPlugin()` instantiates the engine via
  `crm_core_match_matcher_manager()`; `match(ContactInterface)` proxies to the engine.
  `preSave()` writes back `getPlugin()->getConfiguration()`.
- Default config installed for `individual`, `organization`, `household`
  (`config/install/crm_core_match.matcher.*.yml`).

## Plugin frameworks (`crm_core_match.services.yml`)

- **`plugin.manager.crm_core_match.matchers`** — engines in `Plugin/crm_core_match/engine`,
  interface `engine\MatchEngineInterface`, annotation `Annotation\CrmCoreMatchEngine`
  (`id`, `label`, `summary`).
- **`plugin.manager.crm_core_match.match_field`** — field handlers in
  `Plugin/crm_core_match/field`, interface `field\FieldHandlerInterface`, annotation
  `Annotation\CrmCoreMatchFieldHandler` (`field`).

## Shipped plugins

- Engine `default` — `DefaultMatchingEngine` (extends `MatchEngineBase`).
- Field handlers: `NameFieldHandler`, `EmailFieldHandler`, `TelephoneFieldHandler`,
  `PhoneNumberFieldHandler`, `AddressFieldHandler`, `DateFieldHandler`,
  `NumberIntegerFieldHandler`, `StringFieldHandler`, `TextFieldHandler`, `SelectFieldHandler`
  (all under `Plugin/crm_core_match/field`, extending `FieldHandlerBase`).

## Routes / permissions

- `/admin/config/crm-core/match` (list, perm `administer matchers`) + add/edit/delete entity forms
  (`_entity_create_access` / `_entity_access`). Controller `MatcherController::editTitle` for the
  edit-page title.
- Permissions: `administer matchers`, `view matching engine rules settings`,
  `view match information`.

Note: `crm_core_match.module` still contains commented-out Drupal-7 `hook_menu`/`hook_hook_info`
port stubs; they are dead in D9+ and define no live routes.

## Solution docs

- **Matcher config, Default engine scoring, field handlers, writing your own** →
  [plugins/matching.md](plugins/matching.md)

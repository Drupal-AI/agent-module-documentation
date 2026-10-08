<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Augmentor (augmentor) — agent index

A **framework** for running configurable **"augmentor" plugins** that transform/enrich text and
content through external AI/LLM and web services. The base module ships the plugin type, manager,
admin UI, field type/widgets, and entity Actions — but **no provider plugin** (providers such as
OpenAI, Google Cloud Vision, NLP Cloud live in companion projects; a bundled **Demo** submodule is
the blueprint). Package `Augmentor`. Depends on **`key`** (Key module). Core `^10.3 || ^11 || ^12`.
License GPL-2.0-or-later. Version 1.2.3 (dir `1.2.x`).

## Solution docs

- **The augmentor plugin type — define a provider, execute contract, Key handling** →
  [plugins/augmentor-plugin-type.md](plugins/augmentor-plugin-type.md)
- **Admin UI: create/order/edit/delete augmentors, config object, routes, permissions** →
  [config/augmentors-admin.md](config/augmentors-admin.md)
- **Invoke augmentors: field type + widgets, the execute AJAX controller, entity Actions** →
  [api/invoke.md](api/invoke.md)
- **Extend: pre/post execute hooks and input/output alter events** →
  [api/hooks-and-events.md](api/hooks-and-events.md)

## What it actually provides (from source)

- **Plugin type** `augmentor` — namespace `Plugin/Augmentor`, manager
  `AugmentorManager` (service `plugin.manager.augmentor.augmentors`), interface `AugmentorInterface`,
  base `AugmentorBase`, attribute `Attribute\Augmentor` (+ legacy annotation). Alter hook
  `augmentor_info`, cache bin `augmentor_plugins`.
- **Field type** `field_augmentor_type` (`AugmentorItem`) — a single big-text column, default widget
  `augmentor_default_widget`, default formatter `field_augmentor_formatter` (formatter renders
  nothing; the value is written by widget JS).
- **Field widgets** (all extend `AugmentorBaseWidget` ← core `TextareaWidget`, except the thin
  `AugmentorWidget`): `augmentor_default_widget`, `augmentor_select_widget`,
  `augmentor_select_regex_widget`, `augmentor_tags_widget`, `augmentor_summary_widget`,
  `augmentor_file_widget`, plus `augmentor_widget`.
- **Actions** (derived per content entity type via `AugmentorActionDeriver`):
  `entity:augmentor_action` (`AugmentorAction`) and `entity:augmentor_action_minimal`
  (`AugmentorActionMinimal`).
- **Routes** (`augmentor.routing.yml`): admin list/add/edit/delete forms + one execute endpoint
  `augmentor.augmentor_execute` (`/augmentor/execute/augmentor`, `AugmentorController::execute`).
- **Permissions** (`augmentor.permissions.yml`): `administer augmentor`, `add augmentor`,
  `edit any augmentor`, `delete any augmentor`, `execute augmentor`.
- **Config object** `augmentor.settings` (key `augmentors`: a sequence keyed by UUID). Schema in
  `config/schema/augmentor.schema.yml` (also `action.configuration.entity:augmentor_action:*`).
- **Services**: the manager, `AugmentorEventSubscriber` (event_subscriber), `Hook\AugmentorHooks`
  (autowired hook_help).
- **Hooks/events**: `hook_pre_execute(&$request_body)`, `hook_post_execute(&$result, &$request_body)`
  (`augmentor.api.php`); events `AugmentorInputEvent::ALTER` (`augmentor.input.alter`),
  `AugmentorOutputEvent::ALTER` (`augmentor.output.alter`).
- **Library** `augmentor/augmentor_library` (`js/augmentor_library.js`) — the front-end that POSTs to
  the execute endpoint and writes results back into the form. No Drush.

## Submodules (own doc trees)

`augmentor_eca` (ECA action), `augmentor_search_api_processors` (Search API processors),
`augmentor_demo` (blueprint provider), `augmentor_ckeditor4`, `augmentor_ckeditor5` (editor buttons).
This project bundles them under `modules/`.

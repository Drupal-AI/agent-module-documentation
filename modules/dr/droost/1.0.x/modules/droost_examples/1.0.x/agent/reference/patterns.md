<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Examples — the pattern catalog

Every file here was produced by a Droost scaffolder blueprint (`drush droost:scaffold <blueprint>`) and passes
phpcs (Drupal + DrupalPractice) and PHPStan at max. **Read the source; do not run this in production.**

## Enable
```bash
drush en droost_examples -y   # depends on droost + core text
```

## Pattern -> file -> blueprint
| Pattern | File | Blueprint |
|---|---|---|
| MCP `#[Tool]` plugin | `src/Plugin/Tool/ExampleTool.php` | `mcp-tool` |
| Autowired service | `src/ExampleService.php` | `service` |
| Event subscriber | `src/EventSubscriber/ExampleSubscriber.php` | `event-subscriber` |
| `#[Block]` plugin | `src/Plugin/Block/ExampleBlock.php` | `block` |
| Form (`FormBase`) | `src/Form/ExampleForm.php` | `form` |
| OOP `#[Hook]` | `src/Hook/ExampleEntityHooks.php` | `hook` |
| Drush command | `src/Drush/Commands/ExampleCommands.php` | `drush-command` |
| Queue worker | `src/Plugin/QueueWorker/ExampleQueueWorker.php` | `plugin --plugin-type=queue-worker` |
| Action | `src/Plugin/Action/ExampleUnpublishAction.php` | `plugin --plugin-type=action` |
| Field formatter | `src/Plugin/Field/FieldFormatter/ExampleTrimmedFormatter.php` | `plugin --plugin-type=field-formatter` |
| Field widget | `src/Plugin/Field/FieldWidget/ExampleTextareaWidget.php` | `plugin --plugin-type=field-widget` |
| Field type | `src/Plugin/Field/FieldType/ExampleRatingItem.php` | `plugin --plugin-type=field-type` |
| Content entity | `src/Entity/ExampleWidget.php` (+ interface, list builder, forms, access) | `content-entity` |
| Config entity | `src/Entity/ExampleProfile.php` (+ interface, list builder, form) | `config-entity` |
| Standalone access handler | `src/ExampleProfileAccessControlHandler.php` | `access-handler` |
| Route subscriber | `src/Routing/ExampleRouteSubscriber.php` | `route-subscriber` |
| Kernel test (runs in CI) | `tests/src/Kernel/ExamplesSmokeTest.php` | `kernel-test` |
| Single Directory Component | `components/example_card/` (`*.component.yml` + Twig) | `sdc` |
| Views field/filter/sort | `src/Plugin/views/{field,filter,sort}/Example*.php` (+ views_data) | `views-handler` |
| views_query_alter stub | `src/Hook/ExampleViewsQueryAlter.php` | `hook --hook=views_query_alter` |

## The two entity types
- **`example_widget`** (content): admin at `/admin/structure/example-widget` (`administer example_widget`), collection
  under Content, canonical/add/edit/delete local tasks. Declares a `text_long` base field — hence the core `text` dep.
  Access via `ExampleWidgetAccessControlHandler`.
- **`example_profile`** (config): collection/add/edit/delete under `/admin/structure/example-profile`
  (`administer example_profile`). Access via `ExampleProfileAccessControlHandler`.

Both `administer` permissions are `restrict access: true`; per-operation `view|edit|delete|create` perms also exist.

## Config
`droost_examples.settings` ships an install default (`config/install`) with a full schema (`config/schema`):
`label`, `enabled`, `items_per_page`, a `tags` sequence and an `advanced.timeout` mapping. Two
`system.action.example_widget_*` configs ship too.

## Regenerating
Re-run any `drush droost:scaffold <blueprint> …` to regenerate a file or see its options. The module carries a
small, exact-anchored `phpstan-baseline.neon` for irreducible entity-API false positives; run
`vendor/bin/phpstan analyse -c phpstan.neon` inside the module to see it green.

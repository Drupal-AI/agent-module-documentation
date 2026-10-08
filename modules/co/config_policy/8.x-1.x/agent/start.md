<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Policy — agent start

info.yml name **Config Policy** (`config_policy`), version **8.x-1.4-alpha4**, package SWIS.
Core `^10 || ^11`. Depends on core `field`. Not covered by Drupal's security advisory policy.

Validates — and optionally auto-fixes — site configuration against policies you define. A
**policy** is a `config_policy` config entity (config prefix `field`) that holds an ordered
list of **rules**. Rules are `ConfigPolicyRule` plugins; each rule targets config objects by
name wildcard (`configPatterns`, e.g. `field.storage.*.*`, `core.extension`) and can validate,
fix, and/or block non-conforming config at form-submit time.

## How it runs

- **UI** at `/admin/structure/config_policy` (entity list, add/edit/delete policy, add/edit/
  delete rules, per-policy and global validate/fix forms). Every route requires the core
  **`administer site configuration`** permission; the entity's `admin_permission` is the same.
- **Drush**: `drush config-policy:validate` (alias `cpv`), options `--fix`, `--sync`, `--y`.
  Validates all loaded config (or `--sync` = the sync storage, or a name-prefix argument);
  `--fix` applies fixable rules after a destructive-change confirmation. See `usage.md`.
- **Runtime hooks** (`ConfigEventsSubscriber`):
  - `ConfigEvents::SAVE` → validates the saved config (runtime), applies fixes for rules whose
    `fix_runtime` setting is on, and surfaces errors/warnings via Messenger.
  - `ConfigEvents::IMPORT_VALIDATE` → validates the import changelist against rules whose
    `validate_import` is on, logging errors onto the config importer (can block an import).
  - `hook_form_alter` (admin routes only) → each `PreventableRuleInterface` rule whose
    `prevent` setting is on and whose `preventableForms` lists the form id may alter the form
    to stop non-conforming config being saved.

## Built-in rules (`Plugin/ConfigPolicyRule/`)

- `required_field` — RequiredField: a field storage must exist on an entity type/bundles;
  fix creates the missing `FieldConfig`. Pattern `field.storage.*.*`.
- `module_validation` — ModuleValidation: deny/advisory module lists; validate flags installed
  denied (error) / advisory (warning) modules, fix **uninstalls** denied modules, prevent
  disables their checkboxes on `system_modules`. Pattern `core.extension`.
- `empty_entity_view_display` — EmptyEntityViewDisplay: keeps chosen view modes empty; fix
  clears `content`, prevent adds a form validator. Pattern `core.entity_view_display.*.*.*`.
- `non_reusable_field` — NonReusableField: removes `entity__field`-named storages from the
  reuse list on `field_ui_field_storage_add_form` (prevent-only, no config pattern).

## Extending — the `ConfigPolicyRule` plugin type

Write a plugin under `src/Plugin/ConfigPolicyRule/` with the `@ConfigPolicyRule` annotation
(`id`, `label`, `description`, `configPatterns`, optional `preventableForms`, `weight`). Extend
`ConfigRuleBase` (or `WeightedConfigRuleBase`) and implement the capability marker interfaces you
need — `ValidatableRuleInterface`, `FixableRuleInterface`, `PreventableRuleInterface`,
`ConditionalRuleInterface` (`applies()` gates a rule per-config). Manager service
`plugin.manager.config_policy.rule`; alter hook `hook_config_rule_info_alter`. Details and the
result/repository/service API → [plugins/config_policy.md](plugins/config_policy.md).

## Key files

- `config_policy.routing.yml`, `config_policy.services.yml`, `drush.services.yml`, `config_policy.module`
- `src/Policy/ConfigPolicyService.php` — validate/fix/prevent orchestration, wildcard matching
- `src/Policy/ConfigPolicyRepository.php` — loads enabled policies (`findAll`, `findByRule`)
- `src/Entity/ConfigPolicy.php` — the config entity + rule plugin collection
- `src/EventSubscriber/ConfigEventsSubscriber.php` — save/import hooks
- `src/Drush/Commands/ValidateCommand.php` — the `cpv` command
- `config/schema/config_policy.schema.yml` — entity + per-rule settings schema

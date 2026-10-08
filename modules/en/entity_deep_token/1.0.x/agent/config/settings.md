<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object, route and permission

## Install / enable

- `composer require drupal/entity_deep_token` then `drush en entity_deep_token -y`.
- Requires the **Token** module (`token:token` in `entity_deep_token.info.yml` `dependencies`);
  Composer/Drush pulls it in. Core `^10 || ^11`. No PHP libraries, no `composer.json` in the project.

## Route and menu

- Route `entity_deep_token.settings` (`entity_deep_token.routing.yml`): path
  `/admin/config/system/settings`, `_form` `Drupal\entity_deep_token\Form\SettingsForm`, title
  "Entity deep token settings", requirement `_permission: 'administer site configuration'`.
- Menu link `entity_deep_token.settings` (`entity_deep_token.links.menu.yml`) under
  `system.admin_config_system` (Configuration → System), weight 10.
- `info.yml` sets `configure: entity_deep_token.settings`, so the modules page shows a Configure link.

## Form — `SettingsForm` (`src/Form/SettingsForm.php`)

- `final class SettingsForm extends ConfigFormBase`. `getFormId()` = `entity_deep_token_settings`.
  `getEditableConfigNames()` = `['entity_deep_token.settings']`.
- `buildForm()` lists every entity type whose class `is_subclass_of(..., ContentEntityInterface::class)`
  via `entity_type.manager` `getDefinitions()`, and renders one required `checkboxes` element
  `content_list` (title "Content Type(s)") keyed and labelled by entity type id, defaulted from config.
- `validateForm()` only calls the parent. `submitForm()` saves `content_list` (the raw checkbox values,
  i.e. `['node' => 'node', 'user' => 0, ...]`) into `entity_deep_token.settings` and calls parent.

## Config object

- `entity_deep_token.settings` with a single key `content_list` — the set of content entity type ids
  eligible to be the source entity for token resolution (see
  [../tokens/deep-token.md](../tokens/deep-token.md), step 2).
- The project ships **no** `config/install` defaults and **no** `config/schema` file
  (`provides_config_schema` is false); the config object is created on first form save.

## Operate

1. Enable the module (Token comes with it).
2. Go to Configuration → System → "Entity deep token settings" and check the entity type(s) that
   deep tokens should start from (e.g. `node`, `taxonomy_term`), then save.
3. Place `[entity-deep-token:...]` tokens in any token-aware field where one of those entities is in
   context.

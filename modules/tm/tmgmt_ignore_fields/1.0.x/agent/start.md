<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT Ignore Fields (tmgmt_ignore_fields) — agent index

Lets an admin globally exclude named fields from **TMGMT** translation jobs. Mechanism:
`hook_tmgmt_source_plugin_info_alter()` (in `tmgmt_ignore_fields.module`) swaps the `content` source
plugin's class from tmgmt_content's `ContentEntitySource` to this module's
`IgnoreFieldsContentEntitySource`. That subclass overrides `extractTranslatableData()` — it reads the
`ignore_fields` list from config and `unset()`s any matching top-level key from the data array that
TMGMT is about to send to a translator. Selection is done on one settings form that lists every base
and configurable field of every content entity type as checkboxes.

The ignore list is a **flat list of field machine names** (e.g. `body`, `field_ref`), not scoped per
entity type or bundle — ignoring a name excludes it from every content entity that has it. Exclusion
is silent: an over-broad choice surfaces later as missing translations, not an error.

- Depends on: `tmgmt:tmgmt`, `tmgmt:tmgmt_content`. Composer: `php >=8.0`, `drupal/tmgmt ^1.17`.
- Core: `^10 || ^11`. Package: `tmgmt_ignore_fields`.
- Has a settings page. `configure` route: `tmgmt_ignore_fields_settings_form`
  (`/admin/config/content/tmgmt-ignore-fields`), gated by core perm `administer site configuration`.
- No module-defined permissions, no services, no drush, no plugin *types* defined (it provides one
  tmgmt Source plugin *class override*, not a new plugin type). Ships config schema.

## What you'd do → where

- **Choose which fields to exclude / set the ignore list from code / understand the swap-and-filter
  mechanism** → [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Route: `tmgmt_ignore_fields_settings_form` — path `/admin/config/content/tmgmt-ignore-fields`,
  `_form: \Drupal\tmgmt_ignore_fields\Form\IgnoreFieldsSettingsForm`,
  `_permission: 'administer site configuration'`.
- Menu link: `tmgmt_ignore_fields.settings` (parent `system.admin_config_content`, weight 100).
- Form id: `tmgmt_ignore_fields_settings` (class `IgnoreFieldsSettingsForm`, extends `ConfigFormBase`).
- Config object: `tmgmt_ignore_fields.settings`, single key `ignore_fields` — a `sequence` of `string`
  (field machine names). Install default: empty.
- Hook: `hook_tmgmt_source_plugin_info_alter($info)` — swaps `$info['content']['class']` from
  `Drupal\tmgmt_content\Plugin\tmgmt\Source\ContentEntitySource` to
  `Drupal\tmgmt_ignore_fields\Plugin\tmgmt\Source\IgnoreFieldsContentEntitySource`.
- Overriding source plugin class: `IgnoreFieldsContentEntitySource` (extends `ContentEntitySource`,
  implements `ContainerFactoryPluginInterface`); overrides `extractTranslatableData(ContentEntityInterface $entity, &$entityRegistry = [])`.
- Config schema: `config/schema/tmgmt_ignore_fields.schema.yml` (`type: config_object`).

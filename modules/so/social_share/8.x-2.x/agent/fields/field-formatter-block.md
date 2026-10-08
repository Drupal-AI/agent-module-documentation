<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, formatter & block

Install: `drush en social_share -y` (pulls in `typed_data`). No config UI route, permissions, or
config entities are added — everything is configured through core's field/display/block UIs.

## Field type — `SocialShareLinkItem` (`social_share_link`)
`src/Plugin/Field/FieldType/SocialShareLinkItem.php`. Single property `value`: `string`, varchar(255),
`Length max 255`, required. `default_widget = options_buttons`, `default_formatter = list_default`
(but you must switch the formatter to `social_share_link` to render actual buttons). Implements
`OptionsProviderInterface`; each stored value is a **plugin ID**.
- `getSettableOptions()` maps allowed plugin IDs → their labels. Allowed set comes from the storage
  setting `allowed_values` (a textarea, one plugin ID per line, split on `\r\n`); NULL = all plugins.
- `storageSettingsForm()` adds the `allowed_values` textarea ("Allowed plugins").
- `hook_field_widget_info_alter` (`social_share_field_widget_info_alter`) whitelists the field type
  for the core `options_buttons` widget.

## Formatter — `SocialShareLinkFormatter` (`social_share_link`)
`src/Plugin/Field/FieldFormatter/SocialShareLinkFormatter.php`. `field_types = {social_share_link}`.
Uses `SocialShareLinkConfigurationTrait`, `SocialShareLinkManagerTrait`, `PlaceholderResolverTrait`,
`TypedDataTrait`.
- `viewElements()` — for each field item (`$item->value` = plugin ID) calls
  `prepareLinkBuild($this->settings, $item->value, $bubbleable_metadata, $entity)` then
  `$share_link->build($template_suffix, ['entity' => …, 'view_mode' => …])`. Missing plugins throw
  `PluginException` and are silently skipped. `$template_suffix` =
  `__<entity_type>__<field_name>__<view_mode>`.
- `settingsForm()` builds one form field per **merged** context of all possible plugins (via
  `getMergedContextDefinitions()` → `buildContextConfigurationForm()`); values stored under
  `settings['context_values']`. `settingsSummary()` lists non-empty context values.
- `getMergedContextDefinitions()` derives possible plugin IDs from the field item's
  `getPossibleValues()`.

## Block — `SocialShareBlock` (`social_share_links`)
`src/Plugin/Block/SocialShareBlock.php`. `category = Social`, optional context
`entity = @ContextDefinition("entity:node")` (not required) available to tokens as `entity`.
- `defaultConfiguration()`: `allowed_plugins => []`.
- `buildConfigurationForm()`: an "Allowed plugins" textarea (one plugin ID per line, restrict +
  order; defaults to all plugin IDs) and a "Reload plugin configuration form" AJAX button that
  rebuilds the per-context fields (`updateContextConfigurationForm()` #process +
  `reloadContextConfigurationForm()` #ajax). Context fields are grouped in a `context_config`
  container/fieldset.
- `submitConfigurationForm()`: stores `context_values` and the split `allowed_plugins`.
- `build()`: iterates `allowed_plugins`, calls `prepareLinkBuild()` per plugin with the block's
  entity context, builds each with suffix `__block__<machine-name-suggestion>`; unknown plugins are
  skipped. Bubbleable metadata is applied to the elements.

## Shared build/config logic — `SocialShareLinkConfigurationTrait`
`src/SocialShareLinkConfigurationTrait.php` (marked `@internal`).
- `prepareLinkBuild(array $configuration, $pluginId, BubbleableMetadata $bmd, EntityInterface $entity
  = NULL)` — instantiates the plugin, then for each scalar `context_values[$name]` runs the Typed
  Data placeholder resolver
  (`$this->getPlaceholderResolver()->replacePlaceholders($value, $data, $bmd, ['clear' => TRUE])`)
  with `$data = [$entityTypeId => $entity->getTypedData()]` when an entity is present, and sets the
  resolved value as the plugin's context.
- `buildContextConfigurationForm()` — renders each merged context as a textfield (textarea for
  `mail_body`), `#maxlength 1024`, prefilled with the current value or the context default, marked
  required per the context definition, and annotated with "Used by: <plugins>".

## Access / gating
There are no module-defined routes or permissions. The field, formatter and block are configured
through core screens gated by the standard core permissions ("administer <entity> fields",
"administer <entity> display", "administer blocks"). Rendering happens wherever the field/block is
placed, subject to the host entity's/block's own access.

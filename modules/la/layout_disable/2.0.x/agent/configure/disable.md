<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable / re-enable layouts

## Form

- Route **`layout_disable`** → `/admin/config/user-interface/layout-disable`
  (`LayoutDisableForm`), permission **`access layout_disable`** (`restrict access: TRUE`).
- Lists all discovered layout plugins as checkboxes; ticking one disables it. `layout_onecol` and
  `layout_builder_blank` are omitted (core-required, cannot be disabled).

## Storage

Config object `layout_disable.settings`, key `disabled_layouts` — an **associative list keyed by
layout plugin id** (only disabled layouts are stored, to keep it small):

```yaml
disabled_layouts:
  layout_twocol_section: layout_twocol_section
  layout_fourcol_section: layout_fourcol_section
```

Config schema: `layout_disable.settings` → `disabled_layouts` is a `sequence` of strings.

## Mechanism

`hook_layout_alter(&$definitions)` reads `disabled_layouts` and does
`$definitions = array_diff_key($definitions, $disabled_layouts)`, so disabled ids are removed from
`\Drupal::service('plugin.manager.core.layout')->getDefinitions()` everywhere layouts are listed.

## Scriptable disable / enable

```php
$config = \Drupal::configFactory()->getEditable('layout_disable.settings');
// disable
$config->set('disabled_layouts', [
  'layout_fourcol_section' => 'layout_fourcol_section',
])->save();
// re-enable a layout: remove its key (or clear all)
$config->clear('disabled_layouts')->save();

// IMPORTANT: clear the layout plugin cache so the change takes effect
\Drupal::service('plugin.manager.core.layout')->clearCachedDefinitions();
```

Read back: `drush cget layout_disable.settings disabled_layouts`. Verify the effect:
`\Drupal::service('plugin.manager.core.layout')->hasDefinition('layout_fourcol_section')` returns
FALSE once disabled (after a cache clear).

## Notes

- The value is keyed by id (a checkboxes `[id => id]` map), matching `array_diff_key`'s key-based
  removal — a plain sequential list also works because only the keys are used.
- Disabling never uninstalls the providing module; it only hides the layout from selection.

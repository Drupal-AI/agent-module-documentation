<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set paragraph min/max limits on a field

There is no settings page. Limits are configured on the **Paragraphs field itself**, by switching its
reference method to Paragraphs Limits and entering per-type numbers.

## Via the UI

1. Edit the paragraph (entity_reference_revisions) field: *Manage fields → [field] → Edit*
   (field settings).
2. Set **Reference method** to **Paragraphs with limits** (`paragraphs_limits`).
3. In the paragraph-types table, each type now has **Lower limit** and **Upper limit** number
   columns. Enter values; **`0` means no limit**.
4. Save. Editors then can't add more than the upper limit of a type (its Add option disappears at
   the max), and too-few/too-many raise a validation error on save.

## Where it is stored

In the field config `field.field.<entity_type>.<bundle>.<field_name>`:

```yaml
settings:
  handler: 'paragraphs_limits'          # <- the selection plugin id
  handler_settings:
    target_bundles_drag_drop:
      hero:      { weight: 0, enabled: true, lower_limit: 1, upper_limit: 1 }
      text:      { weight: 1, enabled: true, lower_limit: 0, upper_limit: 0 }   # unlimited
      cta:       { weight: 2, enabled: true, lower_limit: 0, upper_limit: 2 }
```

`lower_limit` / `upper_limit` are integers; `0` disables that bound.

## Scriptable

```php
$fc = \Drupal\field\Entity\FieldConfig::loadByName('node', 'page', 'field_sections');
$fc->setSetting('handler', 'paragraphs_limits');
$settings = $fc->getSetting('handler_settings');
$settings['target_bundles_drag_drop']['cta']['upper_limit'] = 2;   // max 2 CTAs
$settings['target_bundles_drag_drop']['hero']['lower_limit'] = 1;  // require 1 hero
$fc->setSetting('handler_settings', $settings)->save();
```

Read it back:

```bash
drush cget field.field.node.page.field_sections settings.handler
drush cget field.field.node.page.field_sections settings.handler_settings.target_bundles_drag_drop
```

## Enforcement details

- **Constraint:** `hook_entity_bundle_field_info_alter()` adds the `ParagraphsLimits` constraint to
  any paragraph field whose `handler` is `paragraphs_limits`. Its validator raises
  `upperLimitMessage` ("A maximum of %limit …") or `lowerLimitMessage` ("A minimum of %limit …")
  when a type's count exceeds/falls short of its non-zero limit.
- **Add-more hiding:** a `hook_field_widget_complete_WIDGET_TYPE_form_alter()` (for the classic
  `entity_reference_paragraphs` and stable `paragraphs` widgets) removes a type from the Add-more
  select/buttons once its `upper_limit` is reached, and removes the whole add-more control if nothing
  can be added.

## Uninstall

On uninstall the module reverts each affected field's `handler` back to `default:paragraph` and
strips the `lower_limit`/`upper_limit` keys, so no dangling settings remain.

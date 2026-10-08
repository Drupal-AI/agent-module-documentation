<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set a field's display label

There is no admin settings page (`configure` = null). The label is set **per field, per bundle**
on the field's own settings form, and stored as a third-party setting on the `FieldConfig`.

## Where it is stored

Config entity `field.field.<entity_type>.<bundle>.<field_name>`, key:

```yaml
third_party_settings:
  field_display_label:
    display_label: 'Body Display'
```

## Via the UI

1. Go to the bundle's **Manage fields** (e.g. Article: `/admin/structure/types/manage/article/fields`).
2. **Edit** the field you want to relabel (this opens `field_config_edit_form`).
3. Fill in **Display label** ("A separate label for viewing this field. Leave blank to use the
   default field label."). It sits just under the normal **Label** field.
4. **Save**. Leaving it blank unsets the setting and restores the default label.

## Via drush php:eval (scriptable)

```php
use Drupal\field\Entity\FieldConfig;
$fc = FieldConfig::loadByName('node', 'article', 'body');
$fc->setThirdPartySetting('field_display_label', 'display_label', 'Article text')->save();

// Remove it (fall back to default label):
$fc->unsetThirdPartySetting('field_display_label', 'display_label')->save();
```

## Read it back

```bash
drush cget field.field.node.article.body third_party_settings.field_display_label
# -> display_label: 'Article text'
```

Or in PHP: `$fc->getThirdPartySetting('field_display_label', 'display_label')`.

## How it renders

`FieldDisplayLabelHooks::preprocessField()` implements `hook_preprocess_field()`. For each rendered
field it reads the field definition's `field_display_label.display_label` third-party setting and,
when non-empty, sets `$variables['label']` to it. So only the **displayed** label changes — the form
label, the field machine name, and stored values are untouched. Because the setting lives on the
per-bundle `FieldConfig`, the same field can display a different label on each content type.

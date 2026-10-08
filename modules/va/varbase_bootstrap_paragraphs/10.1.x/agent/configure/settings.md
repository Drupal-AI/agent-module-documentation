# Configure — Varbase Bootstrap Paragraphs settings

Route `varbase_bootstrap_paragraphs.settings` at
`/admin/config/varbase/varbase-bootstrap-paragraphs`, form
`Drupal\varbase_bootstrap_paragraphs\Form\VarbaseBootstrapParagraphsSettingsForm`
(form id `varbase_bootstrap_paragraphs_settings`), permission
`administer varbase bootstrap paragraphs settings`. Also linked as a Varbase settings task/menu
under `varbase_core.settings_index`.

The form has **one field**: a textarea `background_colors`, stored in config object
`varbase_bootstrap_paragraphs.settings`.

## The `background_colors` value

One `key|label` per line — `key` is a CSS class name (no leading dot), `label` is the admin-form
label. Default (from `config/optional/varbase_bootstrap_paragraphs.settings.yml`):

```
vbp_color_01|Blue
vbp_color_02|Madison
vbp_color_03|Dark Gray
vbp_color_04|Light Gray
vbp_color_05|Red
```

These class names must exist as CSS. They are defined in the `vbp-colors` library
(`css/theme/vbp-colors.theme.css`, source `scss/theme/vbp-colors.theme.scss`). To rebrand, copy
that library into your theme, override `vbp-colors`, and edit the classes there — then update this
list to match.

## What submit does (two writes)

`submitForm()` does **more than save config**:
1. Parses the textarea with `optionsExtractAllowedListTextValues()` (regex `(.*)\|(.*)` per non-empty
   line) into `key => label` pairs. Invalid lines (no `|`) make validation fail.
2. Loads field storage `paragraph.bp_background` (`FieldStorageConfig::loadByName('paragraph',
   'bp_background')`), sets its `allowed_values` to the parsed list, and `save()`s it —
   so the option list on every paragraph type's "Background color" field stays in sync.
3. Saves `background_colors` into `varbase_bootstrap_paragraphs.settings`.

`validateForm()` rejects a non-array parse and any key longer than 255 chars. A
`FieldStorageDefinitionUpdateForbiddenException` (e.g. data already stored for a removed value) is
caught and shown as a form error with a rebuild.

> Note: the admin paragraph **widget** options are actually rebuilt on the fly from
> `background_colors` by the module's form/widget alters (see [../hooks/hooks.md](../hooks/hooks.md)),
> reading config directly — the field-storage `allowed_values` write keeps the stored schema honest.

## Set it with Drush / PHP

```bash
ddev drush config:set varbase_bootstrap_paragraphs.settings background_colors \
  $'vbp_color_01|Blue\nbrand-dark|Dark\nbrand-accent|Accent'
```

Setting config directly does **not** re-run the field-storage sync — to also update
`paragraph.bp_background` allowed values, either save the settings form once, or do it in PHP:

```php
$colors = "vbp_color_01|Blue\nbrand-dark|Dark";
\Drupal::configFactory()->getEditable('varbase_bootstrap_paragraphs.settings')
  ->set('background_colors', $colors)->save();

$storage = \Drupal\field\Entity\FieldStorageConfig::loadByName('paragraph', 'bp_background');
$allowed = [];
foreach (explode("\n", $colors) as $line) {
  [$k, $v] = array_map('trim', explode('|', $line));
  $allowed[] = ['value' => $k, 'label' => $v];
}
$storage->setSetting('allowed_values', $allowed)->save();
```

## Config schema

The module ships **no** `config/schema/*.schema.yml`. `background_colors` is a plain string with no
declared schema.

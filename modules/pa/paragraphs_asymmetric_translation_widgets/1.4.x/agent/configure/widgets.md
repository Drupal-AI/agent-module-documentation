<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling asymmetric translation on a Paragraphs field

There is **no settings form** and no `configure` route. You activate the behavior by
choosing this module's widget on the host bundle's **entity form display**. Two
prerequisites: the host field is an `entity_reference_revisions` field targeting
`paragraph`, and it (plus the host bundle) is **translatable** (`content_translation`).

## Which widget to pick

| Goal | Widget id to set on the form display |
|---|---|
| Legacy / inline Paragraphs form, asymmetric | `paragraphs_classic_asymmetric` |
| Modern stable Paragraphs form, asymmetric | `paragraphs` (unchanged) — the module swaps its class automatically when the field is translatable |

The modern case needs **no widget change**: leaving the field on the stable `paragraphs`
widget is enough, because `hook_field_widget_info_alter` rewrites that plugin's class to
the asymmetric variant. Pick `paragraphs_classic_asymmetric` only when you want the legacy
inline UI.

## Set the legacy asymmetric widget with drush (config API)

```php
// drush php:eval  — point node.article's field_asym_para at the asymmetric legacy widget.
$fd = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_asym_para', [
  'type' => 'paragraphs_classic_asymmetric',
  'settings' => [
    'title' => 'Section',
    'title_plural' => 'Sections',
    'edit_mode' => 'open',        // open | closed | preview
    'add_mode' => 'dropdown',     // dropdown | button | select
    'form_display_mode' => 'default',
    'default_paragraph_type' => '',
  ],
])->save();
```

Read it back / confirm the widget in use:

```bash
drush php:eval '$c = \Drupal::service("entity_display.repository")
  ->getFormDisplay("node","article","default")->getComponent("field_asym_para");
  print $c["type"] . "\n";'   # => paragraphs_classic_asymmetric
```

## Making the field translatable

The asymmetric duplication only fires for translatable paragraph fields. Ensure the host
bundle is translatable and the reference field is set to translate, e.g.:

```bash
drush php:eval '$fc = \Drupal\field\Entity\FieldConfig::loadByName("node","article","field_asym_para");
  $fc->setTranslatable(TRUE)->save();'
```

**Warning (from the module README):** flipping an existing field from non-translatable to
translatable can soft-unlink already-attached paragraphs (they stay in the DB but stop
rendering). Do this before content exists, or plan a migration.

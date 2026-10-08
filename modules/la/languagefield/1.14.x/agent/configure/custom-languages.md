<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom languages

Register languages Drupal doesn't ship (constructed, minority, dialect) so they can appear
in a Language field whose `language_range` includes custom (`12`).

## Config entity

- type id: `custom_language`, config prefix `custom_language` → config name `languagefield.custom_language.<id>` (module name is prepended)
- admin permission: `administer languagefield` (route also accepts `administer languages`)
- collection: `/admin/config/regional/custom_language`
  - add: `/admin/config/regional/custom_language/add`
  - edit/delete: `/admin/config/regional/custom_language/manage/{id}[/delete]`

Exported fields (`config_export`): `id`, `label` (English name), `native_name`,
`direction` (`DIRECTION_LTR` / `DIRECTION_RTL`), `weight`.

## Create with drush

```php
\Drupal::entityTypeManager()->getStorage('custom_language')->create([
  'id' => 'tlh',
  'label' => 'Klingon',
  'native_name' => 'tlhIngan Hol',
  'direction' => 'ltr',
  'weight' => 0,
])->save();
```

Or import the YAML directly:

```yaml
# custom_language.tlh.yml
id: tlh
label: Klingon
native_name: tlhIngan Hol
direction: ltr
weight: 0
```

## Read it back

```bash
drush config:get languagefield.custom_language.tlh
# list all custom languages:
drush ev 'print_r(array_keys(\Drupal::entityTypeManager()->getStorage("custom_language")->loadMultiple()));'
```

Custom languages are merged into a field's choices by
`CustomLanguageManager` when the field's `language_range` contains `12`.

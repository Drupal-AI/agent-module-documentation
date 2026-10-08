<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush code generators

The project ships two Drupal Code Generator classes and their Twig templates:

| Class | Intended command | Alias | Writes |
|---|---|---|---|
| `Drupal\extra_field\Drush\Generators\ExtraFieldDisplay` | `plugin:extra-field-display` | `extra-field-display` | `src/Plugin/ExtraField/Display/{class}.php` from `extra-field-display.twig` |
| `Drupal\extra_field\Drush\Generators\ExtraFieldForm` | `plugin:extra-field-form` | `extra-field-form` | `src/Plugin/ExtraField/Form/{class}.php` from `extra-field-form.twig` |

Both templates support the standard DCG `services` question, emitting a
`ContainerFactoryPluginInterface` constructor/`create()` pair when services are chosen.
The display template scaffolds a `ExtraFieldDisplayBase` subclass with
`bundles = {"node.*"}` and a `view()` returning `['#markup' => 'Hello world!']`.

## Known issue — they do not register on Drush 13 / DCG 4

`drush.services.yml` tags four services under the namespace
`Drupal\extra_field\Generators\…` (`ExtraFieldDisplay`, `ExtraFieldDisplayV2`,
`ExtraFieldForm`, `ExtraFieldFormV2`), but the classes actually live in
`Drupal\extra_field\Drush\Generators\…` and no `*V2` classes exist in the release. On this
site (Drush 13.7.6, DCG 4.2.0) `drush generate` therefore lists **no** extra-field commands:

```bash
drush generate | grep extra-field   # → no output
```

Do not tell users to run `drush generate extra-field-display` without checking
`drush generate | grep extra-field` first. Practical alternatives:

* copy a plugin from the `extra_field_example` submodule and edit it, or
* copy the class skeleton from
  [../plugins/extra-field-plugins.md](../plugins/extra-field-plugins.md).

`composer.json` also declares `"conflict": {"drush/drush": "<12"}` and registers
`drush.services.yml` for Drush `>=10` via the `extra.drush.services` key.

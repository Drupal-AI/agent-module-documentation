<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Atoms — define & render

## Define atoms (code only)
Ship `mymodule.atoms.yml` or implement the alter hook:

```php
/** hook_atoms_alter(&$definitions) */
function mymodule_atoms_alter(&$definitions) {
  $definitions['site_phone'] = [
    'type' => 'text',            // an Atoms plugin id: text, text_format, number,
    'label' => 'Site phone',     // checkbox, date_time, link, entity, media(+submodule)
    'group' => 'contact',
  ];
}
```

After adding definitions, rebuild (happens automatically on `hook_modules_installed`, or `\Drupal::service('atoms.builder')->rebuild();`). Editors then set values at `/admin/content/atoms`.

## Render
Twig extension (`Twig\AtomsExtension`, service `atoms.twig.extension`):

```twig
{{ atom('site_phone') }}            {# render array, html-safe #}
{{ atomString('site_phone') }}      {# plain string #}
{{ atomLazy('site_phone') }}        {# lazy_builder placeholder #}
```

Optional 2nd arg is a `langcode`. In PHP, use the `atoms` service (`AtomsViewBuilder::get($machine_name, $langcode)->toRenderable()`).

## Extend
Add an atom value-type by creating a plugin under `src/Plugin/Atoms/` with the `Atoms` annotation (see the shipped Text/Number/Link/Entity plugins), managed by `plugin.atoms.manager`. The **Atoms Media Library** submodule is an example, adding a `Media` atom.

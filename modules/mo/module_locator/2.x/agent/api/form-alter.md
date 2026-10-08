<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Locator — form alter, theme override, preprocess

All logic lives in `module_locator.module` (no `src/`, no classes). It hangs a Location value
onto core's Extend page and re-themes the module details so the value shows.

## 1. Attach the path — `hook_form_FORM_ID_alter`
`module_locator_form_system_modules_alter(&$form, FormStateInterface $form_state, $form_id)`
iterates every package group in `$form['modules']`, then every module row within it (skipping
keys that start with `#`), and sets:

```php
$form['modules'][$key][$module]['location'] =
  ['#markup' => \Drupal::service('extension.list.module')->getPath($module)];
```

The value comes from core's `extension.list.module` service (`ExtensionList::getPath()`) — an
internal, trusted filesystem path relative to the Drupal root (e.g. `modules/contrib/foo`). It is
not user input.

## 2. Register the theme override — `hook_theme` + suggestion
`module_locator_theme()` defines a `system_modules_details_alter` theme hook with
`base hook => system_modules_details` and a `modules` variable.
`module_locator_theme_suggestions_system_modules_details_alter()` appends
`system_modules_details_alter` to the suggestions for core's `system_modules_details`, so the
module's own Twig template is used to render the list.

## 3. Preprocess — `hook_preprocess_HOOK`
`module_locator_preprocess_system_modules_details_alter(&$variables)` mirrors core's
`template_preprocess_system_modules_details()`: it walks `Element::children($form)`, builds each
`$module` render array (checkbox, machine name, requires/required_by item lists, version), and —
the module's addition — early-renders `$module['location']` with the renderer when present:

```php
if (!empty($module['location'])) {
  $module['location'] = $renderer->render($module['location']);
}
```

Each built `$module` is pushed onto `$variables['modules']`.

## 4. Template
`templates/system-modules-details-alter.html.twig` is a copy of core's
`system-modules-details.html.twig` with one extra block inside `.requirements`:

```twig
{% if module.location %}
  <div class="admin-requirements">{{ 'Location: @module-location'|t({'@module-location': module.location }) }}</div>
{% endif %}
```

## Operating notes
- No config, no settings route (`configure` is null), no permissions file — access is entirely
  core's `administer modules` gate on `/admin/modules`.
- Because it overrides the `system_modules_details` theme, another module that also overrides the
  same theme hook can conflict; last suggestion wins.
- Uninstalling the module removes the Location line and restores core's default template.

# Global settings

Form `\Drupal\styleswitcher\Form\StyleswitcherAdmin` (a `ConfigFormBase`), route
`styleswitcher.admin` → `/admin/config/user-interface/styleswitcher`. This is the module's
`configure` link. Requires the `administer styleswitcher` permission. The page also lists all
custom styles with Edit/Delete operations and an "Add style" action link.

Config object: **`styleswitcher.settings`**.

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `enable_overlay` | boolean | `true` | When on, the block's JS shows a fading overlay (`css/styleswitcher-overlay.css`) while swapping stylesheets. Passed to JS as `drupalSettings.styleSwitcher.enableOverlay`. |
| `7206_theme_default` | string | (unset) | Legacy/internal. Records the theme that was default before a D7→D8 update, used to resolve pre-existing non-array `styleswitcher` cookies in `DefaultController::activeStylePath()`. Not exposed in the form. |

## Set via Drush / PHP

```bash
drush config:set styleswitcher.settings enable_overlay 0
```

```php
\Drupal::configFactory()->getEditable('styleswitcher.settings')
  ->set('enable_overlay', FALSE)->save();
```

Changing `enable_overlay` invalidates the block (its cache tags include
`config:styleswitcher.settings`).

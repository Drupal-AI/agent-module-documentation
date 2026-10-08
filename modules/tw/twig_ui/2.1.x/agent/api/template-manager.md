<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: the `twig_ui.template_manager` service

Service id `twig_ui.template_manager` → `Drupal\twig_ui\TemplateManager`
(implements `TemplateManagerInterface`). This is the module's public API — use it to query
which override applies and to manage the on-disk `.html.twig` files. There is **no** Drush and
**no** `hook_*` API file; the entity's own `postSave`/`postDelete` already call the manager, so
you rarely need to write files yourself.

Constant: `TemplateManagerInterface::DIRECTORY_PATH = 'public://twig_ui'`.

## Query methods

| Method | Returns |
|---|---|
| `getTemplates()` | all `TwigTemplate` entities (`loadMultiple`). |
| `getTemplatesByTheme($theme)` | array of templates whose `themes` include `$theme`, else NULL. |
| `getTemplate($id)` | one template by machine name, or NULL. |
| `templateExists($suggestion, $theme)` | machine name of the **enabled** template overriding `$suggestion` for `$theme`, else FALSE. Used by form validation to enforce one-per-combo. |
| `getActiveThemes()` | `themeHandler->listInfo()` (Extension objects). |
| `getAllowedThemes()` | theme keys allowed by `twig_ui.settings` (all active, or the `allowed_theme_list`). |

```php
$mgr = \Drupal::service('twig_ui.template_manager');
$id  = $mgr->templateExists('node__article', 'olivero');   // FALSE or the template id
$all = $mgr->getTemplatesByTheme('olivero');
```

## File / path methods

| Method | Purpose |
|---|---|
| `syncTemplateFiles(TwigTemplate $t)` | diff `$t->original` vs `$t` and write/delete files accordingly (called from `postSave`). |
| `writeTemplateFile($t, $theme)` | write the code to that theme's file. |
| `deleteTemplateFiles($t)` / `deleteTemplateFile($t, $theme)` | remove file(s). |
| `getDirectoryPathByTheme($theme, $stream_wrapper = TRUE)` | `public://twig_ui/<theme>` (or a docroot-relative path when `$stream_wrapper` is FALSE — this is what `hook_theme()` feeds to `drupal_find_theme_templates`). |
| `getTemplatePath($t, $theme)` | full path incl. filename. |
| `getTemplateFileName($t, $extension = TRUE)` | filename: `theme_suggestion` with `_`→`-`, plus `.html.twig`. |
| `TemplateManager::prepareTemplatesDirectory()` (static) | create `public://twig_ui` and write its `.htaccess`; returns TRUE or an error string. |

## How the override reaches Drupal's theme system

`twig_ui_theme()` (in `.module`) implements `hook_theme()`. It reads a global
`$_twig_ui_registry_theme` (set by the registry decorator while building each theme's registry)
and returns `drupal_find_theme_templates($existing, '.html.twig', <twig_ui dir for that theme>)`
so the written files register as template overrides. The service
`twig_ui.immutable_registry` (`Theme\ImmutableRegistry`) plus `Theme\RegistryDecorator`
(installed via `TwigUiServiceProvider`) drive per-theme registry building. Because saving a
template rebuilds the kernel and invalidates the Twig cache, overrides take effect immediately.

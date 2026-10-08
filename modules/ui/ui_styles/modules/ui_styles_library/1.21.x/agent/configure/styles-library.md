<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The styles library page

## Route and access

- Path: **`/admin/appearance/ui/styles`** — route `ui_styles_library.overview`
  (controller `Drupal\ui_styles_library\Controller\StylesLibraryController::overview`).
- Permission: **`access_ui_styles_library`** (declared in
  `ui_styles_library.permissions.yml`, title "Access styles library"). Grant it to any role
  that should see the styleguide.
- Menu: appears under *Appearance → UI libraries* (`ui_suite.index`, `/admin/appearance/ui`)
  as the "Styles" link, plus a local task.

There is **no settings form** and no config entity — the module only exposes a page.

## What it renders

`overview()` calls `\Drupal::service('plugin.manager.ui_styles')->getGroupedDefinitions()`
and builds a render array with `#theme => 'ui_styles_overview_page'`
(template `ui-styles-overview-page.html.twig`). Each style option is previewed using its
`previewed_with` / `previewed_as` metadata; the generated stylesheet
(`/ui_styles/stylesheet`) supplies the CSS so previews look real.

## Grant access via drush

```php
$role = \Drupal\user\Entity\Role::load('content_editor');
$role->grantPermission('access_ui_styles_library')->save();
```

## Check who can access

```bash
drush ev '$r=\Drupal\user\Entity\Role::load("content_editor"); var_dump($r->hasPermission("access_ui_styles_library"));'
```

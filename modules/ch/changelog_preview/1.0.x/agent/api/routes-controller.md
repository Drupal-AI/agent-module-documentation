<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Changelog Preview — routes, controller, hooks

## Static routes (`changelog_preview.routing.yml`)
- `changelog_preview.changelog_manage_form` — `/admin/changelog_manage`, `_form` =
  `ChangelogManageForm`, permission `administer site configuration`.
- `changelog_preview.object` — `/changelog/base`, `_controller` =
  `ChangelogPreviewController::listChangelogs`, permission `view changelog`.
- `route_callbacks: - '\Drupal\changelog_preview\Routing\ChangelogPreviewRoutes::routes'` —
  adds the dynamic per-item routes at route-build time.

## Dynamic routes (`Routing\ChangelogPreviewRoutes::routes`)
Reads `changelog_preview.changelog_manage_form`. For each item `<i>` up to `changelog_items_count`,
if both `changelog_browser_path_<i>` and `changelog_name_<i>` are non-empty, registers:
- name `changelog.<i>`, path = the item's browser path,
- `_controller` = `ChangelogPreviewController::content`, `_title` = the item name,
- `_permission` = `view changelog`.
Empty path or name → the item is skipped. Requires a router rebuild (`drush cr`) after config change.

## Controller (`Controller\ChangelogPreviewController`)
- `content()` — serves a single changelog. Takes the current route name, splits on `.`
  (`explode('.', $route_name)`), and uses index `$matches[1]` (the `<i>` from `changelog.<i>`).
  Builds `$file_path = \Drupal::root() . $configuration->get('changelog_file_path_' . $matches[1])`,
  and if `@file_exists($file_path)` reads it with `file_get_contents` and runs it through
  `Michelf\Markdown::transform()`. Returns `['#type' => 'markup', '#markup' => $context]`
  (core filters `#markup` through `Xss::filterAdmin`). Falls back to "Nothing to show here."
- `listChangelogs()` — serves `/changelog/base`. Loops `changelog_items_count` and builds an
  HTML list of `<a href='<browser_path>'>name</a>` links from config, returned as `#markup`.
  Returns "No changelog items found." when the count is 0.

## Local tasks (`Plugin\Derivative\DynamicLocalTasks`)
Deriver referenced by `changelog_preview.links.task.yml`. Creates a base task `changelog_base`
(route `changelog_preview.object`) and, for each item whose `changelog.<i>` route exists, a task
`changelog_<i>` titled with the item name, all under base route `changelog_preview.object`.

## Hooks (`changelog_preview.module`)
- `hook_toolbar()` — adds a "Changelog" toolbar tab linking to `changelog_preview.object`.
- `hook_page_attachments()` — attaches the `changelog_preview/code-element.styling` library on the
  index route and any `changelog.` route, for users with `view changelog`.
- `changelog_preview_menu_link()` — declared but NOT a valid hook name (there is no
  `hook_menu_link`), so Drupal never calls it; it is dead code.

## Assets
`changelog_preview.libraries.yml` defines `code-element.styling`, loading
`css/code_element_styling.css` (styles rendered code blocks grey).

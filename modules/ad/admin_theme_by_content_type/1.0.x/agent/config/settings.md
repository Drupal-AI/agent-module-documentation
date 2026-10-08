<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, form alter and theme swapping

## Install & enable

```bash
composer require drupal/admin_theme_by_content_type
drush en admin_theme_by_content_type -y
```

Only dependency is core **`node`**. No sub-modules, no permissions of its own, no routes, no Drush commands.

## Where you configure it

`info.yml` sets `configure: system.themes_page`, so the "Configure" link goes to core's **Appearance** page
(`/admin/appearance`, route `system.themes_page`) — the module has **no settings form of its own**.

`AdminThemeByContentTypeHooks::formSystemThemesAdminFormAlter()`
(`#[Hook('form_system_themes_admin_form_alter')]`, mirrored by the `#[LegacyHook]` shim
`admin_theme_by_content_type_form_system_themes_admin_form_alter()` in the `.module`) adds one element to
that form:

- `$form['admin_theme']['admin_theme_by_content_type']` — a `checkboxes` element titled *"Use the
  administration theme when editing or creating these content types"*. Options are every node bundle from
  `entity_type.bundle.info`→`getBundleInfo('node')` (`machine_name => label`). Default value is the current
  `node_bundles` list. Its description warns **not** to also tick core's own site-wide *"Use the
  administration theme when editing or creating content"* box, and links to the permissions page for the
  core system *"View the administration theme"* permission.
- Appends `admin_theme_by_content_type_system_themes_admin_form_submit` to `$form['#submit']`. That handler
  (in the `.module`) writes `$form_state->getValue('admin_theme_by_content_type')` into
  `admin_theme_by_content_type.settings:node_bundles` and saves. (The checkboxes value is an assoc array of
  `bundle => bundle|0`; it is stored as-is.)

## Config object & schema

Config object **`admin_theme_by_content_type.settings`**:

| Key | Type | Meaning |
|---|---|---|
| `node_bundles` | sequence of string | Node bundle machine names for which the admin theme is forced on add/edit forms. |

Schema: `config/schema/admin_theme_by_content_type.schema.yml` (`node_bundles` = `sequence` of `string`).

Drush / config example:

```bash
drush cset admin_theme_by_content_type.settings node_bundles.0 article -y
drush cset admin_theme_by_content_type.settings node_bundles.1 page -y
drush cr
```

```yaml
# admin_theme_by_content_type.settings
node_bundles:
  article: article
  page: page
```

## How the theme is actually switched

Service `admin_theme_by_content_type.admin_theme_subscriber` →
`Drupal\admin_theme_by_content_type\EventSubscriber\AdminThemeSubscriber`, constructed with
`@theme.initialization`, `@router.no_access_checks`, `@config.factory`, `@theme.manager`.

`getSubscribedEvents()` binds `KernelEvents::REQUEST` → `onKernelRequest` at **priority 35**. Flow of
`onKernelRequest(RequestEvent $event)`:

1. `router->matchRequest($request)` (wrapped in try/catch — any exception returns silently). Empty
   `_route` returns.
2. Determine the bundle:
   - route `entity.node.edit_form` → `$route_object['node']->bundle()` (guarded by `instanceof NodeInterface`).
   - route `node.add` → `$route_object['node_type']->id()` (guarded by `instanceof NodeTypeInterface`).
   - any other route → no bundle, returns.
3. If the bundle is in `admin_theme_by_content_type.settings:node_bundles` (strict `in_array(..., TRUE)`),
   read `system.theme:admin` and call
   `themeManager->setActiveTheme(themeInitialization->initTheme($admin_theme_name))`.

Notes for operators:

- The subscriber only reads the route/bundle and swaps the **active theme**; it does **not** grant or
  bypass page access — core route access still applies. Whether the admin theme is actually shown to a user
  is still gated by the core system *"View the administration theme"* permission.
- It runs on `entity.node.edit_form` and `node.add` only — not on `node.add_page`, previews, or other
  entity types.
- If the site admin theme equals the default theme, the swap is a no-op.

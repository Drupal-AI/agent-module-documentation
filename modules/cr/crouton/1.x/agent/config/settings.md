<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crouton — settings, service, and breadcrumb logic

## Install / enable

`composer require drupal/crouton` then `drush en crouton -y`. No dependencies beyond Drupal core
(`^10.1 || ^11`, PHP `>=8.1`). Enabling registers the breadcrumb builder immediately, but with the
default config (`menu_name: null`) it does nothing until a menu is chosen.

## Configuration

- Route: **`crouton.settings`** → `/admin/config/crouton`, title "Crouton settings", permission
  **`administer crouton`** (`crouton.routing.yml`). Form `\Drupal\crouton\Form\SettingsForm`,
  form id `crouton_settings`.
- Config object: **`crouton.settings`** (single, editable via `ConfigFormBase`). Schema in
  `config/schema/crouton.schema.yml`, install defaults in `config/install/crouton.settings.yml`.

Settings (form element → config key → effect):

| Key | Type / default | Effect |
| --- | --- | --- |
| `menu_name` | string, nullable, `null` | Menu whose active trail drives breadcrumbs. `- None -` (empty) disables the builder. Options are all menu entities (`SettingsForm::getMenuOptions()` loads `menu` storage). |
| `prepend_front` | boolean, `false` | Unshift a `Link` to `<front>` labelled "Home" (`addFrontLink()`). Rename via interface translation. |
| `append_current` | boolean, `false` | Keep the active (current-page) link as the final crumb. When off, `isMenuLinkApplicable()` drops it. |
| `use_disabled` | boolean, `false` | Include disabled ancestral menu links; also lets the builder still `applies()` when the active link itself is disabled. |
| `hide_plain_text` | boolean, `false` | Drop menu items whose route is `<nolink>` (structural, non-linking items). |

`SettingsForm::submitForm()` saves `$form_state->cleanValues()->getValues()` into
`crouton.settings` (the form exposes only the five keys above, so only those are written). Example
export:

```yaml
# crouton.settings.yml
menu_name: main
prepend_front: true
append_current: false
use_disabled: false
hide_plain_text: true
```

## Runtime service

- Service **`crouton.breadcrumb`** = `Drupal\crouton\MenuBasedBreadcrumbBuilder`, tag
  `breadcrumb_builder` **priority 2000** (`crouton.services.yml`). Higher priority than core's
  path-based builder (`0`), so it wins when it applies. Args: `AdminContext`,
  `ConfigFactoryInterface`, `MenuActiveTrailInterface`, `MenuLinkManagerInterface`.

### `applies(RouteMatchInterface, ?CacheableMetadata)`

- Gets the active link via `menu.active_trail`→`getActiveLink($menu_name)` (NULL if no menu
  configured → returns FALSE).
- Returns FALSE on admin routes (`AdminContext::isAdminRoute()`).
- Otherwise returns `$active->isEnabled() || use_disabled`. So a page with no menu link, or a
  disabled active link with `use_disabled` off, falls through to the next builder unchanged.
- Adds the config as a cacheable dependency and cache context `route`.

### `build(RouteMatchInterface)`

- `getActiveTrailLinks()`: `getActiveTrailIds($menu_name)`, `array_filter` (drop empties/root),
  `array_reverse` (root-first), then `MenuLinkManager::createInstance` per id → menu link plugins.
- Each link is passed through `processMenuLink()` → `isMenuLinkApplicable()` (see the four
  booleans above). Surviving links become core `Link` objects via `Link::fromTextAndUrl($title,
  $url)`; the active one gets `attributes['aria-current'] = 'page'`.
- `addFrontLink()` optionally prepends the Home link. The `Breadcrumb` carries cache context
  `route`, the config dependency, and each menu link as a cacheable dependency (so edits to menu
  links or settings invalidate it).

## Hook

- `crouton_menu_delete(EntityInterface)` in `crouton.module`: if the deleted `menu` entity's id
  equals `crouton.settings:menu_name`, it clears that key and saves — preventing a dangling
  reference.

## Operating notes

- Breadcrumb **text = the menu link title**, not the page title — edit the menu to change crumbs.
- Only affects front-end (non-admin) routes and only pages present in the chosen menu.
- No block/field/formatter to place; the theme's breadcrumb region renders the result. Themes that
  emit `aria-current` in the breadcrumb template get the current-page marker automatically.
- All output is core-escaped `Link` markup; the module reads no request input and makes no external
  calls.

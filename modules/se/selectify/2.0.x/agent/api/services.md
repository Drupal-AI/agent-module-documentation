# Services, route, permission, runtime mechanism (API)

Selectify has no controllers and no public JSON routes — only the admin settings form. The runtime
work is done by `.module` hooks that call one helper service. This file documents the services and how
a plain `<select>` becomes a Selectify widget.

## Route & permission

- Route `selectify.settings_form` → `/admin/config/selectify/settings`, `_form:
  \Drupal\selectify\Form\SelectifySettingsForm`, `requirements._permission: 'administer selectify
  settings'`, `options._admin_route: true`. Menu link `selectify.settings_form` (parent
  `system.admin_config_system`). Permission defined in `selectify.permissions.yml`.

## `selectify.helper` — `Service\SelectifyHelper` (`SelectifyHelperInterface`)

Constructor args: `@config.factory`, `@router.admin_context`, `@theme.manager`, `@theme_handler`,
`@path.matcher`, `@path.current`, `@path_alias.manager`, `@current_route_match`. Holds the
config-access, theme-detection, page-disable and select-eligibility logic (per-request cached).

Key methods an integrator/agent uses:

| Method | Purpose |
|---|---|
| `getConfig()` | Cached `selectify.settings` (ImmutableConfig). |
| `isPageDisabled()` | TRUE if current path/alias matches `disabled_pages` patterns. |
| `isAdminRoute()` / `isDisabledOnAdminRoute()` | Admin-route checks (respects `disable_on_admin_routes`). |
| `getViewsConfig()` / `getFormApiConfig()` / `getRadioCheckboxConfig()` | Return the per-path settings, or `FALSE` when that path is off/disabled. |
| `getWidgetClasses()` | Map widget value ⇒ `selectify-apply-*` class. |
| `getWidgetLibraries()` | Map widget value ⇒ library list. |
| `isFormExcluded($form_id, $user_excluded=[])` | `fnmatch` against the internal blocklist + user patterns. |
| `getInternalBlockedFormPatterns()` | The hardcoded always-excluded form-id patterns. |
| `isSelectEligibleForStyling($element)` | Single source of truth: skips `#ajax`, `#key_column` (field-widget selects), third-party libs (Select2/Chosen/Selectize/Choices via `hasThirdPartySelectLibrary`), hidden/disabled/`#access=FALSE`, excluded contexts (toolbar/modal/off-canvas), and already-`selectify-apply-*` selects. |
| `applyWidgetStyling(&$element, $widget, $accent_library)` | Adds classes + `selectify-form-api`, wrapper single/multi class, attaches libraries. |
| `getCssSelectorRules()` / `elementMatchesCssSelector($el,$key,$selector)` | Read + match the Form API CSS-selector rules (supports `#id`, `.class`, `[attr]`, `[attr=]`, `^=`, `$=`, `*=`; matched against pre-render element attrs, with `id` derived from `#attributes[id]`/`#id`/`edit-<key>`). |
| `applyWidgetToForm(&$form, $widget)` | Views path: add classes to every select + attach libraries. |
| `getRootParentTheme()`/`isBaseTheme()`/`cleanThemeName()` | Theme-family detection for the `theme-*` classes and gin/claro/olivero libraries. |

## `selectify.style_service` — `Service\SelectifyStyleService` (`SelectifyStyleServiceInterface`)

Arg `@config.factory`. Turns the radio/checkbox config into presentation:

- `getBodyClasses()` → e.g. `selectify-radio-toggle-circle-medium selectify-checkbox-toggle-circle-medium`.
- `getConfiguredInlineCss()` → a minified `input.selectify-radio[type="radio"]{…}` /
  `input.selectify-checkbox[type="checkbox"]{…}` block of `--selectify-*` variables, built from fixed
  size/shape/animation lookup tables (`getRadioVariables`/`getCheckboxVariables`). No user input flows
  in — inputs are the schema-constrained `*_style`/`*_shape`/`*_size` values.
- `getBodyDataAttributes()` → equivalent `data-selectify-*` attributes (alternative to classes).

## `selectify.twig_extension` — `TwigExtension\SelectifyTwigExtension`

Registers one Twig filter, **`selectify_clean_id`** (`cleanId()`): `preg_replace('/[^a-zA-Z0-9_-]/','-')`,
used in templates to build valid ARIA ids from option values.

## How a select becomes a Selectify widget (per path)

1. **Field widget** — the plugin's `formElement()` adds the class/attrs/libraries directly (see
   [../fields/widgets.md](../fields/widgets.md)).
2. **Views** — `hook_preprocess_views_exposed_form` tags every exposed `select` with `selectify-views`,
   resolves the widget (site-wide `global_selectify_widget` or `widget_for_filters` by normalised form
   id), fires `hook_selectify_widget_alter`, then `applyWidgetToForm()`.
3. **Form API** — `hook_form_alter` bails on disabled feature/page, Views forms, excluded forms, and
   `webform_submission_*` (when the submodule is on). It records the discovered form, applies
   `css_selector_widget_map` rules first (per-element, `hook_selectify_element_alter` each), then the
   `form_api_widget_map` widget to remaining eligible selects (`_selectify_apply_to_form_selects`,
   depth-capped recursion). Accent library computed once per request.
4. **Webform** (submodule) — `selectify_webform_webform_element_alter` styles direct selects and walks
   composite element trees (`_selectify_webform_walk_composites`), skipping date-part selects
   (`_selectify_webform_is_date_select`); `selectify_webform_form_alter` is a safety net on
   `webform_submission_*`.

In all four, `SelectifyHelper::isSelectEligibleForStyling()` (or the submodule's equivalent guards) is
the gate, and the visible native `<select>` remains for submission.

## Not present

No drush commands, no queue/cron, no controllers, no events subscribers, no external HTTP calls, no
entity/storage writes beyond `state('selectify.form_api_discovered_forms')` (discovered-form list) and
config saves from the settings form.

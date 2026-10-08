# Runtime behavior — form highlighting, admin warnings, report diff

All runtime behavior lives in `known_overrides.module` plus the report controller; there are no
services. Everything keys off `Settings::get('knownOverrides', [])`; when it is empty every hook
returns early.

## `hook_form_alter` — warn + highlight on config forms

`known_overrides_form_alter()` (`known_overrides.module:29`) runs on every form and collects the
config names the current form edits:

- **`ConfigFormBase` forms:** invokes the protected `getEditableConfigNames()` (via `ReflectionMethod`)
  and matches each returned name against the array — either as a value (`in_array(..., TRUE)`) or as a
  key (`isset()`).
- **Config-entity forms (`EntityForm`):** matches `$entity->getConfigDependencyName()` (e.g.
  `commerce_payment.commerce_payment_gateway.opayo`).

On a match it adds a `formatPlural` warning naming the overridden config and linking to the report, and
registers the `#after_build` callback `known_overrides_form_after_build()`.

## `#after_build` — disable + annotate overridden fields

`known_overrides_form_after_build()` (`:102`) processes each matched config that actually
`hasOverrides()`:

- **Standard `ConfigFormBase`:** uses `$form_state->get('config_key_to_form_element_map')` to map
  overridden property paths to elements, highlighting only elements whose specific property
  `hasOverrides()`.
- **Fallback / entity forms:** flattens the config to dot-paths with
  `_known_overrides_get_all_overrides()` and recursively locates matching elements with
  `_known_overrides_find_element_recursive()`.

Each matched element gets a yellow border, a `#suffix` showing the live **overridden value** (scalars
as-is, otherwise `json_encode`d), and `#disabled = TRUE`. The callback also `unset()`s core's
`config_override_status_messages` element to avoid a duplicate core override notice.

## `hook_page_top` — path-scoped admin warnings

`known_overrides_page_top()` (`:220`) runs only on admin routes (`router.admin_context`). For any
`knownOverrides` entry whose value has a `path` matching the current path
(`path.current`), it adds a warning naming the config and linking to the report — covering admin pages
that are not the config's own form. (`known_overrides_form_alter()` contains the same path check for
forms, so config forms can surface both the field highlight and the path warning.)

## Report controller — the diff

`KnownOverridesController::__invoke()` (`src/Controller/KnownOverridesController.php`) first normalizes
the array to unique config names (handling all three entry shapes). For each name it builds
`configManager->getConfigFactory()->getEditable($name)->get()` (stored) versus
`configFactory->get($name)->get()` (live/overridden), runs `compareArraysRecursive()`, and returns
`only_in_editable` / `only_in_memory` (each `json_encode`d with `JSON_PRETTY_PRINT`) into
`#report[$configName]`. Both `$settings['knownOverrides']` and the compared values originate from the
site's own config/settings, not from request input.

## Theme

`known_overrides_theme()` defines `known_overrides_report` (variables `report`, `overrides`), rendered
by `templates/known-overrides-report.html.twig` and preprocessed by
`template_preprocess_known_overrides_report()` (defaults `overrides` to `0`). The template prints the
override count, then per config name a two-column Editable / Overridden table.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS Variables Customizer (css_variables_customizer) — agent index

Lets an administrator override a theme's **CSS custom properties** (`--color-primary`, `--card-radius`,
…) from the admin UI, with no code deployment. A theme opts in by listing its source stylesheets under
a `css_variables_customizer:` key in its `.info.yml` and wrapping the overridable variables in
`/* @css-variables-customizer-category … */` comment annotations; the module parses those files, builds
a per-theme configuration form (grouped by category, plus every SDC component that carries annotated
variables), and stores the chosen values in a `css_variables_customizer.customizations.<theme>` **config
object**. On every request the `page_top` hook renders the saved overrides as `<style>` blocks injected
at the top of the page (via core's `html_tag` render element), scoping each override to a CSS selector
(default `:root`, or `:root [data-component-id="<id>"]` for components). A private-tempstore–backed
preview lets an editor see unsaved changes before saving, and (optionally) the `sdc_styleguide` module
renders live component previews in an iframe.

- Depends on: nothing (`dependencies` is empty; `composer require` has no packages). Soft/optional:
  `drupal/sdc_styleguide` (suggested — enables the in-form component preview).
- Core: `^10 || ^11`. Package: `User Interface`. Version documented: **1.0.0-beta3** (beta).
- Settings/entry route: **`css_variables_customizer.overview`** (`configure` link) at
  `/admin/appearance/css-variables-customizer`, gated by the core permission **`administer themes`**.
  Per-theme edit forms are added dynamically by a route subscriber, also gated by `administer themes`.
- No module permissions of its own, no Drush, **no plugin types**. Provides config schema. Uses the new
  OOP hook system (`#[Hook('help')]`, `#[Hook('page_top')]`) plus `#[LegacyHook]` shims in the `.module`.
- Overrides live in **configuration** (`css_variables_customizer.customizations.<theme>`): they export
  with the config system and are overwritten by a config import.

## What you'd do → where

- **Make a theme customizable (the `.info.yml` contract + annotation comments), edit/save overrides, add
  free-form "custom" variables, or preview changes** → [configure/themes.md](configure/themes.md)
- **Understand the services, the manager API, how overrides get injected into the page, the dynamic
  routes, caching, and the SDC/preview plumbing** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Static route: `css_variables_customizer.overview` (`/admin/appearance/css-variables-customizer`),
  controller `OverviewController::overview`, `_permission: administer themes`.
- Dynamic routes: `css_variables_customizer.theme.<theme>`
  (`/admin/appearance/css-variables-customizer/<theme>`), form `CustomizerForm`, `_permission:
  administer themes` — added by `RouteSubscriber` (event subscriber) for each enabled theme whose
  `.info.yml` has a `css_variables_customizer` key.
- Services: `css_variables_customizer.manager` (`CssVariablesManager`, alias of interface
  `CssVariablesManagerInterface`), `css_variables_customizer.theme_finder` (`ThemeFinder`),
  `css_variables_customizer.route_subscriber` (`RouteSubscriber`),
  `css_variables_customizer.preview_cleanup_subscriber` (`CssVariablesPreviewCleanupSubscriber`),
  `cache_context.css_variables_preview` (`CssVariablesPreviewCacheContext`), and the hook object
  `Drupal\css_variables_customizer\Hook\AttachmentHooks`.
- Form: `CustomizerForm` (`getFormId()` = `css_variables_customizer.customizer`), extends
  `ConfigFormBase`; editable config name is computed dynamically per theme.
- Config objects: `css_variables_customizer.customizations.<theme>` with keys `customizations`
  (sequence of `{id, overrides}`) and `custom` (map of `--var` → value). Schema key
  `css_variables_customizer.*`.
- Hooks: `hook_help` and `hook_page_top` (OOP `#[Hook(...)]` in `src/Hook/`, legacy shims in
  `css_variables_customizer.module`). `page_top` is where the `<style>` injection happens.
- Cache: each injected `<style>` carries tag `config:css_variables_customizer.customizations.<theme>`
  and context `css_variables_preview:<theme>` (custom cache context).
- Library: `css_variables_customizer/css-variables-customizer-form` (form CSS + JS; deps `core/drupal`,
  `core/once`).
- Menu/task links: `css_variables_customizer.overview` + per-theme derivatives via `MenuLinkDeriver`
  and `TaskLinkDeriver`.
- Theme opt-in `.info.yml` key: `css_variables_customizer: { stylesheets: [<file-or-folder>, …] }`.
  Annotation markers: `/* @css-variables-customizer-category <name> */` … variables …
  `/* @css-variables-customizer-category-end */`. Variable regex requires `--name: value;`.

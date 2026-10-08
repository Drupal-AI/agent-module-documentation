<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views EVI (views_evi) — agent index

Version **8.x-1.3** (2024-11-23) · `core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11` · depends on `views` · package "Views" · license GPL-2.0-or-later.

## What it is

A Views **display extender** (`@ViewsDisplayExtender id = "views_evi"`) that gives each **exposed** filter of a display a pluggable *value provider* and a pluggable *visibility* rule. It lets an exposed filter take its value from a contextual argument, the URL query, a token string, or an eval'd PHP snippet, and optionally hides the exposed widget — while the filter remains a genuine exposed filter the visitor can still change. Its own tagline: "a first step to abstract value providers from filters."

The two Views filter kinds it bridges: *contextual filters* take a value from the URL/context but the visitor cannot change it; *exposed filters* the visitor controls but have only static defaults. EVI gives an exposed filter a context-supplied value that stays overridable.

## How it works (mechanism)

- `hook_install` (`views_evi.install`) appends `views_evi` to `views.settings` → `display_extenders`, activating the extender on every display. `hook_uninstall` removes it.
- Per display, two extra option sections appear in the Views UI advanced area: **"Views EVI plugins"** (pick a Value + Visibility plugin per exposed filter) and **"Views EVI settings"** (per-plugin settings). Stored in the view under the display options `views_evi_plugins` and `views_evi_settings`; both are defaultable sections.
- **Value injection** — `views_evi_views_pre_view()` (`hook_views_pre_view`) → `ViewsEviDisplayExtender::viewsEviPreView()`: for each exposed filter, the Value plugin returns an `[identifier => value]` override which is `NestedArray::mergeDeep()`'d into `$view->exposed_input`, then also folded into `$view->exposed_data` and `$view->exposed_raw_input`. This runs *before* the exposed form reads input, so the filter behaves as if the visitor submitted that value.
- **Visibility** — `views_evi_form_views_exposed_form_alter()` (`hook_form_FORM_ID_alter` for `views_exposed_form`) → `viewsEviExposedFormAlter()`: for each exposed filter whose Visibility plugin returns false, it unsets `$form['#info']["filter-$id"]` (kills the label) and replaces the widget with a `#type => value` element carrying the injected value (so the value is still submitted). If *every* exposed filter is hidden, the whole exposed form gets `#access = FALSE`.
- Each exposed filter is wrapped by `ViewsEviFilterWrapper`, which resolves identifiers (grouped vs. `expose`), loads the two plugins, and reads/writes their settings on the display.

## Plugins provided

Value plugins (`plugin.manager.views_evi.value`, `Plugin/views_evi/Value`, annotation `@ViewsEviValue`): `exposed_form` (default — no override), `token`, `php`.
Visibility plugins (`plugin.manager.views_evi.visibility`, `Plugin/views_evi/Visibility`, annotation `@ViewsEviVisibility`): `yes` (default), `no`, `fallback`, `php`.
Details, tokens, and the `hook_views_evi_tokens_alter()` extension point: **agent/plugins/value.md**, **agent/plugins/visibility.md**, **agent/plugins/tokens.md**.

## Permissions

- `use php for views_evi` (restricted) — gates only whether the `php` plugins' textarea is editable in the UI. Saved PHP is still `eval()`'d at view build for anyone who triggers the view. See **agent/permissions/permissions.md**.

## Facts an agent will want

- No config-schema file, no Drush command, no submodules, no libraries. The only configure route in `.info.yml` is `views_ui.settings_advanced`, but real setup is per-display in the Views UI advanced settings (needs `views_ui`).
- Injection is value-level only; it does not add query conditions itself — it feeds the existing filter's exposed input.
- Minimally maintained / maintenance-fixes-only; deliberately narrow scope. For one view, a small custom `hook_views_pre_view()` setting `$view->exposed_input` may be lighter than adding EVI.

## Doc map

- `agent/plugins/value.md` — Value plugins (`exposed_form`, `token`, `php`).
- `agent/plugins/visibility.md` — Visibility plugins (`yes`, `no`, `fallback`, `php`).
- `agent/plugins/tokens.md` — token set, `[form:*]`, argument tokens, `hook_views_evi_tokens_alter()`.
- `agent/plugins/custom.md` — writing your own Value/Visibility plugin.
- `agent/permissions/permissions.md` — the `use php for views_evi` permission.
- `usage.md` — short/dense/use-case summary.

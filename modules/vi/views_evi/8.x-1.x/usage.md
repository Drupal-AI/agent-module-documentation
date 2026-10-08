<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views EVI (Exposed Filter Value Injector) is a Views display extender that lets each exposed filter of a display take its value from an argument, the URL query, a token or a snippet of PHP — and optionally hides the exposed widget — so an exposed filter can be driven by context while still being a real exposed filter the visitor can override.

---

Enabling the module registers a `views_evi` display extender in `views.settings` (done automatically by `hook_install`), which adds two extra option sections — "Views EVI plugins" and "Views EVI settings" — to every Views display, reached through the Views UI advanced settings (the `configure` route is `views_ui.settings_advanced`, but the actual per-view configuration lives in each display's advanced area, which requires the core Views UI). For each exposed filter of a display you pick a **Value** plugin and a **Visibility** plugin. Value plugins produce an input override for that filter's `$_GET` identifier: `exposed_form` (default, does nothing — normal exposed behaviour), `token` (a text field run through `strtr()` against a token set), and `php` (an eval'd snippet). Visibility plugins decide whether the widget stays on the form: `yes` (default, always shown), `no` (always hidden), `fallback` (shown only while the resolved token value is empty — i.e. hidden once context supplies a value), and `php` (an eval'd boolean). The token set available to `token`/`php`/`fallback` includes contextual-argument substitutions and positional argument tokens (`!1`, `%1`, …, sourced from `$view->args`), plus `[form:IDENTIFIER]` for each exposed filter's raw `$_GET` value; other modules can extend it via `hook_views_evi_tokens_alter()`. Injection happens in two places: `hook_views_pre_view()` merges each filter's value override into `$view->exposed_input`/`exposed_data`/`exposed_raw_input` (via `NestedArray::mergeDeep`) before the exposed form reads input, and `hook_form_views_exposed_form_alter()` removes hidden widgets (killing the `#info` label and replacing the element with a `#type => value` carrying the injected value); if every exposed filter is hidden the whole exposed form is set `#access = FALSE`. Configuration is stored inside the view itself under the display's `views_evi_plugins` and `views_evi_settings` options, and both are defaultable sections so a "Default" display can share them. The `php` Value and Visibility plugins gate only their **textarea** behind the `use php for views_evi` permission (a restricted permission); saved PHP is always `eval()`'d at view build time regardless of who triggers the view. There is no Drush command, no config-schema file, and no submodule; the two contributed extension points are the `ViewsEviValue` and `ViewsEviVisibility` annotated plugin types. Note the module is minimally maintained and its scope is deliberately narrow ("a first step to abstract value providers from filters"); for a single view, setting an exposed default from a custom `hook_views_pre_view()` may be lighter than adding this configuration surface.

---

- Pre-fill an exposed filter from a URL/query value using the `[form:IDENTIFIER]` token.
- Seed an exposed filter from a contextual filter (argument) via the `!1`/`%1` positional tokens.
- Let a visitor still override a context-supplied default, unlike a plain contextual filter.
- Hide an exposed widget entirely (`no` visibility) while still forcing its value.
- Show an exposed widget only when no context value is present (`fallback` visibility).
- Reuse a single view across contexts instead of cloning a display per context.
- Drive two filters from one exposed widget by pointing both at the same token.
- Default a listing to the current user with a `php` Value plugin returning `$user->id()`.
- Default a department/role filter per user through a PHP snippet.
- Filter an embedded view by the current node's or term's id supplied as an argument.
- Pre-select a category or taxonomy term on a listing page.
- Default a date filter to "today" via a PHP Value plugin.
- Compose an override for a filter whose identifier differs from the argument name.
- Auto-hide the exposed form completely when every filter is context-driven.
- Keep exposed sorts/pagers working while values arrive from context.
- Provide new tokens to EVI from a custom module with `hook_views_evi_tokens_alter()`.
- Write a custom `ViewsEviValue` plugin to source values from any service.
- Write a custom `ViewsEviVisibility` plugin for bespoke show/hide logic.
- Share EVI settings across displays using the defaultable "Default" display.
- Restrict who may enter PHP snippets with the `use php for views_evi` permission.
- Bridge the gap between contextual filters (fixed) and exposed filters (visitor-controlled).
- Personalise a listing without building a custom exposed-form alter by hand.

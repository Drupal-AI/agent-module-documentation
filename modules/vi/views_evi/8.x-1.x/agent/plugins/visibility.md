<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Visibility plugins — showing or hiding the exposed widget

Plugin type: annotation `@ViewsEviVisibility`, manager `plugin.manager.views_evi.visibility` (`VisiblityPluginManager` — note the class name typo), namespace `Plugin/views_evi/Visibility`, interface `ViewsEviVisibilityInterface` (adds `getVisibility(&$form)` returning `bool|null`). Base: `ViewsEviVisibilityBase`; token-aware base `ViewsEviVisibilityTokenBase`.

`getVisibility()` is called from `viewsEviExposedFormAlter()`. When it returns a falsy (non-null) value the widget is removed from the exposed form: `$form['#info']["filter-$id"]` is unset (drops the label) and the element is replaced with a `#type => value` element carrying the injected value, so the value is still submitted. If **all** exposed filters resolve to hidden, the whole exposed form gets `#access = FALSE`.

| id | class | title | Behaviour |
|---|---|---|---|
| `yes` | `ViewsEviVisibilityYes` | Visible | **Default.** Always `TRUE` — widget shown. |
| `no` | `ViewsEviVisibilityNo` | Invisible | Always `FALSE` — widget always hidden (value forced). |
| `fallback` | `ViewsEviVisibilityFallback` | Visible if no value | Text field (setting `value`, default `[form:IDENTIFIER]`). Returns `strtr(value, tokens) == ''` — visible only while the resolved value is empty, i.e. hidden once context supplies a value. |
| `php` | `ViewsEviVisibilityPhp` | Visibility from PHP | Textarea (setting `php`, default `return empty($tokens[$identifier]);`). Returns `eval($php)` as a boolean. |

## `php` plugin variables

Same scope as the Value PHP plugin: `$identifier`, `$id`, `$tokens`, `$display_handler`, `$filter_handler`, `$evi`, `$view`, plus `&$form` (the plugin note invites altering `$form[$identifier]` and `$form['#info']["filter-$id"]` directly). Must `return` a boolean. Textarea is `#disabled` without `use php for views_evi`; the stored snippet still executes for every visitor.

## Interaction with the Value plugin

Visibility and Value are independent per filter. A hidden widget (`no`, or `fallback` when a value is present) still needs a value to submit — that value comes from the Value plugin's `getValue()`, which `viewsEviExposedFormAlter()` re-reads to populate the `#type => value` element. Typical pairings: `token` value + `no` visibility (force a hidden context value), or `token` value + `fallback` visibility (context value hides the widget, absence shows it).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Value plugins — supplying an exposed filter's value

Plugin type: annotation `@ViewsEviValue`, manager `plugin.manager.views_evi.value` (`ValuePluginManager`), namespace `Plugin/views_evi/Value`, interface `ViewsEviValueInterface` (adds `getValue()` returning an `[identifier => value]` array or `[]`). Base: `ViewsEviValueBase`; token-aware base `ViewsEviValueTokenBase` (extends `ViewsEviHandlerTokenBase`).

The chosen Value plugin's `getValue()` output is merged into `$view->exposed_input` in `viewsEviPreView()`. Returning `[]` means "no override" — the filter behaves normally.

| id | class | title | Behaviour |
|---|---|---|---|
| `exposed_form` | `ViewsEviValueForm` | Exposed form | **Default.** `getValue()` returns `[]` — no injection; normal exposed-form value. |
| `token` | `ViewsEviValueToken` | Value with token | Text field (setting `value`, default `[form:IDENTIFIER]`). `getValue()` runs `strtr($value, $tokenReplacements)`; returns `[identifier => result]` unless the result is the empty string. Known not to work for nested values (date/price field filters). |
| `php` | `ViewsEviValuePhp` | Value from PHP code | Textarea (setting `php`, default `return array($identifier => $tokens[$identifier]);`). `getValue()` does `eval($php)`; result must be an array of input overrides, else `[]`. |

## `php` plugin variables

Inside the eval'd snippet these are in scope: `$identifier`, `$id`, `$tokens` (the token-replacement array, values only), `$display_handler`, `$filter_handler`, `$evi` (the `ViewsEviDisplayExtender`), `$view`. The snippet must `return` an array like `[$identifier => $value]` (no `<?php` tags). The textarea is `#disabled` unless the current user has `use php for views_evi`, but the **stored** snippet is executed at view build for every visitor regardless.

## Settings storage

`ViewsEviFilterWrapper` reads/writes settings on the display: plugin *class* choice under option `views_evi_plugins` → `filters[<filter_id>][value]`; plugin *settings* under `views_evi_settings` → `filters[<filter_id>][value]`. `getPluginSettings('value')` falls back to the plugin's `defaultSettings()`.

## Notes

- The filter identifier is the grouped-filter `group_info[identifier]` when the filter is grouped, otherwise `expose[identifier]` (the `$_GET` key).
- `token` uses a plain `strtr()` — no type coercion; whatever string results is fed as the exposed input for that filter, then interpreted by the normal Views filter handler.

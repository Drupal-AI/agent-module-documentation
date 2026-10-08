<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tokens available to token/PHP/fallback plugins

Token-aware plugins extend `ViewsEviHandlerTokenBase` (interface `ViewsEviHandlerTokenInterface`). Its `getTokenReplacements($ui = FALSE)` builds the replacement map; with `$ui = TRUE` it returns human descriptions for the settings form, with `$ui = FALSE` (runtime) it returns real values. Results are cached per display via `ViewsEviDisplayExtender::getViewsEviCache()`/`setViewsEviCache()`.

## What the map contains

1. **Contextual-argument substitutions** — `$view->build_info['substitutions']` if present (the tokens Views itself computed while building arguments).
2. **Positional argument tokens** — for each argument handler, `!N` = `strip_tags(Html::decodeEntities($view->args[N-1]))` (the raw value of argument N, HTML-stripped), and `%N` = the argument's title (only populated when a matching `%N` already exists). `N` starts at 1. (Note: because the loop keys by `%$count`, the `%N` title token is effectively only set when Views already provided it.)
3. **Per-exposed-filter form tokens** — `[form:IDENTIFIER]` = `$_GET[IDENTIFIER]` (the raw query value of that exposed filter) for every exposed filter of the display.

## `hook_views_evi_tokens_alter()`

After building the map, `getTokenReplacements()` invokes:

```php
\Drupal::moduleHandler()->alter('views_evi_tokens', $replacements, $context);
// $context = ['view' => $view, 'ui' => $ui];
```

So any module can add or change tokens by implementing `hook_views_evi_tokens_alter(array &$replacements, array $context)`. Use `$context['ui']` to return a description (true) vs. a value (false).

## Usage in plugins

- `token`/`fallback`: the setting string is passed through `strtr($string, $replacements)` — a straight substring replace, longest-key behaviour is *not* guaranteed (keys are inserted `!1`,`!2`,…; watch multi-digit args like `!10` vs `!1`).
- `php`: the same map is exposed as `$tokens` inside the eval'd snippet (e.g. `$tokens[$identifier]`, `$tokens['!1']`).

## Security note (values are raw)

`[form:IDENTIFIER]` and `!N` come straight from `$_GET` / `$view->args` (only `strip_tags` + entity-decode is applied to `!N`; `[form:*]` is completely raw). They are injected as the exposed filter's *input value*, which the Views filter handler then binds as a query parameter — so ordinary Views filtering, not string concatenation, applies. Do not echo these token values into markup in a custom plugin without sanitizing.

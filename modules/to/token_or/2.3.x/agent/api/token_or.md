# OR/fallback token syntax + how it works

## The syntax

Inside a single bracketed token, separate candidates with the pipe `|`:

```
[node:field_og_image:entity:url|node:field_header_image:entity:url|"https://example.com/default.png"]
```

- Candidates are evaluated **left to right**; the **first non-empty** result is used.
- A candidate is a normal token (`node:field_x`) written **without** its own brackets.
- A candidate wrapped in **double quotes** (`"…"`) is a **literal string** fallback, used
  verbatim (quotes stripped) when reached.
- Chains can be any length: `[a|b|c|"default"]`.
- Only groups that contain a `|` are touched; plain `[node:title]` tokens pass through
  unchanged, and non-piped and piped tokens can be mixed in the same text.
- If **no** candidate resolves and the caller passed `['clear' => TRUE]`, the whole `[a|b]`
  group is removed; without `clear`, the original `[a|b]` text is left in place.

This works in **any** text run through token replacement (Metatag, Pathauto, Webform email,
custom `\Drupal::token()->replace()` calls, etc.).

## How it hooks token replacement

`token_or` does not register tokens. It intercepts replacement:

1. `TokenOrServiceProvider::alter()` (a `ServiceProviderBase`) rewrites the core **`token`**
   service to use `Drupal\token_or\Token` (a subclass of the Token module's `Token`).
2. That subclass overrides `replace()` and `replacePlain()` to fire
   `$moduleHandler->alter('tokens_pre', $text, $data, $options)` **before** delegating to the
   parent replacement. It also overrides `scan()` so validation recognises piped tokens
   (the name-matching regex additionally excludes `|`, and piped candidates are expanded and
   merged into the normal scan result).
3. `token_or_tokens_pre_alter()` (in `token_or.module`) delegates to the
   **`token_or.tokens_pre_alter`** service (`TokenOrTokensPreAlter`, constructed with `@token`).

Because the service is swapped at container level, there is nothing to enable-configure —
installing the module is enough.

## The pre-alter service — `token_or.tokens_pre_alter`

`Drupal\token_or\TokenOrTokensPreAlter::tokensPreAlter(&$text, $data, $options)`:

- Finds every `[...]` group in `$text`.
- For any group containing `|`, splits on `|` and walks the candidates:
  - `"literal"` → the literal string (quotes stripped).
  - otherwise → `$this->token->replace("[$candidate]", $data, $options)`.
  - The first candidate whose result is non-empty **and** actually changed replaces the group.
- If `$options['clear']` is set and nothing matched, the group is replaced with `''`.

You normally never call this directly — it runs automatically via the `tokens_pre` alter.

## Programmatic use

No special API is needed. Just call token replacement as usual; the syntax is honoured:

```php
$text = '[node:field_summary|node:body:value|"No description."]';
$out  = \Drupal::token()->replace($text, ['node' => $node], ['clear' => TRUE]);
```

## What it does NOT provide

- No admin UI, settings form, config object, or config schema.
- No permissions, no Drush commands.
- **No plugin type** and no "modifier"/filter plugins — the only extension point is the
  standard Token API (see [../hooks/token_or.md](../hooks/token_or.md)).

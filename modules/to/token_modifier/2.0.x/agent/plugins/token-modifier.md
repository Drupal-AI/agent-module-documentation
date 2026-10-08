<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Modifiers: syntax, shipped list, and writing your own

## Syntax

A modifier is expressed as a token of type `token-modifier`:

```
[token-modifier:{modifier-id}:{original-token}]
```

The text between `token-modifier:` and the end is: the modifier id, then the ordinary token you
want transformed. The wrapped token works anywhere the original token works and receives the same
context (`$data` / `$options`).

```
[token-modifier:uppercase:node:title]        # node title, uppercased
[token-modifier:urlencode:current-user:name] # username, URL-encoded
[token-modifier:strip-tags:node:body]        # body with HTML tags removed
```

### `length` takes an argument

`length` consumes one extra `:`-separated part (an integer) **before** the token:

```
[token-modifier:length:{n}:{original-token}]
[token-modifier:length:8:current-user:name]   # first 8 characters
```

### Chaining

Prepend another `token-modifier:{modifier-id}:` to the front to apply a second transformation to
the result of the first (each modifier re-runs token replacement, so a `token-modifier:` token can
wrap another one):

```
[token-modifier:uppercase:token-modifier:trim:node:title]
# → trim(node title) → then uppercase
```

The left-most modifier runs last (outermost wrapper).

## Shipped modifiers

All live in `src/Plugin/token_modifier/`. Each `transform()` first resolves the inner token with the
core `token` service, then applies the operation shown.

| Modifier id | Class | Operation | Notes |
|---|---|---|---|
| `urlencode` | `Urlencode` | `urlencode()` | RFC 1738 encoding of the value |
| `uppercase` | `UpperCase` | `mb_strtoupper()` | multibyte |
| `lowercase` | `Lowercase` | `mb_strtolower()` | multibyte |
| `title-case` | `TitleCase` | uppercases first letter of each word | multibyte-aware `ucwords` via `preg_replace_callback` |
| `upper-case-first` | `UpperCaseFirst` | uppercases first letter of the string | multibyte-aware; **id is `upper-case-first`** |
| `length` | `Length` | `substr($value, 0, $n)` | needs `:{n}` before the token (see above) |
| `trim` | `Trim` | `trim()` | strips leading/trailing whitespace |
| `ltrim` | `Ltrim` | `ltrim()` | leading whitespace only |
| `rtrim` | `Rtrim` | `rtrim()` | trailing whitespace only |
| `strip-tags` | `StripTags` | `strip_tags()` | removes HTML tags |

The README also references `sentence-case` and `uppercase-first`; neither is a valid id in 2.0.6
(only the ten above exist, and the ucfirst modifier is `upper-case-first`).

## Gotchas

- **Unknown modifier id throws.** `hook_tokens()` calls `createInstance($modifier)` with the id
  taken straight from the token text; an unrecognised id raises a `PluginNotFoundException` during
  rendering rather than leaving the token in place. Validate any id you let editors author.
- **Unresolved inner token.** The modifier transforms whatever `token->replace()` returns. If the
  inner token is not recognised in the current context and the `clear` option is not set, the
  literal `[the:token]` text passes through, so e.g. `uppercase` yields `[THE:TOKEN]` — a bad inner
  token is not silently emptied.

## Writing your own modifier

Add a plugin class under `Plugin/token_modifier/` in any module. Annotate with `@TokenModifier`
(id / name / description) and extend `TokenModifierPluginBase`; the base injects the core `token`
service as `$this->token`.

```php
// mymodule/src/Plugin/token_modifier/Slugify.php
namespace Drupal\mymodule\Plugin\token_modifier;

use Drupal\token_modifier\Plugin\TokenModifierPluginBase;

/**
 * @TokenModifier(
 *   id = "slugify",
 *   name = @Translation("Slugify"),
 *   description = @Translation("Lowercases and dashes non-alphanumerics.")
 * )
 */
class Slugify extends TokenModifierPluginBase {

  public function transform(string $text, array $data = [], array $options = []) {
    // $text is "[the:inner:token]" — resolve it first, then transform.
    $value = $this->token->replace($text, $data, $options);
    return preg_replace('/[^a-z0-9]+/', '-', strtolower($value));
  }

}
```

Then use `[token-modifier:slugify:node:title]`. Clear caches so the plugin is discovered
(`getModifiers()` / `hook_token_info()` pick it up). See
[api/services.md](../api/services.md) for the interface/base contract and
[hooks/token-integration.md](../hooks/token-integration.md) for how the id is dispatched.

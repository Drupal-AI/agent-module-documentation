# Auto Username — service & hooks

## Service `auto_username.utilities` (`Drupal\auto_username\AutoUsernameUtilities`)

Constructor deps: `entity_field.manager`, `language_manager`, `module_handler`, `config.factory`,
`token`, `database`, `cache.default`, `string_translation`, `transliteration`.

Key public methods:
- `autoUsernameGenerateUsername($account): string` — full pipeline (hook → pattern → uniqueness). The
  main entry point; used by `hook_user_insert`/`hook_user_update` and the bulk Action.
- `autoUsernamePatternprocessor($account): string` — token-replace `aun_pattern`, optional PHP eval.
  Returns `''` if no token resolved.
- `autoUsernameCleanstring($string): string` — the cleaning pipeline (strip tags, punctuation rules,
  reduce-ascii, transliterate, ignore-words, whitespace, separator collapse, lowercase, truncate).
- `autoUsernameCleanSeparators($string, $separator = NULL)` — trim duplicate/leading/trailing separators.
- `autoUsernamePunctuationChars(): array` — the punctuation map (name → value/label), cached and
  alterable (see below).
- `autoUsernameEval($code, $account)` — runs `php_eval()` **only if the `php` module is enabled**.
- `autoUsernameGetSchemaNameMaxlength(): int` — max length of the `users.name` field.

Call it directly:
```php
$name = \Drupal::service('auto_username.utilities')->autoUsernameGenerateUsername($account);
```

## Hooks the module invokes (implement in your module)

Declared in `auto_username.api.php`:

- **`hook_auto_username_name($account)`** — return a string to be used as the username (bypasses the
  token pattern), or NULL/empty to let Auto Username generate it. Invoked via `invokeAll`; if multiple
  modules return a value the **last** one wins.
- **`hook_auto_username_alter(array &$data)`** — post-process the final generated name.
  `$data = ['username' => string, 'account' => UserInterface]`. Example from api.php appends
  `-admin`/`-user` based on role.
- **`hook_autoUsernamePunctuationChars_alter(array &$punctuation)`** — add/adjust punctuation entries
  before they are cached (called via `moduleHandler->alter('autoUsernamePunctuationChars', ...)`).

Note: `auto_username_clean_token_values(&$replacements)` (in the .module) is the token `callback`
used during replacement — it runs each replacement through `autoUsernameCleanstring()`.

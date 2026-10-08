# Configure Auto Username

**Route:** `auto_username.admin_config` → `/admin/config/people/accounts/patterns`
(local task "Patterns" under People → Accounts). **Permission:** `administer auto username` (restricted).
**Form:** `Drupal\auto_username\Form\AutoUsernameSettingsForm`. **Config:** `auto_username.settings`.

## Core settings (`config/install/auto_username.settings.yml` defaults)

| Key | Default | Meaning |
|---|---|---|
| `aun_pattern` | `[user:mail]` | Token pattern for the username. Token replacements are cleaned via `auto_username_clean_token_values`. If no token actually resolves, no name is generated (name left as-is). |
| `aun_php` | `FALSE` | Evaluate the pattern output as PHP. Requires the `php` module AND the restricted `use PHP for username patterns` permission to be meaningful. |
| `aun_update_on_edit` | `TRUE` | Re-generate the name on every user profile save (`hook_user_update`), not just on insert. |
| `aun_separator` | `-` | Separator used when replacing punctuation/whitespace and de-duplicating. |
| `aun_case` | `0` | Character case handling (0 = leave as-is; truthy = lowercase). |
| `aun_max_length` | `60` | Maximum overall alias length. |
| `aun_max_component_length` | `60` | Max per-component length (also bounded by the `users.name` schema max). |
| `aun_transliterate` | `FALSE` | Transliterate Unicode → US-ASCII (current interface language). |
| `aun_reduce_ascii` | `FALSE` | Reduce to `[a-zA-Z0-9/]`, replacing others with the separator. |
| `aun_replace_whitespace` | `FALSE` | Collapse whitespace runs to the separator. |
| `aun_ignore_words` | `''` | Comma/space list of words removed from the name (word-boundary regex). |

## Punctuation actions

For each punctuation character there is an `aun_punctuation_<name>` integer (schema lists them all:
`double_quotes`, `quotes`, `backtick`, `comma`, `period`, `hyphen`, `underscore`, `colon`, `semicolon`,
`pipe`, brackets, `plus`, `equal`, `asterisk`, `ampersand`, `percent`, `caret`, `dollar`, `hash`, `at`,
`exclamation`, `tilde`, parentheses, `question_mark`, `less_than`, `greater_than`, `slash`, `back_slash`).
Values come from `AutoUsernamePunctuationOptions`: **REMOVE** (drop), **REPLACE** (→ separator), or
**DO_NOTHING** (leave). Applied in `autoUsernameCleanstring()`.

## Generation pipeline (order)

`autoUsernameGenerateUsername($account)`:
1. `hook_auto_username_name($account)` — if any module returns a non-empty string, that wins.
2. Otherwise `autoUsernamePatternprocessor()`: token-replace `aun_pattern` (cleaned), then optional
   PHP eval if `aun_php`.
3. If still empty → keep the current display name (no change).
4. Uniqueness: append `_1`, `_2`, … until no other row in `users_field_data` has that name.
5. `hook_auto_username_alter($data)` may post-process the final name.
Result is written directly to `users_field_data` (`UPDATE … SET name`).

Users with `bypass auto_username` are skipped entirely (name untouched).

## Bulk Action plugin

`auto_username_rename_action` (label "Generate username(s) using the 'Auto Username' module", type `user`,
class `Plugin/Action/AutoUsernameRenameAction`). Re-runs generation for each selected user (calls
`auto_username_user_insert`). Access = the target user's `status` edit access AND `update` access.
Shipped as `system.action.auto_username_rename_action` so it appears in the People bulk-operations select.

## Scripting

```php
\Drupal::configFactory()->getEditable('auto_username.settings')
  ->set('aun_pattern', '[user:field_first_name]-[user:field_last_name]')
  ->set('aun_replace_whitespace', TRUE)
  ->set('aun_case', 1)
  ->save();
```

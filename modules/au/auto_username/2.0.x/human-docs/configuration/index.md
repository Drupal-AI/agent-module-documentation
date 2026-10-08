# Configuration

## Open the settings form

1. Log in as a user with the **Administer auto username** permission.
2. Go to **Configuration → People → Account settings**, then open the **Patterns**
   tab — or navigate directly to `/admin/config/people/accounts/patterns`.

## The pattern

- **Pattern** *(default: `[user:mail]`)* — the token pattern used to build the
  username. Use any user tokens: `[user:mail]` for the email address,
  `[user:field_first_name]-[user:field_last_name]` for name fields, a custom profile
  field, and so on. If the pattern resolves to nothing, no name is generated and the
  existing name is left as-is.

## Cleaning options

After the pattern is expanded, the result is cleaned according to these options, so
the final username is tidy and valid:

- **Transliterate** *(default off)* — convert Unicode (accented or non-Latin)
  characters to US-ASCII.
- **Reduce to ASCII** *(default off)* — reduce to `[a-zA-Z0-9/]`, replacing anything
  else with the separator.
- **Replace whitespace** *(default off)* — collapse runs of whitespace to the
  separator.
- **Separator** *(default `-`)* — the character used when replacing punctuation and
  whitespace, and when de-duplicating.
- **Case** *(default: leave as-is)* — optionally lowercase the whole username.
- **Ignore words** — a comma/space list of words to strip out of the name (matched on
  word boundaries), e.g. "the", "and".
- **Maximum length** *(default 60)* and **maximum component length** *(default 60)* —
  cap the overall and per-component length (also bounded by Drupal's own username
  length limit).
- **Punctuation actions** — for each punctuation character (comma, period, hyphen,
  quotes, brackets, and many more) choose **Remove**, **Replace** (with the
  separator), or **Do nothing**.

## When names are generated

- Always on user **creation** (registration or admin-created).
- On every profile **save** too, if **Update on edit** *(default on)* is enabled —
  turn this off if you only want the name set once, at creation.

## Uniqueness and overrides

If a generated name matches an existing account, the module appends `_1`, `_2`, …
until it's unique. Two developer hooks let custom code take over: a module can supply
the whole name via `hook_auto_username_name()`, or post-process the final result via
`hook_auto_username_alter()`.

## Bulk-regenerate existing users

On the **People** admin page (`/admin/people`), the bulk-operations select includes
**"Generate username(s) using the Auto Username module."** Select the users you want
and run it to re-apply the current pattern to existing accounts — ideal after
changing the pattern or importing users.

## Permissions

Three permissions ship with the module (People → Permissions):

| Permission | Notes |
|------------|-------|
| **Administer auto username** | Access the Patterns settings form. Restricted — grant only to trusted admins. |
| **Bypass auto_username** | Users with this are **skipped** by name generation — their username is never overwritten. Grant it to admins or system accounts whose names must stay fixed. This only *exempts* users, so it's safe to grant. |
| **Use PHP for username patterns** | Gates evaluating the pattern as PHP. Restricted. |

## Advanced: PHP-evaluated patterns

There's an **Evaluate as PHP** option *(default off)* for advanced pattern logic. It
only actually does anything when **all** of the following are true: the option is on,
the contrib **PHP** module is installed, *and* the user has the restricted **Use PHP
for username patterns** permission. Because running arbitrary PHP is a security risk,
most sites should leave this off and stick to tokens.

## Setting it in code

```php
\Drupal::configFactory()->getEditable('auto_username.settings')
  ->set('aun_pattern', '[user:field_first_name]-[user:field_last_name]')
  ->set('aun_replace_whitespace', TRUE)
  ->set('aun_case', 1)
  ->save();
```

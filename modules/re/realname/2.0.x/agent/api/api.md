# realname API

Procedural functions in `realname.module` (no service class). Include via the module being
enabled; call directly.

## Generate / read a name

```php
// Generate (or fetch cached) real name for one account. Returns the string.
$name = realname_load(\Drupal\user\Entity\User::load($uid));

// Force-recompute from the current pattern, write it to the {realname} cache table,
// invoke hook_realname_update(), and return it.
$name = realname_update($account);   // $account is a User entity

// Many at once, keyed by uid (array of User objects keyed by uid in, names out).
$names = realname_load_multiple($accounts);
```

On any loaded user entity the generated name is also available as `$account->realname`
(set by `hook_user_load()`), and it is what `$account->getDisplayName()` /
`format_username()` return, because the module implements `hook_user_format_name_alter()`.

## Delete cached names (trigger rebuild)

```php
realname_delete($uid);              // one user
realname_delete_multiple($uids);    // list of uids
realname_delete_all();              // whole table; all names regenerate lazily
```

## Alter hooks (`realname.api.php`)

Implement in `yourmodule.module`:

```php
// Change the pattern for a specific account BEFORE token replacement.
function hook_realname_pattern_alter(&$pattern, $account) {
  if ($account->hasRole('staff')) {
    $pattern = '[user:field_first] [user:field_last] (Staff)';
  }
}

// Post-process the generated name string BEFORE it is saved.
function hook_realname_alter(&$realname, $account) {
  $realname = trim($realname);
}

// React after a name is (re)generated and saved.
function hook_realname_update($realname, $account) {
  // e.g. sync $realname to an external system.
}
```

## Notes

- Pattern replacement uses `\Drupal::token()->replace()` with `clear => TRUE` and
  `sanitize => FALSE`; the result is then rendered as inline Twig, HTML-stripped, and
  truncated to 255 chars.
- Never put `[user:name]` in the pattern — it recurses through name formatting.
- Anonymous users bypass tokens and use their plain label.
- A migrate process plugin `realname_replace_token` (`src/Plugin/migrate/process`) is
  available for importing legacy name data.

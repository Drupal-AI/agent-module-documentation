# Altering allowed IP ranges

`restrict_by_ip.api.php` invites hooks that add/remove CIDR ranges just before a restriction is enforced.
Use them to keep ranges out of config (e.g. in `settings.php`, an external list, or an IP database).

## Semantics

For each restriction context the module reads an allow list, then runs the alter hook. **A non-empty list
= restricted** (the request IP must fall in at least one range); **an empty list = unrestricted**. So
adding ranges to an empty list *introduces* a restriction, and removing all ranges *lifts* one. A malformed
range never matches (fails toward restriction).

## Generic hook

```php
function hook_restrict_by_ip_ranges_alter(array &$ranges, array $context): void {
  if ($context['type'] === 'login_global') {
    foreach (\Drupal\Core\Site\Settings::get('my_office_ranges', []) as $r) {
      $ranges[] = $r; // e.g. '198.51.100.0/24'
    }
  }
}
```

`$context` always has `type` and `ip`; login contexts also have `account`, role contexts have `role_id`.

## Context types

| `type` | Source list | Extra context | When |
|---|---|---|---|
| `login_global` | `restrict_by_ip.settings:login_range` | `account` | At login. |
| `login_user` | user field `restrict_by_ip_ranges` | `account` | At login. |
| `role` | `restrict_by_ip.settings:role.<id>` | `role_id` | Every authenticated request, once per real role (even roles with no configured ranges). |

## Type-specific variants (run after the generic hook)

Same signature: `hook_restrict_by_ip_login_global_ranges_alter()`,
`hook_restrict_by_ip_login_user_ranges_alter()`, `hook_restrict_by_ip_role_ranges_alter()`.

```php
// Pin the administrator role to the office network without configuring it in the UI.
function hook_restrict_by_ip_role_ranges_alter(array &$ranges, array $context): void {
  if ($context['role_id'] === 'administrator') {
    $ranges[] = '198.51.100.0/24';
  }
}
```

Performance: the `role` hook fires on every authenticated request (once per role) — keep implementations
fast and cache any external lookups.

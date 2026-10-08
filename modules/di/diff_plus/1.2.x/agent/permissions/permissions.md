# Permissions

| Permission | `restrict access` | Gates |
|---|---|---|
| `personalize diff plus settings` | not set | The per-user settings form (`diff_plus.user_settings`) AND whether the user's `user.data` overrides are applied on top of the site defaults when rendering diffs. |

The site-default form (`diff_plus.default_settings`) is instead gated by core
`administer site configuration`.

## Effect of the personalization permission

At diff render time (`getDiffSettings()` in both layout plugins and `shouldEnhance()` in the view
subscriber), the code does:

```php
$settings = config('diff_plus.settings')->get();
if ($currentUser->hasPermission('personalize diff plus settings')) {
  $settings = array_replace_recursive($settings, user.data(diff_plus, uid, settings) ?? []);
}
```

So a user without the permission always sees the site defaults; a user with it sees their personal
overrides. The overridable values are all cosmetic/normalization diff preferences (UI header,
beautifier, highlight theme, which dynamic markup to strip, render-as-anonymous) — nothing that
changes access or exposes other users' data — so this non-restricted permission is low impact.

No new content or route access is introduced; viewing a diff still depends entirely on the Diff
module's and the entity's revision-view access.

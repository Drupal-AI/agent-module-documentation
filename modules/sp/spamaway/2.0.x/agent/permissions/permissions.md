# Permissions & bypass

SpamAway defines one permission (`spamaway.permissions.yml`):

| Permission | Effect |
|---|---|
| `spamaway bypass spam detection` | A user with this permission skips **all** SpamAway checks on every webform. |

## Two ways to bypass

The handler's `validateForm()` returns early (no spam checking) when **either**:

1. the current user has `spamaway bypass spam detection`, or
2. `\Drupal\Core\Site\Settings::get('spamaway_bypass_anti_spam', FALSE)` is TRUE — i.e. you set
   `$settings['spamaway_bypass_anti_spam'] = TRUE;` in `settings.php`.

Use (1) to let trusted staff/editors post freely; use (2) to globally turn spam checking off in a
dev/staging environment without touching each webform.

```bash
drush role:perm:add editor 'spamaway bypass spam detection'
```

When logging is enabled on the handler, a bypass is recorded on the `spamaway_spam` channel.

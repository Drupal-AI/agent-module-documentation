# Configure realname

## The one setting: the name pattern

All behavior derives from a single config value:

- Config object: `realname.settings`
- Key: `pattern` (string, max 256 chars)
- Install default: `[user:account-name]` (i.e. the login name)

The pattern is any string containing one or more **`user` Token** placeholders. When Drupal
formats a user's name it is run through Token replacement (with `clear => TRUE`, so unknown
tokens become empty), then inline **Twig**, then HTML is stripped and double spaces collapsed,
then truncated to 255 chars.

### Set the pattern with drush (no UI)

```bash
drush config:set realname.settings pattern '[user:field_first] [user:field_last]' -y
```

Other useful patterns:

```bash
drush config:set realname.settings pattern '[user:account-name]' -y   # login-name fallback
drush config:set realname.settings pattern '[user:mail]' -y           # email as display name
drush config:set realname.settings pattern '[user:field_last], [user:field_first]' -y
```

Read the current pattern:

```bash
drush config:get realname.settings pattern
```

**Constraint:** the pattern must **not** contain `[user:name]` — it re-enters username
formatting and causes infinite recursion (the settings form rejects it). Use
`[user:account-name]` for the login name instead. The pattern is required and must contain at
least one token.

## Admin UI

`/admin/config/people/realname` (route `realname.admin_settings_form`, permission
`administer realname`). Single "Realname pattern" textfield with a Token-browser link
(`user` token types). Menu: **Administration → Configuration → People → Real name**.

## Rebuilding cached names

Generated names are cached in the `{realname}` table (columns `uid`, `realname`, `created`),
keyed by uid, and reused on load. After you change the pattern, existing rows are stale.
Options to rebuild:

- **Clear the cache table** — names regenerate lazily on next user load:
  ```bash
  drush php:eval 'realname_delete_all();'
  ```
- **Force-regenerate a user now** (also refreshes the cached row):
  ```bash
  drush php:eval '\Drupal\user\Entity\User::load(1); realname_update(\Drupal\user\Entity\User::load(1));'
  ```
- **Bulk action** — the module ships `system.action.realname_update_realname_action`
  ("Update real names of the selected user(s)"), usable from the People admin listing or VBO
  to recompute a batch of users.

Changing `realname.settings` also invalidates the config's cache tag (via the
`realname.config_cache_tag` event subscriber) so rendered names refresh.

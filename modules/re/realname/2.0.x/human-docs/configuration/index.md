# Configuration

Real Name has one thing to configure: the **name pattern**. Everything else
follows from it.

## Open the settings form

1. Log in as a user with the **Administer realname** permission (an administrator
   by default).
2. Go to **Configuration → People → Real name**
   (`/admin/config/people/realname`).

## The name pattern

The form has a single **Realname pattern** text field with a Token-browser link
next to it. Enter any string containing one or more `user` tokens. When Drupal
displays a user's name, the pattern is run through Token replacement (unknown
tokens become empty), then inline Twig, then HTML is stripped, extra spaces are
collapsed, and the result is truncated to 255 characters.

Some common patterns:

| Pattern | Result |
|---|---|
| `[user:field_first] [user:field_last]` | First and last name from profile fields |
| `[user:field_last], [user:field_first]` | "Last, First" ordering for a directory |
| `[user:account-name]` | Falls back to the login name (the install default) |
| `[user:mail]` | Email address as the display name (intranet sites) |
| `[user:field_first] [user:field_last] (Member)` | Name with a fixed suffix |

**One important rule:** the pattern must **not** contain `[user:name]`. That token
re-enters username formatting and causes infinite recursion — the form rejects
it. Use `[user:account-name]` when you want the login name. The pattern is
required and must contain at least one token.

### Setting the pattern with Drush

Because the whole configuration is the single `realname.settings:pattern` value,
you can also set it from the command line:

```bash
drush config:set realname.settings pattern '[user:field_first] [user:field_last]' -y
drush config:get realname.settings pattern      # read the current pattern
```

## Rebuilding cached names

Generated names are cached in a `{realname}` database table, keyed by user id, so
they don't have to be recomputed on every request. When you **change** the
pattern, existing cached names become stale. Saving the form invalidates the
config cache so rendered names refresh, but the stored rows rebuild lazily the
next time each user is loaded. If you want to force a rebuild:

- **Regenerate everyone at once** — use the bulk action *"Update real names of
  the selected user(s)"* from the People admin listing (**People**, select users,
  choose the action). This is the friendliest option through the UI.
- **Clear the cached names** so they regenerate on demand:

  ```bash
  drush php:eval 'realname_delete_all();'
  ```

That's all there is to it — once the pattern is set and cached names are rebuilt,
users appear by their real name throughout the site.

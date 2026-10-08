# Configuration

## Open the settings form

1. Log in as a user with the **Administer redirect_after_login settings**
   permission (grant it on **People → Permissions**).
2. Go to **Configuration → People → Redirect After Login**, or navigate directly
   to `/admin/config/people/redirect`. (It is also linked from the People section
   as "Set Login Destination.")

## The fields

### Destination per role

The form shows **one required textfield for every role** on the site (except
*Anonymous*). Enter the internal path a user with that role should land on after
logging in, for example:

- `/admin/content` for an Editor role
- `/admin` for an Administrator role
- `/user` or a member-dashboard path for authenticated users

**Rules for the value:**

- It must be an **internal path** that starts with `/`, `#`, or `?`. External URLs
  are rejected.
- You can use the special token `<front>` to mean the site's front page (it is
  stored as `/`).
- The path must be a valid, existing path — the form validates it on save.

### Exclude URLs

A textarea where you list paths, one per line, on which login should **not**
trigger a redirect. The `*` wildcard is supported (for example `/node/*`). Use
this to leave a custom login landing page intact.

## Save

Click **Save configuration**. The destinations apply on the next login.

## How the destination is chosen

When a user logs in, the module works through these rules in order:

1. If an explicit `?destination=` deep link is already present (other than the
   login page itself), it is **respected** and no override happens.
2. In maintenance mode, users without the bypass permission fall back to `/`.
3. If the current page matches an **Exclude URLs** entry, no redirect happens.
   Password-reset and one-time-login routes are always skipped too.
4. **Role priority:** for a user with several roles, the destination is taken from
   the **last role** in their role list. If that role has no destination set, the
   module falls back to the front page (`/`).

## Doing it from the command line

The settings are a config object, so Drush works and they deploy as exported
config:

```bash
drush cset redirect_after_login.settings login_redirection.editor /admin/content -y
drush cset redirect_after_login.settings login_redirection.administrator /admin -y
drush cset redirect_after_login.settings exclude_urls "/node/*" -y
```

Note there is no `config/install` default, so the config values exist only after
you first save the form (or set them via Drush).

## Permission

| Permission | Grants |
|------------|--------|
| **Administer redirect_after_login settings** | Access to the settings form. Marked as administrative/trusted. |

This is the only permission the module defines — there is no per-user access gate
on the redirect itself; it simply fires for any authenticated user based on the
per-role map.

## For developers

A `RedirectAfterLoginEvent` is dispatched with the resolved URL just before the
redirect, so a custom subscriber can change the target (`setUrl()`) or cancel it
(`setRedirectAllowed(FALSE)`). The module also integrates with the Passwordless
login module via `hook_passwordless_login_redirect_alter()`. See the sibling
[`agent/`](../agent/start.md) docs for details.

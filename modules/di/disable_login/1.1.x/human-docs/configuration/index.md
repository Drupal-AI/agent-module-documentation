# Configuration

Disable Login Page does nothing until you configure it — the module ships **no
default settings**, so login protection is **off** the moment you enable the
module. This page walks through turning it on.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Security → Disable Login Page**, or navigate directly
   to `/admin/config/security/disable-login`.

## The three settings

- **Enable protection** (`disable_login`) — the master on/off switch. When off,
  `/user/login` behaves exactly as normal. When on, the login page is blocked
  unless the request carries the correct key.
- **Querystring** (`querystring`) — the **name** of the URL parameter the module
  looks for. If you leave it blank the form defaults it to `key`. You can pick
  anything, so your private URL could use `?entry=` or `?door=` instead.
- **Secret** (`secret`) — the **value** that parameter must have. This is the
  actual password embedded in your login URL.

With, say, `querystring = key` and `secret = abc123`, the result is:

```
/user/login              → 403 Access Denied
/user/login?key=abc123   → the normal login form
```

## Save and share the URL

Click **Save configuration**. Protection takes effect immediately. Give the
people who need to log in the full bookmarkable URL — for example
`https://example.com/user/login?key=abc123`. Anyone hitting `/user/login` without
the key sees Access Denied.

Both the HTML login form and Drupal's `user.login.http` route are protected in
one step, so there is no back door around the check.

## Setting it up from the command line

If you prefer, configure everything with Drush instead of the form:

```bash
drush cset disable_login.settings disable_login 1 -y
drush cset disable_login.settings querystring key -y
drush cset disable_login.settings secret abc123 -y
```

Read the current values back with `drush cget disable_login.settings`.

## Rotating the secret automatically (optional)

For teams that want the key to change on a schedule — or come from an environment
variable or key store rather than sitting in config — a small custom module can
override the secret at runtime via `hook_disable_login_key_alter()`. When a hook
changes the value, the settings form shows the current effective secret so you can
still see what URL to use. See the [`agent/`](../agent/start.md) docs for the hook
signature and examples.

## If you lock yourself out

If you forget the key/value and can no longer reach the login form, you have
several ways back in:

- Set the flag back to off with Drush:
  `drush cset disable_login.settings disable_login 0 -y`.
- Or disable the module entirely: `drush pmu disable_login -y`.
- As a last resort, the access checker has a documented manual override — an
  editable `return TRUE;` line in `src/Access/DisableLoginAccessCheck.php` — noted
  in the [`agent/`](../agent/start.md) docs.

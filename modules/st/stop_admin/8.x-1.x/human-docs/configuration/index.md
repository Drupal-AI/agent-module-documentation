# Configuration

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → People → Stop administrator login**, or navigate
   directly to `/admin/config/people/stop_admin`.

Because of a misspelling in the module's permissions file, the intended
*administer stop_admin configuration* permission is never registered — so in
practice this form is reachable only by users who can already administer the site.
You cannot delegate it to a non-administrator role.

## Settings

- **Disabled** — the master switch. Tick this to turn the login block off again
  (for example if you have locked yourself out and recovered via Drush, or you no
  longer want the restriction). Leave it unchecked for the module to actively block
  user 1.
- **Block the administrator role** — when ticked, the block extends beyond user 1
  to *every* user who holds a role flagged as an administrator role (the role
  flagged **is admin** under `/admin/people/role-settings`). Before enabling this,
  make absolutely sure another role on the site has enough permissions to keep
  managing it — otherwise you may leave no one able to administer the site through
  the UI.

## Save

Click **Save configuration**. The change takes effect immediately for subsequent
login-form attempts.

## If you lock yourself out

You can always log in as user 1 from the command line even while the block is
active:

```bash
drush user:login
```

(Prefix with `ddev` if you run DDEV from your host: `ddev drush user:login`.) From
there you can revisit this form and tick **Disabled**, or adjust the role setting.
The project's recovery guide is at
<https://www.drupal.org/docs/contributed-modules/stop-administrator-login>.

## A reminder about scope

This form controls a login-*form* validator only. It does not close core's JSON
login endpoint (`/user/login?_format=json`), one-time login links from
`/user/password`, or basic-auth/SSO logins. If you need the account to be
genuinely unusable everywhere, block the account itself instead of relying on this
setting.

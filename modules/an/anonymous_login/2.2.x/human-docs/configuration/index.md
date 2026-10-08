# Configuration

All of Anonymous Login's behavior comes from a single settings form. Until you
add at least one path here, the module does nothing.

## Open the settings form

1. Log in as a user with the **Administer anonymous login settings** permission
   (`administer anonymous login settings`).
2. Go to **Configuration → User interface → Anonymous login**, or navigate
   directly to `/admin/config/user-interface/anonymous-login`.

## Page paths

This is the heart of the module: a textarea where you list one path per line.

- A **plain path** is an *include* — anonymous visitors who hit it are redirected
  to the login page. Examples: `/members/*`, `/node/*`, `/dashboard`, or `*` for
  the entire site.
- A path that starts with a **tilde (`~`)** is an *exclude* — it is never
  protected, and an exclude always wins over an include. Use it to carve public
  pockets out of a protected area.
- The asterisk (`*`) is a **wildcard**. `/members/*` matches everything under
  `/members`.

For example, to protect the whole members area but leave its public landing page
open:

```
/members/*
~/members/public
```

The form trims blank lines for you. Both the raw internal path (like
`/node/12`) and its alias are checked, so you can list whichever form is more
convenient.

A few paths are **always excluded no matter what you type here**:
`user/reset/*` (password reset links), `cron/*`, and `sites/default/files/*`
(public files). Anonymous Login also never redirects on the login page itself,
on `.php` requests, on the command line, in maintenance mode, or for users who
are already logged in.

## Login page path

Where to send visitors to sign in. The default is `/user/login`. Change it if
you use a custom login route — for example a single-sign-on login path. After
login, Drupal returns the visitor to the page they originally requested because
the module appends `?destination=` to this URL automatically.

## Login message

An optional status message shown to the visitor when they are redirected — for
example "Please log in to view this page." Leave it blank for no message.

## Save

Click **Save configuration**. Changes take effect on the next request. Test by
visiting a protected path in a private/incognito browser window: you should be
bounced to the login form and, after signing in, returned to that page.

## Adding rules from code (optional)

Other modules can add always-on include/exclude rules without editing this form
by implementing `hook_anonymous_login_paths_alter()`. That is a developer
feature — see the [`agent/`](../../agent/api/redirect.md) docs for the details.

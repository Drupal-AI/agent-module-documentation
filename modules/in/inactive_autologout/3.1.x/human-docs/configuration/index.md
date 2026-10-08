# Configuration

The module ships **disabled** — nothing happens until you turn it on and set a
timeout here. All settings live in one form.

## Open the settings form

1. Log in as a user with the **Administer inactive autologout** permission.
2. Go to **Configuration → People → Autologout settings**
   (`/admin/config/people/autologoutsettings`).

## The settings, one by one

- **Enable** — the master switch. Until you tick this, no library is loaded and
  no one is logged out. Off by default.
- **Timeout** — the idle time, **in seconds**, before a user is logged out.
  Defaults to `120` and **must be at least 120** (the form rejects anything
  lower). For a five-minute timeout, enter `300`.
- **Role-based timeout** — when ticked, users get a per-role timeout instead of
  the single default. See below.
- **Modal title** — the heading of the countdown warning modal. Defaults to
  `Session Expiring`.
- **Modal text** — the body of the warning. HTML is allowed, and you place the
  live countdown number with the `@count` placeholder. The shipped default reads:
  *"You will be logged out in `@count` seconds due to inactivity."*

Click **Save configuration** to apply.

## Per-role timeouts

If you tick **Role-based timeout**, the form shows an entry for each of your
roles (every role except Anonymous and Authenticated). For each role you want to
treat specially, enable it and give it its own timeout in seconds (also subject
to the 120-second minimum).

At runtime the module looks at the current user's roles and uses the timeout of
the **first** enabled role it finds, falling back to the default **Timeout** for
everyone else. Typical uses: a short timeout for a "kiosk" role, or a stricter
timeout for a highly privileged admin role while day-to-day roles keep the
default.

## What users experience

Once enabled, authenticated users have their activity tracked in the background.
As the idle limit approaches, the warning modal appears with the live countdown;
any activity resets the timer. If the countdown reaches zero the session ends and
the user is redirected to the standard login page. Anonymous visitors are never
affected.

## Scripting it with Drush

You can configure everything from the command line, for example:

```bash
# turn on with a 5-minute idle timeout
drush cset inactive_autologout.settings enable 1 -y
drush cset inactive_autologout.settings timeout 300 -y

# customise the warning modal title
drush cset inactive_autologout.settings modal_title 'Session ending' -y

# per-role example: a 3-minute timeout for the 'editor' role
drush cset inactive_autologout.settings role_based_timeout 1 -y
drush cset inactive_autologout.settings editor 1 -y
drush cset inactive_autologout.settings editor_timeout 180 -y
```

The values are stored in the `inactive_autologout.settings` config object, so
they export and deploy like any other configuration.

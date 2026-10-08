# Configuration

Everything lives on one settings form, backed by the
`protect_form_flood_control.settings` config object.

## Open the settings form

1. Log in as a user with the **Administer protect form flood control** permission.
2. Go to **Configuration → User interface → Protect Form Flood Control**, or navigate
   directly to `/admin/config/user-interface/protect-form-flood-control`.

## The two numbers that matter

- **Window** — the length of the flood window, in seconds (default `86400`, i.e. 24
  hours).
- **Threshold** — the maximum number of submissions allowed within that window
  (default `50`).

A client that exceeds the threshold within the window is blocked from submitting again
until the window passes.

## Choose what to protect

There are two modes:

- **Protect all forms** — every form is protected, *except* core's always-exempt
  `system_*`, `search_*` and exposed-filter forms, the module's own settings form, and
  anything you list under **unprotected IDs**.
- **Protect a list of forms** *(default)* — only the form IDs you list under
  **protected IDs** are protected.

Form IDs are matched with Drupal's path matcher, so `*` **wildcards** work — for
example `webform_submission_*` covers every webform, and `user_*` covers the user
forms. Both a form's concrete ID and its **base form ID** are tested, which is what lets
a single wildcard cover many form instances.

> **Don't know a form's ID?** Turn on **Show form IDs** (below) to have Drupal print
> each form's ID and base form ID to you as you browse.

## Per-form overrides

Beyond the global window/threshold you can set different limits for specific forms. Each
override entry lists one or more form IDs plus its own window and threshold — for
example, allow only 3 submissions per hour on the registration form:

```yaml
forms:
  - ids:
      - user_register_form
    window: 3600
    threshold: 3
```

When a protected form matches an override, that override's window/threshold apply
(falling back to the global values where an override field is left empty).

## Bypass and debug

- **Whitelist** — a list of client IP addresses that skip protection entirely (default
  includes `127.0.0.1`). Add your office IP so staff testing forms are never blocked.
- **Bypass permission** — users in a role with **Bypass protect form flood control** are
  never flood-limited.
- **Log** — when on, blocked submissions are logged to the module's logger channel so
  you can monitor abuse patterns and tune your thresholds.
- **Show form IDs** — when on, privileged users (those with **View protect form flood
  control form IDs**, or an admin) see a status message listing each form's ID and base
  form ID. Use it to discover the IDs you want to protect, then turn it back off.

## Permissions

At **People → Permissions**:

- **Administer protect form flood control** — reach this settings form.
- **Bypass protect form flood control** — never be flood-limited.
- **View protect form flood control form IDs** — see the debug form-ID messages.

## Setting it from the command line

```bash
drush cget protect_form_flood_control.settings
drush cset protect_form_flood_control.settings general.protect_all 1 -y
drush cset protect_form_flood_control.settings general.threshold 5 -y
drush cset protect_form_flood_control.settings general.window 3600 -y
```

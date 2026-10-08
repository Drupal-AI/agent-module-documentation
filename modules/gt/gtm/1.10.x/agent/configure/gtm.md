# Configure GTM

Settings form: **`/admin/config/system/gtm`** (route `gtm.settings`, form
`Drupal\gtm\Form\SettingsForm`). Permission required: **`administer gtm`**.
All values persist in the single config object **`gtm.settings`** (no config schema ships).

## Config keys (`gtm.settings`)

| Key | Form label | Type | Default | Effect |
|---|---|---|---|---|
| `enable` | Enable Google Tag Manager | bool (0/1) | `0` | Master switch. Nothing is injected unless this is truthy. |
| `google-tag` | GTM-ID | string | `''` | The container ID, e.g. `GTM-XXXX`. Nothing is injected while empty. In the head script it is sanitized to `[a-zA-Z0-9-]` only. |
| `admin-pages` | Display Google Tag Manager on admin pages | bool (0/1) | `0` | When `0`, GTM only fires on non-admin routes (front end). When `1`, it also fires on `/admin/*` routes. |
| `admin-disable` | Disable for admin | bool (0/1) | `0` | When `1`, GTM is suppressed for user **uid 1** (the superuser), even on pages where it would otherwise fire. |

### Insertion conditions (when does the snippet appear?)

The snippet is added when **all** of these hold (see `gtm_page_attachments()` / `gtm_page_top()`):

1. `enable` is truthy, **and**
2. `google-tag` is non-empty, **and**
3. `admin-pages` is truthy **OR** the current route is not an admin route, **and**
4. not (current user is uid 1 **and** `admin-disable` is truthy) — this exclusion applies to the head script only.

## Set it with Drush (recommended for automation)

```bash
# Minimal go-live: container ID + master switch (front-end only, superuser excluded)
drush cset gtm.settings google-tag 'GTM-ABCD123' -y
drush cset gtm.settings enable 1 -y
drush cset gtm.settings admin-disable 1 -y
drush cr
```

```bash
# Also fire on admin pages
drush cset gtm.settings admin-pages 1 -y
```

Read current values:

```bash
drush cget gtm.settings
```

## Notes

- There is **no config schema**, so `drush cset` writes raw values; use integers `0`/`1`
  for the boolean flags to mirror the form and the install defaults.
- Tags, triggers, and variables are configured in the Google Tag Manager web UI, not in
  Drupal. This module only injects the container bootstrap.

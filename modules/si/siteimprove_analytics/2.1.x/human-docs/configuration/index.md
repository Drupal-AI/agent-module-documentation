# Configuration

All settings live on one form. The tracker stays **off** until you enter an
application code, so nothing is loaded by accident.

## Open the settings form

1. Log in as a user with the **"administer siteimprove_analytics"** permission.
2. Go to **Configuration → System → Siteimprove Analytics**, or navigate directly
   to `/admin/config/system/siteimprove-analytics`.

## Settings, field by field

- **Application code** — the numeric code from your Siteimprove dashboard. This is
  the value that appears in the tracker URL
  (`…/siteanalyze_<code>.js`). It is validated to be numeric. **Leaving it empty
  disables tracking entirely** — no script is added.
- **Track for** (audience) — who gets the tracker:
  - **Anonymous** *(default)* — only anonymous visitors are tracked, which keeps
    staff and editors out of your analytics.
  - **Logged in** — only authenticated users are tracked.
  - **Everyone** — all visitors are tracked.
- **Excluded routes** — a list of path patterns, **one per line**, whose matches
  are **excluded** from tracking. Wildcards are allowed. Paths are matched against
  their alias, so aliased URLs are covered too. The defaults already exclude
  administrative and editing screens:

  ```
  /admin
  /admin/*
  /batch
  /node/add*
  /node/*/edit
  /node/*/delete
  /user/*/edit
  /user/*/cancel
  ```

  Add your own lines to exclude other sections you don't want tracked.

## Save

Click **Save configuration**. Tracking begins immediately on pages that pass both
filters (audience and excluded routes). The script loads asynchronously so it
doesn't block page rendering.

## Setting it per environment (optional but recommended)

Because everything is stored in the `siteimprove_analytics.settings` config
object, you can override it from `settings.php` — handy for keeping non-production
environments untracked, or for pointing different environments at different codes:

```php
$config['siteimprove_analytics.settings']['code'] = '1234567';
$config['siteimprove_analytics.settings']['user_filter'] = 'everyone';
$config['siteimprove_analytics.settings']['routes_filter'] = "/admin\n/admin/*\n/secret/*";
```

For example, leave `code` empty (or unset) on staging so no tracking happens there.

### Keep the code out of version control

If you prefer to treat the application code as an environment secret rather than
committed config, store it in an environment variable and read it in
`settings.php` with `getenv()`:

```php
$config['siteimprove_analytics.settings']['code'] = getenv('SITEIMPROVE_CODE') ?: '';
```

With DDEV you can set the variable without committing it:

```bash
ddev dotenv set .ddev/.env --siteimprove-code=1234567
ddev restart
```

(The flag `--siteimprove-code` becomes the variable `SITEIMPROVE_CODE`. Keep
`.ddev/.env` out of version control.)

## Set it with Drush (optional)

```bash
ddev drush cset siteimprove_analytics.settings code 1234567 -y
ddev drush cset siteimprove_analytics.settings user_filter everyone -y
```

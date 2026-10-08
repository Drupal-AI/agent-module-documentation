# Configuration

Configuration means creating **tracker items** — one per field-and-value mapping
you want applied when a lower environment is refreshed from production. Each item
is stored as a configuration entity, so it persists across deployments and can be
exported with the rest of your site config.

## Open the tracker screen

1. Log in as a user with the **Administer field value tracker** permission.
2. Go to **Configuration → Development → Field Value Tracker**, or navigate
   directly to `/admin/config/development/field-value-tracker`.

You'll see a list of existing tracker items (empty at first) and an **Add field
value tracker item** button.

## Add a tracker item, field by field

Click **Add field value tracker item** and fill in the form:

- **Mode** — choose how the value is changed:
  - **Replace** performs a substring replacement wherever the production value
    appears in the field. Use this for values embedded in larger text, such as
    turning `production.example.com` into `staging.example.com` inside a URL.
  - **Overwrite** replaces the field's value entirely, ignoring what was there.
    Use this to force a fixed value everywhere, such as setting every notification
    email address to `test@example.com`.
- **Field** — an autocomplete that selects which field to track. Pick the field
  using the `entity_type.bundle.field_name` format (for example
  `node.article.field_api_url`). Only fields that store their data in field tables
  are eligible; entity base fields cannot be tracked.
- **Production value** — for **Replace** mode, the string to find (the production
  value you want to get rid of). For **Overwrite** mode this identifies what you
  are replacing.
- **Lower environment value** — the value to use instead: the replacement string
  for Replace mode, or the fixed value for Overwrite mode.

Click **Save**. Repeat for every field you want managed — a real site typically
has several items (API endpoints, email addresses, CDN domains, SSO/login URLs).

## Apply the changes with Drush

Configuration only records *what* should change; the swap itself is run from the
command line, normally right after you sync a production database into a lower
environment.

1. Preview first with a dry run — this reports what would change without writing
   anything:

   ```bash
   drush fvt:update --dry-run
   ```

2. When the preview looks correct, apply it:

   ```bash
   drush fvt:update
   ```

3. Rebuild caches so the new values are shown — the module updates the database
   directly and does **not** clear entity caches for you:

   ```bash
   drush cr
   ```

## Production safety

The module refuses to run the update in an environment it detects as production
(Acquia and Pantheon production environments are recognised automatically), so an
accidental `drush fvt:update` on live will not rewrite your real data. Even so,
keep the **Administer field value tracker** permission restricted to trusted
administrators, and avoid pointing production values at non-production endpoints
(or vice versa) in your saved items.

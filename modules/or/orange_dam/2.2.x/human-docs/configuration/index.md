# Configuration

Orange DAM connects your site to Orange Logic's Orange DAM API, so the most important
part of configuring it is **supplying the API credentials safely** and understanding
that the module is a foundation you build migrations on top of.

## Understand what you're configuring

This module is the generic integration layer. A complete setup means:

1. A **data model in Drupal** (the content types / fields that will hold your
   assets).
2. **Migrations** (built with the Migrate Plus tooling) that map Orange DAM fields to
   that model.
3. The **Orange DAM API connection details** those migrations use to reach your
   Orange DAM instance.
4. **Cron or Drush runs** that monitor Orange DAM for changes and run the migrations.

The credential handling below applies wherever those API details are supplied.

## Store the API credentials as secrets

The Orange DAM API key / credentials are secrets — never hard‑code them in code or
commit them to version control, and never place a real secret directly in an exported
migration or settings file that ends up in Git.

If you are working in **DDEV**, save the value as an environment variable rather than
in a file that gets committed:

```bash
ddev dotenv set .ddev/.env --orange-dam-api-key=<value>
ddev restart
```

The flag `--orange-dam-api-key` becomes the environment variable
`ORANGE_DAM_API_KEY` inside the web container. Keep `.ddev/.env` out of version
control.

Where the integration accepts a **Key entity** for the credential, prefer that. Make
sure the Key module is installed (`ddev composer require drupal/key` and
`ddev drush en key -y`), confirm the variable is present in the container **without
printing its value**:

```bash
ddev exec 'test -n "$ORANGE_DAM_API_KEY"'   # exit status 0 means it is set
```

then create a Key that reads from the environment variable:

```bash
ddev drush key:save orange_dam_api_key \
  --label='Orange DAM API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"ORANGE_DAM_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Where a Key entity does not apply, reference the environment variable directly (for
example via `getenv('ORANGE_DAM_API_KEY')` in `settings.php`) rather than storing the
secret in exported configuration.

## Egress and audience considerations

- **Outbound calls (egress).** The module reaches out to the Orange DAM API. Make
  sure your environment allows that outbound traffic, and that **all** Orange DAM URLs
  use **HTTPS** so credentials and asset data are never sent in cleartext.
- **Only import what your audience should see.** The module imports asset data into
  Drupal; it has no access‑control role of its own. Import and expose only the assets
  that are appropriate for your site's audience, and apply your normal Drupal
  entity/field permissions to the content you create from them.

## Run the synchronisation

Once your migrations and credentials are in place, the module monitors Orange DAM for
changes, queues them, and runs the migrations via **cron** or via its **custom Drush
commands**. Schedule these to run on the cadence your content freshness needs — and
run an initial sync manually to confirm assets flow through into your Drupal data
model as expected.

# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 | ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only hard dependency, enabled
  automatically when you turn on Migrate Sandbox.

There are no third‑party Composer or PHP library requirements.

### Recommended companion modules

These aren't required, but they make the sandbox much more useful:

- **Yaml Editor** (`yaml_editor`) — greatly improves the editing experience for
  the source data and pipeline fields.
- **Migrate Plus** (`migrate_plus`) — many of the built‑in examples cover Migrate
  Plus plugins. Its **Migrate Example** submodule underpins the
  `migration_lookup` example (based on the `beer_term` migration), so running that
  migration makes the example work without any editing.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_sandbox -W
```

To add the recommended companions:

```bash
composer require drupal/yaml_editor drupal/migrate_plus -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_sandbox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_sandbox -y
```

Optionally enable the companions:

```bash
drush en yaml_editor migrate_plus -y
```

> **Development only.** Migrate Sandbox executes process plugins against
> user‑supplied input and should **never** be enabled on a production site or
> exposed to untrusted users. Grant the restricted `access migrate_sandbox`
> permission only to trusted developers.

## Verify it worked

Log in as a user with the `access migrate_sandbox` permission and go to
**Configuration → Development → Migrate Sandbox**
(`/admin/config/development/migrate-sandbox`). Pick one of the built‑in starter
configurations, click **Save & Run**, and you should see the pipeline output
rendered on screen.

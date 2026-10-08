# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Moodle** installation you control, with web services enabled and a
  web-service token (the Moodle-side setup is covered in
  [Configuration](../configuration/index.md)).

The base module declares no other Drupal module dependencies. There are no
third-party PHP library requirements.

> **Note:** this module is **not covered** by Drupal's security advisory policy.
> Review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/moodle_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moodle_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and the submodules you need

Enable the base module plus only the submodules matching the components you want
to sync:

```bash
# Base module:
drush en moodle_sync -y

# Add the sync pieces you need, e.g.:
drush en moodle_sync_course moodle_sync_users moodle_sync_enrollments -y
```

## Submodules

| Submodule | Machine name | What it syncs |
|-----------|--------------|---------------|
| Category | `moodle_sync_category` | Drupal taxonomy terms → Moodle course categories |
| Course | `moodle_sync_course` | Drupal entities → Moodle courses |
| Template | `moodle_sync_template` | Taxonomy terms → Moodle courses used as templates |
| Cohorts | `moodle_sync_cohorts` | Taxonomy-term references → Moodle cohort membership |
| Enrolments | `moodle_sync_enrollments` | Drupal registrations → Moodle user enrolments |
| Users | `moodle_sync_users` | Drupal users/profiles → Moodle users |
| Completion | `moodle_sync_completion` | Receives Moodle completions back (needs the Moodle-side `local_completion_push` plugin) |

Each submodule requires the base `moodle_sync` module. Enable only what you need
— every enabled submodule also determines which Moodle web-service functions you
must authorise on the Moodle side (see [Configuration](../configuration/index.md)).

## Verify it worked

Confirm the base module (and your chosen submodules) are enabled:

```bash
drush pm:list --status=enabled | grep moodle_sync
```

Then complete the connection setup in [Configuration](../configuration/index.md)
before creating or editing entities you expect to sync.

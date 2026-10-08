# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies beyond Drupal core.
- To use the Behat steps, the **Drupal Extension for Behat** in your project's dev
  toolchain.

> **Test environments only.** This module is for testing and should not be
> installed on production sites — it can slow performance and has no security
> advisory coverage. Install it as a **dev** dependency.

## Install with Composer

From the project root, install it as a development dependency:

```bash
composer require --dev drupal/datetime_testing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/datetime_testing -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it only in your test/CI environment:

```bash
drush en datetime_testing -y
```

## Wire up the Behat subcontext (optional)

If you want to use the module's Behat steps (`Given the time is 12pm`,
`When "1 hour" passes`), tell Behat where to find the subcontext in your project's
`behat.yml`:

```yaml
Drupal\DrupalExtension:
  subcontexts:
    paths:
      - "/app/web/modules/contrib/datetime_testing"
```

Adjust the path to match where the module lives in your project. You do **not**
need to declare the subcontext under the `contexts` key.

## Verify it worked

With the module enabled in a test environment, a quick check from Drush confirms
the decorated time service is active — setting the time and reading it back should
return the value you set:

```bash
drush ev '\Drupal::service("datetime.time")->setTime("2008-12-03 09:15pm"); print \Drupal::time()->getCurrentTime();'
```

If Behat is configured, a scenario step such as `Given the time is 12pm` should now
be recognised.

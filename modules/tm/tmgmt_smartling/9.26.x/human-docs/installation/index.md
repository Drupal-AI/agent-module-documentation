# Installation

## Requirements

- **Drupal 9.3, 10.1, or 11** (`core_version_requirement: ^9.3 || ^10.1 || ^11`).
- The **Translation Management Tool** stack, pulled in as Composer dependencies:
  - `drupal/tmgmt` (`~1.14`) — and its **TMGMT** and **TMGMT File** modules.
  - `drupal/tmgmt_extension_suit` (`~9.4`) — used to queue uploads and downloads.
  - Core's **Serialization** module.
- The **Smartling PHP SDK** (`smartling/api-sdk-php` `~5`), installed
  automatically via Composer.
- A **Smartling account** with a project, and its **Project Id**, **User Id**, and
  **Token Secret**.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_smartling -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT, the
extension suite, the Smartling SDK, and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tmgmt_smartling -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_smartling -y
```

This also enables the required TMGMT modules if they are not already on.

## Store the Smartling credentials as a secret

The **Token Secret** is a credential and must not be committed to version
control. Set it as an environment variable per environment and reference it from
Drupal rather than typing it into exported configuration. With DDEV, for example:

```bash
ddev dotenv set .ddev/.env --smartling-token-secret=<value>
ddev restart
```

Then reference the variable from `settings.php` (or a Key entity) so the provider
config never carries the plaintext secret. The same applies to the Project Id /
User Id if you treat them as sensitive.

## Optional submodules

Enable these only if you need them:

- **tmgmt_smartling_context_debug** — a form for debugging the visual-context
  feature.
- **tmgmt_smartling_log_settings** — per-channel log severity for Smartling
  logging.
- **tmgmt_smartling_acquia_cohesion** — Acquia Cohesion support (hidden; requires
  the `cohesion` module).
- **tmgmt_smartling_test** — test-only helper (hidden).

## Next steps

Nothing is configured yet — you now create a Smartling provider in TMGMT and enter
your credentials. See [Configuration](../configuration/index.md).

# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core **Block** — required to place list signup blocks.
- Core **REST** — required only if you want to use the provided REST endpoint.
- Core **Datetime** — if you use custom date fields.
- **Webform** — if you want to send webform submissions to an enabled list.
- A **Sendinblue / Brevo account**, with an app created on the developer portal and
  an API key.

> **Heads‑up on the dependency typo.** The module's info file misspells the
> dependencies key as `depencencies`, so Drupal may **not** automatically enforce
> the declared dependence on Block and REST. Enable those core modules yourself if
> you rely on the signup block or REST endpoint.

## Install with Composer

From the project root:

```bash
composer require drupal/sendinblue_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sendinblue_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sendinblue_api -y
```

Because of the info‑file typo noted above, also enable the core modules you need
explicitly, for example:

```bash
drush en block rest -y
```

## After enabling

1. Set your API key (in `settings.php` or the admin UI) and authorize the
   connection — see [Configuration](../configuration/index.md).
2. Enable the lists you want, then place blocks / add webform handlers / add fields
   as needed.

## Verify it worked

Go to **Configuration → Web services → Sendinblue**
(`admin/config/services/sendinblue-api`). After saving a valid API key and
authorizing, the lists screen (`…/lists`) should show your Brevo lists ready to
enable.

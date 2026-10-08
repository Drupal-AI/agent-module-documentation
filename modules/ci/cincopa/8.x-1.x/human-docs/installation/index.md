# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A **Cincopa account** and its **API credentials**. Cincopa is a commercial
  service; a free trial is available at [cincopa.com](https://www.cincopa.com).

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cincopa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cincopa -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cincopa -y
```

## Connect your Cincopa account (store the credentials securely)

The module needs your Cincopa API credentials to reach your media library.
**Never hard-code or commit a secret** — put the value in an environment variable
instead. With DDEV you can store it in the project's dotenv file and load it into
the container:

```bash
ddev dotenv set .ddev/.env --cincopa-api-key=<your-key>
ddev restart
```

That makes the value available inside the container as `CINCOPA_API_KEY` (keep
`.ddev/.env` out of version control). Reference it from Drupal rather than pasting
it into a settings form — for example through the [Key](https://www.drupal.org/project/key)
module's environment provider, or from `settings.php` via `getenv('CINCOPA_API_KEY')`.

## Verify it worked

Log in as an administrator and confirm the Cincopa integration is available in the
content-editing workflow, then insert a test video or gallery from your Cincopa
library and view the page as a visitor — the Cincopa player should render the
media.

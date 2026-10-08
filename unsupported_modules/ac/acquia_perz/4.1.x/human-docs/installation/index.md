# Installation

## Requirements

Acquia Personalization has more moving parts than most contrib modules, because
it integrates with a hosted service:

- **Drupal 9.2 through 11** (`core_version_requirement: >=9.2 <12`).
- **PHP 7.4 or 8** (`^7.4 || ^8`).
- The **Acquia Connector** module (`drupal/acquia_connector` `^4.0`), which
  supplies your Acquia subscription and credentials. Personalization reads its
  Site ID and account details from here.
- Core's **Node**, **Taxonomy**, and **Image** modules, which Drupal enables as
  dependencies.
- Several Composer libraries pulled in automatically: `acquia/perz-api-php`,
  `laminas/laminas-diactoros`, and `symfony/psr-http-message-bridge`.
- An active **Acquia Personalization subscription** on the Acquia side — without
  valid credentials the service cannot be reached.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_perz -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Acquia Connector
and the required libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_perz -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module and the push submodule together — the base module alone
does not export any content:

```bash
drush en acquia_perz acquia_perz_push -y
```

## Submodule — acquia_perz_push

`acquia_perz_push` is what actually sends your content to the Content Index
Engine: it manages the export queue, tracks changes, and provides Drush commands
for bulk re-export. If you enable only `acquia_perz` on its own, Drupal's status
report (`/admin/reports/status`) will warn that the configuration is incomplete
and no content will reach the service. Enable both.

## Provide credentials securely

The connection is authenticated through Acquia Connector's subscription details.
Store any secret values (keys, tokens) in environment variables rather than
committing them to code or configuration. With DDEV you can save them into
`.ddev/.env` (kept out of version control) and reference them from Drupal.

## Verify it worked

Visit **Reports → Status report** (`/admin/reports/status`). Acquia
Personalization runs a health check there: it reports an error if
`acquia_perz_push` is not installed, if the Site ID is missing, or if the
service cannot be reached with your current Acquia Connector credentials. A clean
status report means the connection is ready and you can start opting content in
from *Manage display*.

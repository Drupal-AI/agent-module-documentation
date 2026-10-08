# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The **Bibcite** module (`bibcite`) — Composer pulls it in for you if it is not
  already present. Imported works become Bibcite citations.
- Outbound HTTPS network access so the site can reach the ORCID API.
- If the ORCID access you use requires credentials or a token, a place to store
  that secret — see the credential note below.

## Install with Composer

From the project root:

```bash
composer require drupal/bibcite_import_orcid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Bibcite
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bibcite_import_orcid -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bibcite_import_orcid -y
```

Drupal enables Bibcite automatically as a dependency.

## Grant the import permission

The module defines its own ORCID-import permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant it to the roles that
should be able to run imports.

## Credentials (only if required)

Public ORCID record reads typically need no credentials. If your usage does
require an ORCID API client secret or token, keep it out of code and config:
store it in an environment variable with DDEV's dotenv command, for example

```bash
ddev dotenv set .ddev/.env --orcid-client-secret=<value>
ddev restart
```

The flag `--orcid-client-secret` becomes the variable `ORCID_CLIENT_SECRET`.
Never commit `.ddev/.env` to version control.

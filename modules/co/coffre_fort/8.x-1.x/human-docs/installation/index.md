# Installation

## Requirements

- **Drupal 8.9, 9, or 10** (`core_version_requirement: ^8.9 || ^9 || ^10`).
- The contrib **Token** (`token`) module — the only Drupal dependency. Composer
  pulls it in for you.
- The PHP **OpenSSL** extension (standard in almost every PHP build) for the
  encryption.
- **For the Vault or Keycloak providers only:** access to a HashiCorp Vault
  instance or a Keycloak/OpenID server, respectively.

## Install with Composer

From the project root:

```bash
composer require drupal/coffre_fort -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Token and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/coffre_fort -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en coffre_fort -y
```

## If you use the Vault or Keycloak providers

Those providers connect to an external service, and that connection has its own
secret (a Vault token, an OpenID client secret). Do not hard-code or commit such
values — store them in an environment variable and reference them from the site.
With DDEV:

```bash
ddev dotenv set .ddev/.env --coffre-fort-provider-secret=<value>
ddev restart
```

(Keep `.ddev/.env` out of version control.) A **Key** entity with the environment
provider is a good way to feed that value to the site without it landing in
configuration.

## Verify it worked

Log in as a user with the **Administer coffre fort** permission and open
**Configuration → System → Coffre Fort** (`/admin/config/system/coffre_fort`). If
the settings page loads, the module is installed. Next, create a safe and choose
a secret provider — see [Configuration](../configuration/index.md).

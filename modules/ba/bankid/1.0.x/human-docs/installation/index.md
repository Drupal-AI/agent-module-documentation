# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Key** module (`key`) — stores the BankID credentials/certificate.
- The **ExternalAuth** module (`externalauth`) — maps the BankID identity to a
  Drupal user.
- A **BankID relying-party agreement** with a bank, giving you a client
  certificate and access to BankID's API (test or production).

Key and ExternalAuth are contrib modules and are pulled in automatically when you
require this module with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/bankid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch the Key and
ExternalAuth dependencies along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bankid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bankid -y
```

Drupal will enable Key and ExternalAuth at the same time if they are not already
on.

## Handle the BankID certificate securely

The BankID client certificate and its passphrase authenticate your organisation
to BankID. They are secrets — **never** commit them to Git or place them where
they land in a configuration export or database dump. Keep the certificate on the
server filesystem outside the web root (or in a secrets store) and keep any
passphrase in the environment.

With DDEV, store a passphrase (or other credential value) as an environment
variable and restart so the container loads it:

```bash
ddev dotenv set .ddev/.env --bankid-cert-passphrase=<value>
ddev restart
```

`.ddev/.env` must stay out of version control. Confirm the variable reached the
container **without printing its value**:

```bash
ddev exec 'test -n "$BANKID_CERT_PASSPHRASE" && echo set'
```

Then expose the credential to the module through a **Key** entity (env or file
provider) — see [Configuration](../configuration/index.md).

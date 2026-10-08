# Installation

## Requirements

- **Drupal core `^8 || ^9 || ^10 || ^11`**.
- A **BrightEdge account** with IXF enabled, and the account/connector details it
  gives you — without these the module has nothing to connect to.

There are no additional module dependencies. The module wraps the BrightEdge IXF
SDK.

## Install with Composer

From the project root:

```bash
composer require drupal/be_ixf_drupal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/be_ixf_drupal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en be_ixf_drupal -y
```

## Store the account credentials securely

Do not commit BrightEdge account credentials. Store the secret value in an
environment variable and reference it from Drupal. With DDEV:

```bash
ddev dotenv set .ddev/.env --brightedge-api-key=<value>
ddev restart
```

Keep `.ddev/.env` out of version control. Once enabled, configure the connection
at **Configuration → Web services → BrightEdge** — see
[Configuration](../configuration/index.md).

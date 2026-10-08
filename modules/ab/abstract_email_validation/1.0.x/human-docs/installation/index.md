# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **Abstract API key** for the email-validation service.
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/abstract_email_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/abstract_email_validation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en abstract_email_validation -y
```

## Store your Abstract API key securely

The API key is a credential — keep it in an environment variable rather than in
exported configuration. With DDEV:

```bash
ddev dotenv set .ddev/.env --abstract-api-key=<value>
ddev restart
```

The flag `--abstract-api-key` becomes the environment variable
`ABSTRACT_API_KEY`, which the site can read at runtime. Keep `.ddev/.env` out of
version control. After enabling the module, provide the key and point the
validator at the email fields you want checked.

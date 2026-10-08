# Installation

## Requirements

- **Drupal 9.1+, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **zxcvbn‑php** library (`bjeavons/zxcvbn-php`) — this is a PHP (Composer) library,
  not a JavaScript one, so strength checking happens server‑side at validation time.
  Composer installs it for you when you require the module (see below), so it lands in
  `vendor/` automatically.

There are no other module dependencies.

## Install with Composer

Install the module with Composer so that the required `bjeavons/zxcvbn-php` library is
pulled in at the same time. From the project root:

```bash
composer require drupal/better_passwords -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the zxcvbn library and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_passwords -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

> **Important:** install this module with Composer, not by downloading the module
> archive and unpacking it into your site. A manual copy will not fetch the zxcvbn
> library, and strength checking will not work without it.

## Enable the module

```bash
drush en better_passwords -y
```

The default policy takes effect immediately: a minimum length of 8 characters, a
minimum strength score of 3 ("Strong"), and optional auto‑generation of admin‑created
passwords. Adjust these on the settings page — see
[Configuration](../configuration/index.md).

## Verify it worked

Log in as an administrator and visit **Configuration → People → Passwords**
(`/admin/config/people/passwords`). You should see the three policy fields. On update
from an older release, the module automatically grants the **Administer Better
Passwords** permission to any role that already holds **Administer site configuration**.

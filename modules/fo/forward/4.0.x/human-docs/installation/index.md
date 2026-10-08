# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field** module (`field`), which Drupal enables as a dependency.
- A working outgoing mail setup on your site. Forward sends through Drupal's mail
  manager, so if you have SMTP or another transport module enabled it is used
  automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/forward -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/forward -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forward -y
```

There are no submodules. After enabling, grant the **access forward** permission
and add the Forward link or form to an entity display — see
[Configuration](../configuration/index.md).

> **Spam tip.** Because "email a friend" is usually offered to anonymous visitors,
> pair it with a CAPTCHA or Honeypot module on public sites. Forward's own flood
> control and recipient cap limit abuse, but a challenge stops bots reaching the
> form.

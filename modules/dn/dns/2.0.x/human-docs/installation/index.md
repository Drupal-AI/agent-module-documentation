# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
  Drupal 12 compatibility is tracked but not yet guaranteed.
- Core's **Options** (`options`) and **Views** (`views`) modules — both ship with
  Drupal core and are enabled automatically as dependencies.
- The contributed **Field IP Address** module (`field_ipaddress`) — this is a
  separate project that Composer will pull in for you (see below).

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dns -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
`field_ipaddress` module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dns -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dns -y
```

Enabling DNS also enables its dependencies (`options`, `views`, and
`field_ipaddress`) if they are not already on.

## Verify it worked

Log in as an administrator and visit **People → Permissions** — you should see the
DNS permissions (such as *administer DNS* and *create zones*). Grant the ones you
need to the appropriate roles, then create your first **zone** and add a
**record** to it. If the record saves after passing validation, the module is
working.

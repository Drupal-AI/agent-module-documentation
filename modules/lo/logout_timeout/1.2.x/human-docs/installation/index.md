# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), enabled on every standard Drupal site.
- End users must have **JavaScript enabled** — the inactivity timing and the alert
  pop‑up run in the browser. The module is recommended only for sites that require
  JavaScript.

Optional integrations (only needed if you use them):

- **simpleSAMLphp Authentication** — to log out SAML sessions cleanly.
- **Hook Event Dispatcher** (its User Event Dispatcher submodule) — to fire a
  logout event, used together with simpleSAMLphp Authentication.

## Install with Composer

From the project root:

```bash
composer require drupal/logout_timeout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/logout_timeout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logout_timeout -y
```

**Important:** the module installs with its features **disabled**. Nothing happens
until you open the configuration form and turn it on — see
[Configuration](../configuration/index.md).

## Verify it worked

After enabling the feature in the settings form, log in and leave the page idle
for slightly longer than the timeout you set. The warning pop‑up should appear,
and if you don't respond, you should be logged out. Open a second tab first to
confirm both tabs log out together.

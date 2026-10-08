# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`) — enabled in every standard Drupal install.
- The **`stymiee/email-validator`** PHP library (`^1.1.4`) — this does the actual
  email checking. Because it is a Composer library rather than a Drupal module,
  you must install the module *with Composer* (not by dropping files in) so the
  library is fetched too.
- **Optional:** the contributed **Webform** module (`drupal/webform`) if you want
  to apply the same rules to Webform email fields.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_email_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`stymiee/email-validator` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_email_validation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_email_validation -y
```

There are no submodules. After enabling, open the settings form to switch on the
rules you want — nothing is validated until you do. See
[Configuration](../configuration/index.md).

> **Tip:** after you change *when* validation runs (new accounts vs. email
> changes), clear caches with `drush cr` so the account‑field checks are
> re‑applied.

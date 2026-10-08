# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11.0`).
- Core's **Link** module (`link`), which Drupal enables automatically as a
  dependency.
- The **`campaignmonitor/createsend-php`** PHP library (version `^7.0`). This is
  the official Campaign Monitor SDK and is pulled in automatically when you
  install the module with Composer (see below).
- A **Campaign Monitor account** with an API key and Client ID — you will need
  these to connect the site.

## Install with Composer

From the project root:

```bash
composer require drupal/campaignmonitor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`campaignmonitor/createsend-php` SDK and update any shared dependencies as
needed. Because the SDK is a real Composer requirement, installing the module by
hand (copying files) will not work — use Composer so the library is present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/campaignmonitor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en campaignmonitor -y
```

## Submodules — enable only what you need

Campaign Monitor ships two optional submodules. Enable them individually with
`drush en` once the base module is installed:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Campaign Monitor Registration** | `campaignmonitor_registration` | Newsletter opt-in checkboxes on the user registration form. Adds an `access campaignmonitor registration` permission. |
| **Campaign Monitor User** | `campaignmonitor_user` | A subscription-management tab on each user's profile (`/user/{user}/campaignmonitor`) so members can manage their own newsletters. Adds an `access campaign monitor user` permission. |

For example:

```bash
drush en campaignmonitor_user -y
```

## Next step

Once enabled, continue to [Configuration](../configuration/index.md) to connect
your Campaign Monitor account and place a subscribe block.

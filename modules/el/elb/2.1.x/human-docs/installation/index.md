# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Link** module (`link`) — the only dependency, since the module validates
  link fields. Drupal enables it automatically as a dependency.
- Optionally, the [Linkit](https://www.drupal.org/project/linkit) module — if
  present, the blocklist is also enforced in the Linkit CKEditor link dialog.

There are no additional Composer libraries or PHP extensions required.

## Install with Composer

From the project root:

```bash
composer require drupal/elb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elb -y
```

This also enables core's Link module if it isn't already on.

## Verify it worked

Go to **Configuration → Content authoring → External Link Blocklist**
(`/admin/config/content/elb`) and confirm the settings form loads with **Blocklist**
and **Exceptions** fields. Then check that the **External link blocklist** widget is
available on a Link field's **Manage form display**. See
[Configuration](../configuration/index.md) to set it up.

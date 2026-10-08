# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **DubBot account** and an **embed key** generated within it — the module is an
  integration with the hosted DubBot service and shows nothing without a valid key.
- Outbound network access from your Drupal server to DubBot's API
  (`https://api.dubbot.com` by default), so the module can fetch reports.

There are no other Drupal module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dubbot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dubbot -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dubbot -y
```

## Optional submodule — DubBot Toolbar

To add a toolbar shortcut that links straight to the current page's report, enable
the bundled submodule:

```bash
drush en dubbot_toolbar -y
```

It requires the base DubBot module, which is already present once you've installed
it above.

## Set permissions

DubBot has a rich permission set (see [Configuration](../configuration/index.md) for
the full list). At minimum, at **People → Permissions**
(`/admin/people/permissions`) grant:

- **Administer dubbot configuration** — to the administrator who will enter the
  embed key.
- **Access dubbot report** — to any role that should see the Overview page and
  report links.

Then optionally grant the per‑tab permissions (accessibility, spellcheck, SEO,
links, best practices, governance) to tailor what each role sees.

## Next steps

Head to [Configuration](../configuration/index.md) to paste your embed key and
connect the site to DubBot. Reports only appear once a valid key is saved.

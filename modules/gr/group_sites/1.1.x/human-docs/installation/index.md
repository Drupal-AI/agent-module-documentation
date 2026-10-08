# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`group`), enabled
  automatically as a dependency.
- A **context provider** that returns a Group context. The recommended one is
  **[Group Context: Domain](https://www.drupal.org/project/group_context_domain)**
  (`group_context_domain`), which derives the active Group from the current domain.
  Group Sites needs one of these to know which Group is active.

Optionally, it can be coupled with the
[Domain](https://www.drupal.org/project/domain) module (via Group Context: Domain)
for full entity and query access per domain.

## Install with Composer

From the project root:

```bash
composer require drupal/group_sites -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add your context provider too, for example:

```bash
composer require drupal/group_context_domain -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_sites -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_sites -y
```

Enable your context provider as well, e.g. `drush en group_context_domain -y`.

## Verify it worked

Before you switch on scoping, turn on **admin mode** from the toolbar so you can
build the site freely. Then set up your context provider (for example, map a domain
to a Group), and visit **Administration → Groups → Sites → Settings**
(`/admin/group/sites/settings`) to choose your access policies. Turn admin mode off
and confirm that each domain (or context) now shows only its own Group's content.

See [Configuration](../configuration/index.md) for the settings, admin mode, and
policy choices in detail.

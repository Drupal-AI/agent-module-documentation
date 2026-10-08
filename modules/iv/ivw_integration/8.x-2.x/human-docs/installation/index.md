# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`). The 2.x branch targets
  Drupal 8.8 and up; for older Drupal use the 1.x branch.
- The **Token** module (`token`).
- An **IVW / INFOnline** account and the offering identifiers/codes they issue for
  your site.

## Install with Composer

From the project root:

```bash
composer require drupal/ivw_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ivw_integration -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ivw_integration -y
```

Drupal enables the Token dependency at the same time if it is not already on.

## Verify it worked

After enabling, grant the module's administer permission to your role under **People
→ Permissions**, then open the IVW settings form (see
[Configuration](../configuration/index.md)) and enter your identifiers. The tracking
takes effect on pages once configured — and once you have satisfied your consent
requirements.

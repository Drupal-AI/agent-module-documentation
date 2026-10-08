# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Form Decorator** module (`form_decorator`) and core **Navigation**
  (`navigation`) — hard dependencies.
- The **Sites** ecosystem — the non‑core `sites` / `sites_preview` stack. This
  module only makes sense on a site already running that platform.

There are no third‑party PHP library requirements. This is an early release
(1.0.0‑alpha1) — pin your version and test carefully.

## Install with Composer

From the project root:

```bash
composer require drupal/sites_content_overrides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Form Decorator and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sites_content_overrides -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sites_content_overrides -y
```

This also enables Form Decorator and Navigation as dependencies.

## Submodules — enable only what you need

Sites overrides ships four optional submodules that extend overrides into other
subsystems. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Behaviors** | `sites_content_overrides_behaviors` | Per‑site overrides for paragraph Behaviors. |
| **Content Moderation** | `sites_content_overrides_content_moderation` | Integration with Content Moderation for overridden content. |
| **Layout Builder** | `sites_content_overrides_layout_builder` | Per‑site overrides for Layout Builder layouts. |
| **Revisions UI** | `sites_content_overrides_revisions_ui` | A per‑site revisions user interface. |

For example, to add Layout Builder support:

```bash
drush en sites_content_overrides_layout_builder -y
```

Each submodule requires the base module, which is already present once you have
installed it above.

## Verify it worked

Visit `/admin/config/sites/content-overrides` as a user with the
`administer site configuration` permission — the settings form should load, ready
for you to choose which entity types and bundles are overrideable. See
[Configuration](../configuration/index.md).

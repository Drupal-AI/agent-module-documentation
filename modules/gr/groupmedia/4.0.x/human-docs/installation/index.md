# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module (`media`) enabled.
- The contrib **Group** module, version 3 (`drupal/group:^3.0`). Composer pulls
  this in for you.

Media and Group are both enabled automatically as dependencies when you turn on
Group Media, but you must have set up at least one media type and one group type
for the integration to be useful.

## Install with Composer

From the project root:

```bash
composer require drupal/groupmedia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Group module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/groupmedia -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en groupmedia -y
```

Enabling the module does not, on its own, make any media into group content —
you next need to install the Group media relation plugin on a group type. See
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

Group Media ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Group Media Paragraphs** | `groupmedia_paragraphs` | Media‑finder plugins that detect media referenced inside Paragraphs, so tracking also attaches media embedded via Paragraphs. |
| **Group Media VBO** | `groupmedia_vbo` | Views Bulk Operations versions of the assign/remove actions, letting you choose the target group at action time. |

For example, to track media inside Paragraphs:

```bash
drush en groupmedia_paragraphs -y
```

Each submodule requires the base Group Media module, which is already present
once you have installed it above.

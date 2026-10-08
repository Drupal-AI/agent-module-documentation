# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module and core's **Path Alias** module.
- The contrib **Redirect** module (`redirect/redirect`) — a required dependency,
  used by the redirect‑detection logic.
- **Drush 13** to run the module's commands.
- **Linkit** is recommended (not required) for the entity‑link conversions.

## Install with Composer

From the project root:

```bash
composer require drupal/link_magician -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Redirect
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_magician -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_magician -y
```

## Submodules

Enable these only if you need support for the corresponding content structures:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Paragraphs support** | `link_magician_paragraphs` | Extends the tidying process to links held inside Paragraphs content. |
| **Layout Builder support** | `link_magician_layout_builder` | Extends the tidying process to links inside Layout Builder content. |

```bash
drush pm:enable link_magician_paragraphs -y
drush pm:enable link_magician_layout_builder -y
```

## Verify it worked

After enabling, visit **Configuration → System → Link Magician**
(`/admin/config/system/link_magician`) and confirm the settings form loads. Then
check the Drush commands are registered:

```bash
drush link_magician:tidy --help
```

Set the Base URI and Additional Hosts (see [Configuration](../configuration/index.md))
before running a real tidy.

# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core only for the base module — no third‑party Composer or PHP library
  requirements.

Custom Elements is the core of the **Lupus Decoupled Drupal** stack. On its own it
produces the custom‑element output; to switch the site's main content renderer to
serve custom‑element markup or JSON responses, pair it with the separate **Lupus
Custom Elements Renderer** module. The easiest way to get a full decoupled setup is
the Lupus Decoupled Drupal distribution.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_elements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_elements -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_elements -y
```

## Submodules — enable only what you need

Custom Elements ships three optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Custom Elements UI** | `custom_elements_ui` | A UI to configure custom‑element output per entity **view mode** (3.x only). This is what you enable to map fields to elements from the admin interface rather than in code. |
| **Custom Elements Thunder** | `custom_elements_thunder` | An example integration/setup for **Thunder** paragraphs, reflecting the distribution this approach came from. |
| **Custom Elements Extra Formatters** | `custom_elements_extra_formatters` | Additional field formatters for custom‑element output. |

For example, to add the per‑view‑mode configuration UI:

```bash
drush en custom_elements_ui -y
```

Each submodule requires the base Custom Elements module, which is already present
once you have installed it above.

## Verify it worked

After enabling, visit **Configuration → System → Custom Elements**
(`/admin/config/system/custom-elements`) to confirm the settings form loads. If you
enabled **Custom Elements UI**, you'll also be able to configure custom‑element
output on an entity's view‑mode display. See
[Configuration](../configuration/index.md) for details.

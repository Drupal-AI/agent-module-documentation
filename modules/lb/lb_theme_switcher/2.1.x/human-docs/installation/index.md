# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Layout Builder** — the module effectively requires it (it uses Layout
  Builder's override storage), although this is not declared in its `.info.yml`.
- An **LB-capable front-end theme** to switch to, such as **Open Y Carnation**.
- The module is built for the **Open Y / YMCA Website Services** stack.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_theme_switcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_theme_switcher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_theme_switcher -y
```

Also make sure the LB-capable theme you plan to switch to is installed and
enabled (**Appearance**), because the settings form only lets you choose among
installed, enabled themes.

## Verify it worked

Go to **Configuration → Open Y → Settings → Theme Switcher**
(`/admin/config/openy/settings/theme-switcher`), pick your LB theme, and save.
Then view a Layout Builder page as a visitor — it should render in the LB theme
while other pages keep your default theme. See
[Configuration](../configuration/index.md) for the settings and the Drush reset
command.

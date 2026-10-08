# Installation

## Requirements

Generic Colors builds on Drupal's AI stack and needs a color‑analysis library:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** (`ai`), **AI Agents** (`ai_agents`), and **Tool** (`tool`) modules.
  Composer pulls these in as dependencies.
- The **`ksubileau/color-thief-php`** Composer package, which performs the actual
  color extraction. This comes along when you require the module with the `-W`
  flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/generic_colors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI stack and
the `ksubileau/color-thief-php` color library at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/generic_colors -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en generic_colors -y
```

Drupal will enable `ai`, `ai_agents`, and `tool` alongside it if they aren't
already on.

## Verify it worked

Open the **AI Agents explorer** page and look for *Generic Colors* in the list of
available tools. Enter a valid file ID or media ID and run it — you should get
back a dominant color and a ranked list of colors with percentages. If the tool
appears and returns results, the installation is complete.

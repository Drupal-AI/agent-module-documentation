# Installation

## Requirements

- **Drupal 11.3+ or 12** (`core_version_requirement: ^11.3 || ^12`).
- **PHP 8.3+** (`^8.3`).
- **Drush 13+** — required to use the child-theme generation and favicon commands.
- **Emulsify** theme (suggested) — install `drupal/emulsify` for child-theme
  generation; **version 7.x** is required for the favicon deployment and repair
  workflows. The Twig helpers, switch/case tag, and namespace support work without
  it.

If you are maintaining an Emulsify **6.x** project, use the **1.x** release line of
Emulsify Tools instead; the 2.x line documented here pairs with Emulsify 7.x.

## Install with Composer

From the project root:

```bash
composer require drupal/emulsify_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Emulsify Tools is typically installed alongside the Emulsify
theme itself:

```bash
composer require drupal/emulsify -W
composer require drupal/emulsify_tools -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/emulsify_tools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emulsify_tools -y
```

## Drush commands (Drush 13+)

**Child-theme generation**

```bash
drush emulsify_tools:bake my_theme
```

Aliases: `drush emulsify my_theme` and `drush emulsify_tools:generate-theme "My Theme"`.
You can pass `--name="My Theme"` and `--description="Project theme"` to set the
generated theme's display name and description. A human-readable label is
transliterated and validated into a safe machine name, and the theme is created under
`themes/custom/<machineName>`.

**Favicon deployment** (Emulsify 7.x themes)

| Command | What it does |
|---------|--------------|
| `drush emulsify_tools:favicon-generate my_theme` | Generate or refresh a favicon package from the theme's saved Emulsify settings. |
| `drush emulsify_tools:favicon-status my_theme` | Report package state, dependency availability, and portable SVG source status. Supports `--format=json`. |
| `drush emulsify_tools:favicon-reset my_theme` | Remove generated package state and restore default favicon behavior. |
| `drush emulsify_tools:repair-favicon-config my_theme` | Backfill missing favicon config/schema in older generated child themes. |

The generate, status, and reset commands accept `--all` to act on every installed
Emulsify theme at once. After upgrading, run `drush updatedb` so new favicon
theme-setting keys are backfilled.

## Verify it worked

After enabling, generate a child theme with `drush emulsify_tools:bake my_theme` and
confirm it appears under `themes/custom/my_theme` and on the **Appearance** page. To
check the Twig helpers, add `{{ bem('title') }}` to a template in your theme and
confirm it renders `class="title"`. If you use Emulsify 7.x favicons, run
`drush emulsify_tools:favicon-status my_theme` to confirm the command reports package
status.

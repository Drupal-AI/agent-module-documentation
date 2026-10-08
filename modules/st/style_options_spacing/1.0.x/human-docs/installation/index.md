# Installation

## Requirements

Style Options: Spacing is a small extension with a single dependency:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Style Options** module (`style_options`) — the framework this module
  extends. Drupal enables it automatically as a dependency.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/style_options_spacing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Style Options and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/style_options_spacing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en style_options_spacing -y
```

Style Options is enabled at the same time if it is not already on.

## Verify it worked

Once enabled, reference the spacing options from your Style Options YAML and
confirm the margin/padding controls appear on the component or layout style form
where you added them.

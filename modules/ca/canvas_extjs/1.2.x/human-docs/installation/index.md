# Installation

## Requirements

- **Drupal 11.2+** (`core_version_requirement: ^11.2`).
- The **Drupal Canvas** module (`canvas`) — required; this module adds a component
  source to Canvas and cannot work without it.
- **Optional:** the **Custom Elements** module, if you want to render components
  through its component-preview system (which brings Nuxt support), and **Lupus
  Decoupled** for a fully decoupled frontend.

There are no additional PHP or third-party Composer library requirements declared
by the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_extjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Drupal Canvas is not already present, require it too
(`composer require drupal/canvas -W`). Because this module is only declared
compatible with the current Canvas minor version, let Composer resolve a matching
pair rather than pinning versions by hand.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/canvas_extjs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_extjs -y
```

## Verify it worked

Once enabled, the external-JavaScript component source becomes available inside the
Drupal Canvas editor when you create components. Before wiring up any external
component, make sure you have a change process and a Content Security Policy in
place for the origin its JavaScript loads from — see the security note on the
[overview page](../index.md).

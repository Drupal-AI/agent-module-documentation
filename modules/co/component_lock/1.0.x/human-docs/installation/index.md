# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`).
- The **Form Decorator** module (`form_decorator`) — used to modify the component
  configuration forms.

Note this release is an early **alpha** (1.0.0-alpha1) and is not covered by
Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/component_lock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Form Decorator
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/component_lock -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en component_lock -y
```

This enables Layout Builder and Form Decorator as dependencies if they are not
already on.

## Verify it worked

In Layout Builder, configure a placed component and use the locking options to
hide all or some of its settings. Then view the same layout as a non-administrator
(a user without **Administer blocks**) and confirm the locked settings are hidden
for them while remaining editable for administrators.

# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`). Note that the module it wraps,
  Layout Builder +, targets Drupal 11 — this wrapper is intended for demo builds
  (such as Simplytest.me) where the stack resolves.
- **Layout Builder +** (`lb_plus`) and **Field Sample Value**
  (`field_sample_value`) — both pulled in automatically as dependencies.

The wrapper itself has no third-party libraries; its footprint is entirely that
of the modules it depends on.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_plus_demo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Layout Builder +
and Field Sample Value.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_plus_demo -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_plus_demo -y
```

Enabling it enables Layout Builder + and Field Sample Value in one step. To reset
a demo, simply reinstall this single module.

## Verify it worked

Check that **Layout Builder +** and **Field Sample Value** are now enabled
(`drush pml | grep -E 'lb_plus|field_sample_value'`), then open a Layout
Builder–enabled entity and confirm you get the Layout Builder + editing
experience with sample field values to work from.

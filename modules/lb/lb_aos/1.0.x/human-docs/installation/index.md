# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AOS** module (`aos`), which supplies the Animate On Scroll library
  integration.
- Core's **Layout Builder** module (`layout_builder`), enabled and in use.

There are no additional third‑party PHP library requirements — the AOS library comes
in via the `aos` dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_aos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `aos`
dependency and any shared dependencies.

> **Heads‑up on the package name.** The AOS project's Composer package is
> `drupal/aos-aos` (not `drupal/aos`) — a pattern drupal.org uses when a project's
> module name is namespaced differently from the project. You will see that name in
> Composer output and in your lock file; it is expected.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lb_aos -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_aos -y
```

Enabling `lb_aos` will also require the `aos` module to be enabled; Drupal handles
this as a dependency.

## Verify it worked

Open the Layout Builder editor on an entity, add or configure a block, and confirm
the block's configuration form now offers an **animation** option. Save the layout
and view the page — the block should animate into view as you scroll. Before going
live, check that `prefers-reduced-motion` is respected and that nothing essential is
hidden until the animation runs.

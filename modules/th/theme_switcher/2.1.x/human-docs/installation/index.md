# Installation

## Requirements

Theme Switcher Rules has no third-party libraries and no module dependencies beyond
Drupal core. It needs:

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's condition and theme systems, which are always present.

The condition plugins you'll build rules from come from core (paths, content types,
user roles, language) and from any contrib module that provides its own conditions
(domain, group, workflow state, and so on) — those are optional and only expand the
choices available on the rule form.

## Install with Composer

From the project root:

```bash
composer require drupal/theme_switcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/theme_switcher -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en theme_switcher -y
```

There are no submodules. Once enabled, the module adds no rules of its own — nothing
changes on your site until you create at least one rule. Head to
[Configuration](../configuration/index.md) to build your first one.

## Grant access (optional)

By default only administrators can manage rules. The module ships five permissions
so you can delegate. To let an `editor` role manage everything:

```bash
drush role:perm:add editor 'administer theme switcher rules'
```

Or give a read-only auditor role just the view permission:

```bash
drush role:perm:add auditor 'view theme switcher rules'
```

The full list of permissions is described in
[Configuration](../configuration/index.md#permissions).

# Installation

## Requirements

Tarte au citron AddToAny needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Tarte au citron** module (`tarte_au_citron`) — the consent manager it
  plugs into.
- The **AddToAny Share Buttons** module (`addtoany`) — the sharing buttons it
  gates.

Composer resolves these dependencies for you. There are no third-party Composer or
PHP library requirements, and the module is covered by Drupal's security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/tarte_au_citron_addtoany -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Tarte au citron and
AddToAny as needed. (The Composer package name, `drupal/tarte_au_citron_addtoany`,
matches the module's machine name, `tarte_au_citron_addtoany`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tarte_au_citron_addtoany -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tarte_au_citron_addtoany -y
```

Once enabled, the module works immediately — AddToAny's sharing script is held
back until the visitor grants consent through Tarte au citron. There is nothing to
configure on this module itself.

## Verify it worked

Load a page that shows the AddToAny buttons as an anonymous visitor. Before you
accept the relevant service in the Tarte au citron consent banner, the sharing
buttons (and their third-party script) should not load; after you accept, they
should appear.

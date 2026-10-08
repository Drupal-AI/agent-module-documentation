# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No other module dependencies and no third‑party Composer packages.

Two modules are *suggested* (optional, not required):

- **Metatag** (`drupal/metatag`) — some networks read Open Graph tags to build a
  rich share preview; add it if you want those previews.
- **Twig Tweak** (`drupal/twig_tweak`) — lets you print the buttons block
  directly in a Twig template with `drupal_block()`.

## Install with Composer

From the project root:

```bash
composer require drupal/better_social_sharing_buttons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_social_sharing_buttons -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_social_sharing_buttons -y
```

Once enabled, place the block or expose the field as described in
[Configuration](../configuration/index.md).

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Per Node** | `better_social_sharing_buttons_per_node` | Lets editors turn the sharing buttons on or off on individual nodes. |

Enable it with:

```bash
drush en better_social_sharing_buttons_per_node -y
```

It requires the base module, which is already present once you have installed it
above.

# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No contributed‑module dependencies — TCA only needs Drupal core.
- For token generation to be secure, your site should have a proper **private
  key** and **hash salt** configured (a normal Drupal install already has
  these). TCA hashes them into every token it creates.

## Install with Composer

From the project root:

```bash
composer require drupal/tca -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tca -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en tca -y
```

On its own the base module protects nothing — it has no built‑in support for any
entity type. You must also enable at least one submodule to tell TCA which entity
type to guard.

## Submodules — choose the entity type to protect

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **TCA Node** | `tca_node` | Adds token protection to **nodes** (content). It also rewrites search and Views queries so that token‑protected nodes don't leak into listings for visitors who lack the bypass permission. |
| **TCA Commerce Product** | `tca_commerce_product` | Adds token protection to **Commerce products** (requires Drupal Commerce). |

Enable whichever you need, for example:

```bash
drush en tca_node -y
```

Each submodule requires the base `tca` module, which is already present once you
have installed it above. Enabling a submodule makes its entity type "affected" —
that adds the three tracking fields (`tca_active`, `tca_public`, `tca_token`) to
the entity, puts the **TCA** fieldset on its edit form, and creates the two
per‑entity‑type permissions described in
[Configuration](../configuration/index.md).

## Verify it worked

Edit a piece of content of the type you enabled. You should see a **TCA**
fieldset on the form. Tick **TCA Active**, save, then try opening the item's URL
without the `?tca=<token>` query — you should be denied. Add the token back and
the page loads.

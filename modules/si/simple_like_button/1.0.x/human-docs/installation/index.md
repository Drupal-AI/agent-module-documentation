# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A PHP version supported by your Drupal core.
- **Authenticated users** — the button is only rendered for logged‑in users; it is
  intentionally hidden from anonymous visitors.
- No dependent modules, no PHP libraries, and no third‑party Composer packages.

Note two current limitations before you rely on it: the module is **not compatible
with Views**, and the button is **not shown to anonymous users**.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_like_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_like_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_like_button -y
```

You can also enable it through the UI at **Administration → Extend**
(`/admin/modules`).

## Place the block

The like button only appears once you place its block. Go to **Administration →
Structure → Block layout** (`/admin/structure/block`) and place **Simple Like
Button** in a region that shows on your entity pages — see
[How to use it](../index.md#how-to-use-it) for the full walkthrough.

## Verify it worked

Log in as an authenticated (non‑anonymous) user and visit a page that shows an entity,
such as a node's canonical page. With the block placed in a visible region, you should
see the like button and its count. Click it — the count and the Like/Liked label
should update without a full page reload.

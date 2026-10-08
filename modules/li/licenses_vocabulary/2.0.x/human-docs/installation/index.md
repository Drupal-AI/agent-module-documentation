# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core **Taxonomy** (`taxonomy`) — this is the only dependency, and Drupal enables
  it automatically (it is on by default on a standard site).
- No third‑party PHP libraries are required.

> **Note:** the release documented here is **2.0.1‑beta1**, and the project is
> *minimally maintained* and **not** covered by Drupal's security advisory policy.
> Review it before using it on a high‑exposure production site.

## Install with Composer

From the project root:

```bash
composer require drupal/licenses_vocabulary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/licenses_vocabulary -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en licenses_vocabulary -y
```

Enabling the module creates the licences vocabulary and imports a default set —
the basic Creative Commons 4.0 licences and CC0. There are no submodules.

## Verify it worked

1. Confirm **Licenses vocabulary** is enabled on **Extend** (`/admin/modules`).
2. Under **Structure → Taxonomy** (`/admin/structure/taxonomy`), confirm the
   licences vocabulary exists and contains the imported Creative Commons and CC0
   terms.

Next, add more licences or wire the vocabulary into your content in
[Configuration](../configuration/index.md).

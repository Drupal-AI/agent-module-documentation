# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`), for placing the token block.
- The **Key** module (`key`) — stores the signing key material.
- The **JSON Web Token Authentication (JWT)** module (`jwt`) — signs the tokens.
- The **GMP** PHP extension, which the JWT signing relies on.

## Install with Composer

From the project root:

```bash
composer require drupal/jwt_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key and JWT
modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jwt_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. DDEV's web image already
> includes the GMP extension.

## Enable the module

```bash
drush en jwt_block -y
```

Or enable **JWT Block** on the **Extend** page (`/admin/modules`). The Key and JWT
modules are enabled as dependencies.

## Verify it worked

First configure the JWT module with a signing key (see the JWT module's
documentation). Then go to **Structure → Block layout**
(`/admin/structure/block`) and click *Place block* — the **JWT Block** should
appear in the list of available blocks. Place it in a region and confirm it renders
a token on the front end.

> **Heads up:** This release is an alpha and is not covered by Drupal's security
> advisory policy. Review it before use, especially since it emits per‑user
> credentials.

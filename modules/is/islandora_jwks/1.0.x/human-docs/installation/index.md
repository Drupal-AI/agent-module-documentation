# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **JWT** module (`jwt`).
- Intended for use with the **Islandora** module (`islandora`).
- The JWT **public key** available at
  `/var/run/s6/container_environment/JWT_PUBLIC_KEY`. If you run your Islandora site
  with **isle-buildkit**, this is set up for you automatically; otherwise make the
  public key available at that path.

## Install with Composer

From the project root:

```bash
composer require drupal/islandora_jwks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the JWT module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/islandora_jwks -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en islandora_jwks -y
```

Drupal enables the JWT dependency at the same time if it is not already on.

## Verify it worked

Make sure the JWT public key is available at the path above, then visit
**`/oauth/discovery/keys`** on your site. You should get back a JSON Web Key Set
(JWKS) document containing your public verification key(s). If the endpoint is empty
or errors, check that the `JWT_PUBLIC_KEY` file is present and readable by the web
server.

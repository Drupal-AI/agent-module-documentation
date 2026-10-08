# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **External Authentication** module (`externalauth`) — required; it maps the
  remote identity to a local Drupal account.
- **The PHP `gmp` extension.** This is the installation gotcha worth knowing *before*
  you plan the deployment: the 2.3.0 dependency chain pulls in `sop/jwx` →
  `sop/crypto-types`, which needs the `gmp` extension. A stock PHP image often lacks
  it, and the failure shows up at **`composer require` time** as
  *"ext‑gmp is missing from your system"* — a container/image problem, not a Drupal
  one.

## Install with Composer

From the project root:

```bash
composer require drupal/oidc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in External Authentication.

### Adding the `gmp` extension

If Composer complains that `ext-gmp` is missing, add it to your PHP environment. In
DDEV:

```bash
ddev config --webimage-extra-packages='php${DDEV_PHP_VERSION}-gmp'
ddev restart
```

Then run the `composer require` again.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oidc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oidc -y
```

This also enables External Authentication if it isn't already on.

## Verify it worked

Confirm you can reach the OIDC realm administration in the admin UI (you'll need the
**Administer OIDC** permission). Once you've configured a realm (see
[Configuration](../configuration/index.md)), a login route becomes available at
`/oidc/login/{realm}` — visiting it should hand you off to your identity provider.

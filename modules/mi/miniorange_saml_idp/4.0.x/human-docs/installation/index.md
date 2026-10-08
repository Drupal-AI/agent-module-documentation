# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- No hard module dependencies and no third-party PHP libraries declared.
- You'll need details from each **Service Provider** you intend to connect (its
  entity ID and ACS URL), and the SP will need your Drupal IdP's metadata in
  return.

## Install with Composer

From the project root:

```bash
composer require drupal/miniorange_saml_idp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/miniorange_saml_idp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en miniorange_saml_idp -y
```

## Verify it worked

Log in as an administrator and open the module's **IdP Setup** page (route
`miniorange_saml_idp.idp_setup`, under the miniOrange section of the admin menu).
You should see Drupal's IdP metadata and the screens for registering Service
Providers. Next, follow [Configuration](../configuration/index.md) to register your
first SP and set up attribute release and signing.

# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 | ^11`).
- Dependent modules, all enabled alongside it:
  - **Language** (`language`)
  - **OpenID Connect** (`openid_connect`) — the module disables core login in
    favour of OIDC
  - **SMTP** (`smtp`) — for notification email
  - **Field Group** (`field_group`)
  - **SODa SCS manager theme** (`soda_scs_manager_theme`) — the companion theme,
    which is required
- External services that the module orchestrates and must be able to reach:
  a **Portainer/Docker** endpoint, a **Keycloak** realm, a **Nextcloud** instance,
  and an **OpenGDB triplestore**. You will need endpoints and credentials for each
  (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/soda_scs_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pull in the required modules and theme.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/soda_scs_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en soda_scs_manager -y
```

Make sure the required companion theme (`soda_scs_manager_theme`) and the
dependent modules are enabled too — Composer and Drush will resolve them as
dependencies.

## Verify it worked

Go to **Configuration → SODa SCS manager → Settings**
(`/admin/config/soda-scs-manager/settings`) and confirm the settings form opens.
Nothing can be provisioned until you configure the external service endpoints and
credentials there, and grant the appropriate permissions — see
[Configuration](../configuration/index.md).

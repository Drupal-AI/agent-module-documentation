# Installation

## Requirements

Google API PHP Client needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 5.4 or newer** (`php: >=5.4.0`) — any supported modern Drupal already
  exceeds this.
- Core's **Options** (`options`) module, enabled automatically as a dependency.
- The official Google client libraries, declared as Composer requirements and pulled
  in automatically:
  - `google/apiclient` (`~2`)
  - `google/apiclient-services` (`~0.200`)

`google/apiclient-services` is a very large package (it contains every Google
service definition). Installing with Composer, as below, handles it for you.

## Install with Composer

From the project root:

```bash
composer require drupal/google_api_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this is what brings in the `google/apiclient` and
`google/apiclient-services` libraries.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_api_client -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_api_client -y
```

## Grant access

The module defines a single permission, **administer google api settings** (marked
*restrict access*). Grant it on **People → Permissions**
(`/admin/people/permissions`) to the administrators who will manage Google accounts.
It controls the settings page and both account collections.

## Next steps

After enabling, you need to scan the library and add an account. Continue to
[Configuration](../configuration/index.md) — and read the secrets guidance there
**before** you paste in any client secret or service-account key.

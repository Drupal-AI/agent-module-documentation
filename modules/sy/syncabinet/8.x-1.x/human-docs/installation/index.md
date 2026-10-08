# Installation

## Requirements

SynCabinet needs:

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Syncart** module (`syncart`) — SynCabinet is part of the same
  vendor suite and depends on it.

There are no third-party PHP library dependencies listed. Because it is a
vendor-specific module, it is really intended to be run as part of the
SynapseF/syncart stack rather than on its own.

## Install with Composer

From the project root:

```bash
composer require drupal/syncabinet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `syncart` and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/syncabinet -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en syncabinet -y
```

Drupal will enable `syncart` automatically as a dependency.

## Verify it worked

Confirm SynCabinet and Syncart are both enabled at **Extend**
(`/admin/modules`). Because this is an authentication and profile module, review
its actual login, registration and session behaviour in your context — and
consult the vendor's documentation — before relying on it in production.

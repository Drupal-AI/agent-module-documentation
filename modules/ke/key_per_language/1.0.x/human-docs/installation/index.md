# Installation

## Requirements

- **Drupal 8.9 through 11** (`core_version_requirement: >=8.9 <12`).
- The **Key** module (`key`) — Key per language is a provider for it.
- A **multilingual site** (core's Language module and more than one configured
  language) for the per‑language mapping to have anything to resolve.

## Install with Composer

From the project root:

```bash
composer require drupal/key_per_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/key_per_language -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en key_per_language -y
```

Or enable **Key per language** on the **Extend** page (`/admin/modules`). The Key
module is enabled automatically as a dependency.

## Verify it worked

Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
**Add key**. Under **Key provider** you should now see **Key per Language**. See
[Configuration](../configuration/index.md) to set up the mapping.

> **Heads up:** This release is an alpha and is not covered by Drupal's security
> advisory policy.

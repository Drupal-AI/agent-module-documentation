# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.
- Your site should be reachable over **HTTPS** at the domain whose handles you want
  to verify, since Nostr clients fetch `https://yourdomain/.well-known/nostr.json`.

## Install with Composer

From the project root:

```bash
composer require drupal/nostr_id_nip05 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nostr_id_nip05 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nostr_id_nip05 -y
```

## Verify it worked

Go to **Configuration → System → Nostr internet identifier (NIP‑05)**
(`/admin/config/system/nostr-id-nip05`); if the form loads, the module is active.
After you add at least one mapping (see [Configuration](../configuration/index.md)),
open `https://yourdomain/.well-known/nostr.json?name=<name>` in a browser — you
should get back a JSON `names` object containing that name and its public key.

# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- The **Key** module (`drupal/key` `^1.22`) — a hard dependency that provides the
  key-management framework this module plugs into. Composer pulls it in
  automatically.
- The **`paragonie/sodium_compat`** library (`^2.4`) for the libsodium
  cryptography. Composer installs it automatically as a dependency.
- For the Drush commands, **Drush 13.7 or newer** (the module conflicts with
  older Drush).

## Install with Composer

From the project root:

```bash
composer require drupal/easy_encryption -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module,
the sodium library, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/easy_encryption -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it (Drush will enable the Key dependency automatically):

```bash
drush en easy_encryption -y
```

On install, the module generates and activates a libsodium key pair for you —
there's nothing to configure to start encrypting. It also creates a protected
`.easy_encryption` directory next to your web root for the private key; **keep
that out of version control.**

## Optional submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Easy Encryption Admin** | `easy_encryption_admin` | An admin UI for exporting and importing keys and migrating the private key between storage backends (the same operations the Drush commands perform). Enable it if you want to manage keys through the interface. |

Enable it when you need it:

```bash
drush en easy_encryption_admin -y
```

## Verify it worked

Visit the Status report (**Reports → Status report**,
`/admin/reports/status`). Easy Encryption runs a self-test and will flag a
warning there if the private key ends up stored in the database rather than on the
filesystem. A clean status report means encryption is set up correctly.

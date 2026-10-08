# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9||^9||^10||^11`).
- The **LDAP User** module (`ldap_user`), which is part of the
  [LDAP](https://www.drupal.org/project/ldap) suite. LDAP Profile depends on it
  and cannot do anything useful without a working LDAP connection behind it.

In practice that means the whole LDAP suite should already be installed and
configured — the directory server connection (`ldap_servers`) and account
provisioning (`ldap_user`) — before this module adds value. There are no
third‑party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/ldap_profile -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the LDAP suite
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ldap_profile -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ldap_profile -y
```

Enabling LDAP Profile also enables `ldap_user` (and the rest of the LDAP suite
it needs) if they are not already on.

## Verify it worked

Confirm the module is enabled (`drush pm:list --status=enabled | grep ldap`),
then open the **LDAP User** field‑mapping configuration under **Configuration →
People → LDAP**. You should be able to add mappings from directory attributes to
your Drupal profile fields. Log in as an LDAP user (or run a sync) and check that
the profile fields fill from the directory.

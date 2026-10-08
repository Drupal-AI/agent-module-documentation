# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **`symfony/ldap` library, version ^5.4 or ^6.0** — the PHP bridge that talks to
  the directory. It is a Composer dependency, so installing with Composer pulls it in.
- The **[External Authentication](https://www.drupal.org/project/externalauth)**
  module (`drupal/externalauth`, ^2.0) — required by the LDAP submodules.
- The **[Authorization](https://www.drupal.org/project/authorization)** module
  (`drupal/authorization`, ^1.0) — required only if you use **LDAP Authorization** to
  grant roles from groups; it is pulled in as a project dependency regardless.

Your PHP installation also needs the LDAP extension enabled (`ext-ldap`) so
`symfony/ldap` can connect.

## Install with Composer

From the project root:

```bash
composer require drupal/ldap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in `symfony/ldap`, `drupal/externalauth`, and
`drupal/authorization`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ldap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The top‑level `ldap` module is only a meta package, so enabling it on its own does
nothing useful. Enable the **submodules** you actually need — Drupal pulls in the
required base modules automatically. For a typical single‑sign‑on plus role‑sync
setup:

```bash
drush en ldap_authentication ldap_authorization -y
```

That command pulls in **LDAP Servers** and **LDAP User** as dependencies. Add
`ldap_query` if you want stored directory searches.

## The submodules

| Submodule | Machine name | What it adds | Depends on |
|-----------|--------------|--------------|------------|
| **LDAP Servers** | `ldap_servers` | The `ldap_server` connection entity and the services that talk to the directory. **The required base.** | `externalauth` |
| **LDAP Authentication** | `ldap_authentication` | Validates the Drupal login form against LDAP. | `ldap_servers`, `ldap_user`, `externalauth` |
| **LDAP User** | `ldap_user` | Syncs and provisions Drupal accounts and fields from LDAP (and optionally back). | `ldap_servers`, `ldap_query`, `externalauth` |
| **LDAP Query** | `ldap_query` | Stored, reusable directory searches with Views integration. | `ldap_servers`, `views` |
| **LDAP Authorization** | `ldap_authorization` | Grants Drupal roles from LDAP groups. | `ldap_servers`, `ldap_user`, `authorization` |

Once the submodules are enabled, continue to
[Configuration](../configuration/index.md) to set up your server and mappings.

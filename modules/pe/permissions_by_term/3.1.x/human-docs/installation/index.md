# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1.0`).
- Core's **Taxonomy**, **Field**, **System** and **Path alias** modules, which
  Drupal enables as dependencies. (Taxonomy is what the whole module is built
  around.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/permissions_by_term -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permissions_by_term -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permissions_by_term -y
```

### Optional submodule — Permissions by Entity

Permissions by Term ships one optional submodule, **Permissions by Entity**
(`permissions_by_entity`), which applies the same term-based grants to non-node
fieldable entities (such as media or paragraphs). Enable it only if you need
that:

```bash
drush en permissions_by_entity -y
```

## Grant the permissions that expose the grant forms

The controls for setting grants are gated behind the module's own permissions.
Assign these to the appropriate roles at **People → Permissions**, or from the
CLI:

```bash
# lets a role manage the settings page:
drush role:perm:add site_admin 'access pbt settings'
# lets a role set which users/roles may use a term, on the term edit form:
drush role:perm:add editor 'show term permission form on term page'
# lets a role assign terms to users, on the user edit form:
drush role:perm:add editor 'show term permissions on user edit page'
# lets a role see the read-only access panel on the node form:
drush role:perm:add editor 'show term permissions on node edit page'
```

Without at least the first three, the grant forms and settings page are not
shown.

## Verify it worked

Log in as a user with **Access pbt settings** and go to **Configuration → System
→ Permissions by Term** (`/admin/permissions-by-term/settings`) — you should see
the settings form. Then edit any taxonomy term and confirm a **Permissions**
section appears on the form. See [Configuration](../configuration/index.md) for
how to use them.

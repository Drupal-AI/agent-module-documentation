# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A substantial **CRM dependency stack**, most of it contrib, which Composer pulls
  in for you:
  - `decoupled_auth` and `decoupled_auth_crm` — decoupled user accounts (contacts
    that need not be login accounts).
  - `profile` — the profile entity that describes each contact.
  - `name` — structured personal names.
  - `ctools` and `ctools_views`.
  - `search_api` / `search_api_db` — the index that powers listing and facets.
  - `facets` — dashboard filtering.
  - `address` — postal addresses.
  - core `block`, `datetime`, `options`, `layout_discovery`, and `toolbar`.
- The bundled **`crm_tools`** submodule is enabled together with the base module.

This project is covered by Drupal's security advisory policy. Historically the
project has relied on a few dependency patches — if `composer require` reports a
patch requirement, enable Composer patching (`composer config extra.enable-patching
true`) as the project instructs.

## Install with Composer

From the project root:

```bash
composer require drupal/contacts -W
```

The `-W` (`--with-all-dependencies`) flag is important here, since Contacts brings
in a large dependency tree that Composer needs to resolve together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contacts -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contacts -y
```

Enabling Contacts pulls in the dependency stack and the bundled `crm_tools`, and
installs the CRM roles (`crm_indiv`, `crm_org`, `crm_manager`), the profile types,
and the `contacts_index` Search API index.

## Submodules — enable only what you need

Contacts ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **CRM Tools** | `crm_tools` | Advanced role storage plus a unified login/register page (overrides the login/register controllers when visitor registration is on). Bundled and enabled with the base module. |
| **User Dashboard** | `contacts_user_dashboard` | A front‑end account dashboard at `/user/{user}/summary`, gated by login plus an `access user dashboards` permission. |
| **Log** | `contacts_log` | Records profile/user changes as Message entities for an activity history. |
| **Group** | `contacts_group` | Relates contacts to Groups (Group module integration). |
| **DBS** | `contacts_dbs` | A DBS (background‑check) status tracking workflow. |
| **Mapping** | `contacts_mapping` | Shows contacts on a geolocation map. |

For example, to add the front‑end user dashboard:

```bash
drush en contacts_user_dashboard -y
```

## Verify it worked

Grant the CRM permissions (see [Configuration](../configuration/index.md)), then
visit **`/admin/contacts`**. You should land on the Contacts dashboard. Add a test
individual at `/admin/contacts/add/indiv` and confirm it appears in the listing. If
listings look empty after importing data, re‑index with:

```bash
drush search-api:index contacts_index
```

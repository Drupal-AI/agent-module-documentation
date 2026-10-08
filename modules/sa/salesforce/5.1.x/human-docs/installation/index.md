# Installation

## Requirements

Salesforce Integration is a substantial suite with several external and Drupal
dependencies:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP libraries**, pulled in automatically by Composer: `lusitanian/oauth`
  (`^0.8.11`), `firebase/php-jwt` (`^5.0 || ^6.0 || ^7.0`),
  `messageagency/force.com-toolkit-for-php` (`^1.0.2`), and
  `consolidation/output-formatters`.
- **PHP extensions** `ext-soap` and `ext-json` must be present on the server.
- **Drupal modules** it depends on: `key` (for storing credentials securely),
  and — for the mapping and address submodules — `address`,
  `dynamic_entity_reference`, and `typed_data`. Composer installs these as
  suggested/required dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/salesforce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared
libraries and modules the suite needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/salesforce -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en salesforce -y
```

## Submodules — enable what your integration needs

The base module is only the API layer. A working integration almost always needs
several submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **OAuth Provider** | `salesforce_oauth` | OAuth user‑agent auth flow for connecting to Salesforce. |
| **JWT Provider** | `salesforce_jwt` | Key‑based JWT authentication (uses a Key entity), including a GovCloud variant. |
| **Salesforce Mapping** | `salesforce_mapping` | Define maps that tie a Drupal entity/bundle to a Salesforce object and its fields. Requires `dynamic_entity_reference` and `typed_data`. |
| **Mapping UI** | `salesforce_mapping_ui` | The admin UI for creating and editing mappings. |
| **Salesforce Push** | `salesforce_push` | Send Drupal changes to Salesforce. |
| **Salesforce Pull** | `salesforce_pull` | Bring Salesforce changes into Drupal. |
| **Logger** | `salesforce_logger` | Log Salesforce events and errors. |
| **SOAP** | `salesforce_soap` | SOAP API support via the force.com toolkit. |
| **Address** | `salesforce_address` | Address field integration (requires `address`). |
| **Webform** | `salesforce_webform` | Map Webform submissions to Salesforce. |
| **Example** | `salesforce_example` | A worked example integration for reference. |

For a common setup — OAuth auth plus field mapping and two‑way sync — you might
run:

```bash
drush en salesforce salesforce_oauth salesforce_mapping salesforce_mapping_ui salesforce_push salesforce_pull -y
```

Each submodule requires the base `salesforce` module, which is already present
once you have installed the suite above.

## Verify it worked

Log in as an administrator and go to **Configuration → Salesforce**
(`/admin/config/salesforce`). You should see the Salesforce admin section. Next,
follow [Configuration](../configuration/index.md) to authorize a connection to
your Salesforce org and choose your default auth provider.

# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Contact** module (`contact`).
- The **Contact Storage** module (`drupal/contact_storage`) — this is what actually
  stores contact-form submissions so there is something to export.
- The **CSV Serialization** module (`drupal/csv_serialization`) — used to encode the
  CSV output.

All three are declared as dependencies, so Composer pulls in the contrib ones and
Drupal enables the set together. For sensitive submissions, configure Drupal's
**private file system** so exports are written to a private directory.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_storage_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This also brings in Contact Storage and CSV Serialization.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact_storage_export -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_storage_export -y
```

Enabling it also enables `contact`, `contact_storage`, and `csv_serialization` if
they aren't already on. There is no settings form — export options are chosen per
export.

## Grant the permission

The whole feature is gated by one permission, **Export contact form messages** (a
restricted permission that lets a role export **any** contact form's stored
messages, subject to normal entity access). Grant it at **People → Permissions**
(`/admin/people/permissions`) to the roles that should be able to download
submissions — it's fine to give this to non-administrator editors who need self-serve
CSV exports. Because contact submissions may contain personal data, grant it only to
roles you trust.

## Verify it worked

Go to **Structure → Contact forms** (`/admin/structure/contact`). Each form should
now show an **Export submissions** operation. Choosing it opens the export form —
see the [overview](../index.md) for the options and the download flow.

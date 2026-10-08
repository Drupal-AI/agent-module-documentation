# Installation

## Requirements

- **Drupal 11.1 or later** (`core_version_requirement: ^11.1`).
- An **Islandora** site — this module is designed to work with Islandora and its
  content model.
- Three fields on your Islandora node type, plus an optional field on media (see
  below). You add these yourself; the module reads them.

## Install with Composer

From the project root:

```bash
composer require drupal/islandora_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/islandora_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en islandora_access -y
```

## Add the required fields

For the module to do anything, your node type needs these fields (a standard
Islandora install already has the first two):

- **`field_member_of`** — an entity reference to a **node**, used to link a child
  object to its parent (collection). This is how the module finds children to
  cascade access to.
- **`field_model`** — an entity reference to a **taxonomy term**. The term needs a
  **`field_external_uri`** field to identify collection nodes.
- **`field_administrator`** — an entity reference to a **user**. This is the field
  that assigns an editor to a node (and its children).

Optionally, to control media access as well:

- **`field_media_of`** on your media — set it to reference the relevant nodes so
  the module governs that media's access too.

Add fields under **Structure → Content types → *(your Islandora type)* → Manage
fields** (and the equivalent for media).

## Verify it worked

Edit an Islandora node, reference a non-admin user account in
**`field_administrator`**, and save. Log in as that user: they should now be able to
view, edit, and delete that node and its children (nodes referencing it via
`field_member_of`), and manage the media attached to them. Also confirm that the
change making **published nodes anonymously viewable** is acceptable for your site.

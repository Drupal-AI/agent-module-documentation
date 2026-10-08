# Druidfire — manual setup guide

**Druidfire** (`druidfire`) — "Drush Instant Delivery FIeld REsizer" — is a
developer tool for transforming Drupal entity **field definitions** on the fly.
It offers a "spell" plugin system that performs schema‑level field changes which
would otherwise require fiddly database operations and manual configuration edits.
It was originally written by chx.

The transformations it can perform include:

- **Field resizing** — change the maximum length of text/string fields without
  losing data or rebuilding the site.
- **Field type conversions** — for example: plain string → formatted (WYSIWYG)
  text; Entity Reference Revisions → standard Entity Reference; Entity Reference
  Revisions → Bricks fields; string → taxonomy term reference.

Each transformation handles the database schema change, the configuration update,
and cache clearing for you. You drive it either from **Drush** (great for
automated deployments and bulk operations) or from **PHP** in update hooks and
custom code.

Treat this as a **powerful, potentially destructive** tool. Altering a field
definition reshapes — and can drop — field storage, so it belongs in the hands of
trusted developers, run on the CLI, tested first, and **always with a database
backup taken beforehand**. It has no runtime access‑control role; it is purely a
developer instrument. By design there is **no configuration interface** — you use
it programmatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is a Drush/API developer
tool, used as described below.

## How to use it

After enabling the module, work with it from Drush or PHP. Some example Drush
commands from the project page:

```bash
# Show all available Druidfire spells and what they do
drush druidfire:list-spells

# Resize a field to 1024 characters
drush druidfire:resize paragraph section_title 1024

# Convert a string field to formatted text
drush druidfire:string2formatted node body

# Convert Entity Reference Revisions to Entity Reference
drush druidfire:err2er node my_field

# Convert ERR to a Bricks field
drush druidfire:err2bricks node my_paragraphs_field

# Convert a string field to a taxonomy reference (requires the vocabulary ID)
drush druidfire:string2taxonomyreference node category tags
```

The same operations are available in PHP via the `druidfire` service, for use in
update hooks or custom code, for example:

```php
\Drupal::service('druidfire')->resize('paragraph', 'link', ['size' => 1024, 'property' => 'title']);
\Drupal::service('druidfire')->string2formatted('paragraph', 'component_flora_answer');
```

**Always back up your database before running any transformation.**

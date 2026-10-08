# Migrate Skip Fields — manual setup guide

**Migrate Skip Fields** (`migrate_skip_fields`) lets you exclude specific fields
from being migrated during a Drupal‑to‑Drupal upgrade. When you run the standard
migration from an older Drupal 6 or 7 site, *every* field comes across by
default. Often that's not what you want: some fields are deprecated, some are
being handled separately, and some simply shouldn't exist on the new site. This
module gives you a clean way to say "don't migrate these" without hand‑editing the
generated migrations.

You can target fields to skip in several ways: by entity type, by bundle, by
field name, or by field type — and you can mix wildcards in to skip broad groups
at once. It's a developer/migration tool with no request‑time behaviour and no
admin UI; you configure it entirely through settings in your `settings.php`.

One thing to keep in mind: skipping a field means its **data is not migrated**.
That's the whole point, but it does mean you should double‑check your skip list is
intentional before running the upgrade for real — there's no undo short of
re‑running the migration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no admin settings
form. You configure the skips in `settings.php`, as described below.

## How to configure the skips

Add the settings you need to your `settings.php` (or `settings.local.php`). All
of them are optional.

**Which source version you're upgrading from** — Drupal core `6` or `7`
(defaults to `7`):

```php
$settings['migrate_skip_fields_source_version'] = '7';
```

**Skip by entity type, bundle, and field name** — each entry is
`entity_type:bundle:field_name`, and an asterisk (`*`) is a wildcard for any one
component:

```php
$settings['migrate_skip_fields_by_name'] = [
  'entity_type:bundle:field_name',  // one specific field
  'entity_type:bundle:*',           // every field on this bundle
  'entity_type:*:field_name',       // this field name on any bundle
  '*:*:field_name',                 // this field name everywhere
];
```

**Skip by field type** — skip every field of a given type (see `hook_field_info`,
or the `content_node_field` table on Drupal 6 / the `field_config` table on
Drupal 7 for the type machine names):

```php
$settings['migrate_skip_fields_by_type'] = [
  'field_type_1',
  'field_type_2',
];
```

After editing `settings.php`, run your migration as usual — the listed fields
will be left out.

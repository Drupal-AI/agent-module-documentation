# Migrate Devel FileCopy — manual setup guide

**Migrate Devel FileCopy** (`migrate_devel_file_copy`) is a developer aid for
migrations that copy files. It provides a single Migrate **process plugin**,
`file_copy_or_generate`, which behaves like core's `file_copy` — but when the
**source file is missing**, instead of failing it **generates a placeholder file**
on the destination.

The problem it solves shows up constantly when debugging migrations against a
sanitized copy of a customer database: you have all the file *records* but none of
the actual files, so a normal `file_copy` step errors out row after row. With this
plugin, missing files quietly become placeholders and the migration keeps going,
so you can exercise the rest of the pipeline locally without the real asset
library.

There is **no settings form**, and this is explicitly a **development** tool — you
would not use it on a production import where real files matter. It has no module
dependencies and runs on **Drupal 8.9, 9, 10, and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you wire the plugin in via a
small hook, as shown below.

## How to use it

You can reference `file_copy_or_generate` directly as a process plugin in a
migration, but the common pattern is to **swap it in for core's `file_copy`** only
when this module is installed — so the same migration works with real files in
production and placeholders locally. Do that with the (undocumented)
`hook_migrate_process_info_alter()` hook in a custom module:

```php
/**
 * Implements hook_migrate_process_info_alter().
 */
function mymodule_migrate_process_info_alter(&$definitions) {
  // If Migrate Devel FileCopy is installed, replace the core 'file_copy'
  // plugin with 'file_copy_or_generate' — we're probably debugging a
  // (sanitized) customer DB without the source files.
  // @see https://drupal.org/project/migrate_devel_file_copy
  if (
    !empty($definitions['file_copy_or_generate']) &&
    !empty($definitions['file_copy'])
  ) {
    $definitions['file_copy'] = $definitions['file_copy_or_generate'];
  }
}
```

With the module enabled and the hook in place, any migration step using
`file_copy` now tolerates missing source files by generating placeholders. Remove
or disable the module on environments where you need real files copied.

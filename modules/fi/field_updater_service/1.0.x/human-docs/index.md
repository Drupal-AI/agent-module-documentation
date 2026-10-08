# Field Updater Service — manual setup guide

**Field Updater Service** (`field_updater_service`) is a **developer‑oriented tool
for copying values between fields** on an entity, in bulk. Instead of writing
custom batch code every time you need to move a value from one field to another —
during a content model change, a migration, or a deployment — you define a mapping
once as a configuration entity and let the module's batch service do the work. It
can map from one or more source fields on the same entity to any target field,
supports explicit default and NULL values, is multilingual‑aware, and can read from
entity reference and entity reference revisions fields as sources.

Because it writes directly to field data, treat it as you would any bulk data
operation.

> **Data safety.** This module changes stored field values in batch. Always run it
> against a **backup or a non‑production copy first**, confirm the mapping does what
> you expect on a small set, and keep a way to roll back before running it on live
> content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no single settings form**. You create "field updater" configuration
entities and run them via Drush, described in "How to use it" below.

## How to use it

1. Go to **`/admin/config/field-updater`** and add a new field updater.
2. Choose the **entity type**, **bundle**, and **target field**. If you're copying
   from an entity reference (or entity reference revisions) field, select it as the
   field mappings **source**.
3. Save, then add the **mappings** that say which source value(s) feed the target.
   Mappings are matched by the target field's schema, and you can supply custom
   defaults or an explicit NULL.
4. Run the copy from the command line:

   ```bash
   drush field-updater:update
   ```

   Pick the updater instance to run and confirm when prompted. Use
   `drush field-updater:list` to see the available updaters.
5. On completion, Drush prints an example `hook_update_N()` you can paste into your
   own module's `.install` file, so the same update can be deployed cleanly to
   other environments:

   ```php
   function my_module_update_10001() {
     \Drupal::service('field_updater_service.updater')
       ->updateEntities('your_updater_id');
   }
   ```

Since the mappings live in configuration entities, they export and deploy like any
other config.

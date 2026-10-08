# Content Entity Sync — manual setup guide

**Content Entity Sync** (`content_entity_sync`) provides Drush commands for exporting
and importing **content** entities between Drupal environments. Drupal's built‑in
configuration sync moves *config* between sites but deliberately leaves content
alone; this module fills that gap, letting you carry specific nodes, taxonomy terms,
and other content entities from one instance to another reproducibly — instead of
recreating them by hand or copying an entire database. It supports all entity types
and all field types, exporting to YAML files that another site can import.

Everything happens on the command line. The export command
(`drush content-entity-sync:export`, aliased `drush conex` or `drush cox`) writes
content entities to YAML — you can name an entity type and optionally filter by
bundle. The import command (`drush content-entity-sync:import`, aliased `drush conim`
or `drush coi`) reads those YAML files back in. For example:

```bash
# Export all "article" nodes
drush content-entity-sync:export node --bundle=article

# Import "tags" taxonomy terms
drush content-entity-sync:import taxonomy_term --bundle=tags
```

This is a **needs‑config** module in one specific sense: before you can use it you
must tell Drupal where the YAML files live, via a `$settings` line in `settings.php`
(see [Installation](installation/index.md)). It depends on core's **Field** module.

Because it runs through Drush, it operates in the already‑privileged CLI context.
Treat synced content the way you'd treat any imported content, and run syncs
deliberately: an import can **overwrite** existing entities, so make it part of a
controlled, reviewed process rather than an ad‑hoc command on production.

This guide is written for a **human** clicking through the admin UI (and, here,
the command line). If you want terse, token‑cheap references for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and set the content directory in `settings.php`.

This module has **no configuration form in the admin UI** — its one configuration
step is the `settings.php` directory setting described in the installation guide, and
all its operations are Drush commands.

## How to use it

1. Set `$settings['content_sync_directory']` in `settings.php` and enable the module
   (see [Installation](installation/index.md)).
2. On the source environment, export the content you need, for example
   `drush content-entity-sync:export node --bundle=article`.
3. Move the generated YAML files to the target environment's content directory (for
   example commit them to your repository).
4. On the target environment, import them with
   `drush content-entity-sync:import`, optionally scoping to an entity type and
   bundle. Remember an import can overwrite matching entities, so run it as part of a
   controlled deployment.

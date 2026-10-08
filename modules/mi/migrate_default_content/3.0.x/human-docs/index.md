# Migrate Default Content — manual setup guide

**Migrate Default Content** (`migrate_default_content`) is a code‑first way to ship
seed, fixture, or demo content with a module, install profile, or distribution.
You author your content as **YAML files** in a `default_content` directory in your
project, and the module automatically generates Migrate API migrations from those
files — so a fresh install isn't empty, and your default content lives in version
control instead of a database dump. Because it builds on Drupal's Migrate API, the
imports are idempotent and re‑runnable, and you can roll them back.

It's quite capable for a "dummy content" tool. Each file is named
`ENTITY_TYPE.BUNDLE.yml` (for example `node.article.yml`, `user.user.yml`,
`taxonomy_term.tags.yml`) and holds a list of entities. It supports
**entity‑reference** and reference‑revision fields (resolved by identifier across
files, so nodes can reference migrated users or paragraphs), **file** migrations
(drop files in `default_content/files` and reference them by name), **menu
links**, **multi‑component fields** like formatted body text, **translations**
(via `ENTITY_TYPE.BUNDLE.LANGCODE.yml` files), and automatic **password hashing**
for password fields.

An optional submodule, **Migrate Default Content Export**
(`migrate_default_content_export`), works the other way round: it adds a Drush
command that generates these YAML files from content that already exists on your
site — handy for editing content in the UI and then committing the resulting
fixtures back to your repository.

This is a developer and deployment tool, not a runtime, user‑facing feature.
Content is authored by developers as files in the codebase and imported with
standard Migrate commands. The module does have a small settings form (just three
directory paths), which is covered below rather than in a separate configuration
page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate and the YAML source plugin.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Migrate Default Content**
(`/admin/config/system/migrate-default-content/settings`), gated by core's
*Administer site configuration* permission. The actual content lives in files in
your codebase, and imports are run from the command line.

## How to use it

### 1. Author your content files

Create a `default_content` directory in your project (by default, one level above
the Drupal root — a `default_content/` folder beside `web/`). Add files named
`ENTITY_TYPE.BUNDLE.yml`, each containing a list of records. The first key of each
record is its identifier, used when other files reference it. Put any imported
files (images, documents) in `default_content/files`.

### 2. Adjust the settings (optional)

The settings form has three fields, all directory paths:

- **Source directory** (`source_dir`, default `../default_content`) — where your
  content YAML files live, relative to the Drupal site root.
- **Migration override directory** (`migration_override_dir`, default `overrides`,
  relative to the source directory) — holds partial migration definitions that
  override the auto‑generated ones, when you need to customize a migration.
- **Migration export directory** (`migration_export_dir`, default `migrations`,
  relative to the source directory) — where the export‑migrations Drush command
  writes the generated migration YAML.

You can also set these from the command line, for example:

```bash
drush config:set migrate_default_content.settings source_dir default_content -y
```

(Note the form doesn't check that the source directory exists — a missing
directory simply produces no migrations.)

### 3. Import the content

The module generates one migration per file, all tagged `migrate_default_content`
and grouped by entity type, so you run them with standard Migrate commands (from
Migrate Tools):

```bash
drush migrate:import --tag=migrate_default_content    # import everything
drush migrate:rollback --tag=migrate_default_content  # roll it back
```

### 4. Inspect or version‑control the generated migrations (optional)

To write the exact generated migration definitions out as YAML — useful for
inspection, or as a starting point for overrides — run the module's own command:

```bash
drush migrate-default-content:export-migrations   # alias: drush mdcem
```

### 5. Export existing content back to YAML (optional)

If you enable the **Migrate Default Content Export** submodule, it adds a Drush
command that generates content YAML from content already on your site, so you can
capture UI‑authored content as fixtures and commit them.

# Configuration

Structure Sync is configured — and operated — from **Structure → Structure Sync**
(`/admin/structure/structure-sync`). "Configuring" it really means running exports
and imports and choosing an import style. All screens require the core **Administer
site configuration** permission.

## What it syncs

Three content‑entity types that core configuration management can't move between
environments, because they're stored as **content**, not configuration:

- **Taxonomy terms** (across all vocabularies)
- **Custom / content blocks** (`block_content`)
- **Menu links** (`menu_link_content`)

Structure Sync serializes these into a single config object,
**`structure_sync.data`**, which you deploy like any other config, then imports
back into real entities on the target.

## The screens

Under `/admin/structure/structure-sync`:

- **General settings** (the landing page) — one option, **Enable logging** (on by
  default), which toggles logging of Structure Sync's operations.
- **Taxonomies** — export / import taxonomy terms.
- **Blocks** — export / import custom blocks.
- **Menu links** — export / import menu links.

Each type screen has an **Export** button (which writes the current entities into
`structure_sync.data`) and **Import** buttons for each style. There are also
"export all" / "import all" shortcuts and matching Drush commands.

## The deployment workflow

1. On the **source** environment, open the type you want and click **Export**. This
   snapshots the current terms / blocks / menu links into `structure_sync.data`.
2. Export your site config as usual (`drush config:export`), which includes
   `structure_sync.data.yml`, and commit it to Git.
3. Deploy to the **target** and run `drush config:import` so the target has the same
   `structure_sync.data`.
4. On the target, run a Structure Sync **Import** (in the UI or via Drush) to turn
   that data back into real entities.

## Import styles (safe / full / force)

Every import asks for a style. Because entities are matched by **UUID**, imports are
idempotent — re‑running one won't create duplicates.

- **Safe** — only add entities that are missing. Never updates or deletes existing
  ones. Use this to bring across *new* items only.
- **Full** — a safe import **plus** updating entities that already exist (matched by
  UUID). Use this to also bring existing items up to date.
- **Force** — **delete all** entities of that type first, then recreate everything
  from config. Use this to make the target exactly mirror the exported data. This
  is destructive — the target's current terms / blocks / menu links of that type are
  removed first.

## Drush

The same operations are available on the command line, handy for CI/CD deploy
steps — for example `drush export-taxonomies`, `drush import-menus`,
`drush export-all`, and `drush import-all`. See the
[`agent/`](../agent/start.md) docs for the full command list.

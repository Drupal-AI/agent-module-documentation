# Configure Structure Sync (admin UI, config object, import styles)

## What it syncs

Three content-entity types that core config management (CMI) cannot move between
environments, because they are stored as **content**, not configuration:

- Taxonomy terms (all vocabularies)
- Custom / content blocks (`block_content`)
- Menu links (`menu_link_content`)

Structure Sync serializes these into a single config object, **`structure_sync.data`**, which
you deploy like any other config, then imports them back into real entities on the target.

## Admin screens

All under `/admin/structure/structure-sync`, each gated by the core
`administer site configuration` permission (the module defines **no** permissions of its own):

| Route | Path | Purpose |
|---|---|---|
| `structure_sync` | `/admin/structure/structure-sync` | Landing (general settings form) |
| `structure_sync.general.form` | `/general` | General settings — the `configure` route |
| `structure_sync.taxonomies.form` | `/taxonomies` | Export / import taxonomy terms |
| `structure_sync.blocks.form` | `/blocks` | Export / import custom blocks |
| `structure_sync.menu.form` | `/menu-links` | Export / import menu links |

Each type form has an **Export** button (writes the current entities into `structure_sync.data`)
and **Import** buttons for each style. The general settings form has one option: **Enable
logging** (`log`, default on) — stored on `structure_sync.data` and consulted by the module's
logger.

## The `structure_sync.data` config object

Schema: `config/schema/structure_sync.schema.yml` (`type: config_object`). Keys:

- `taxonomies` — sequence of vocabularies, each a sequence of term records (fields at term root; schema treats each term as `ignore`).
- `blocks` — sequence of block records (`info`, `langcode`, `uuid`, `bundle`, `revision_id`, `rev_id_current`, `fields`).
- `menus` — sequence of menu-link records (`menu_name`, `title`, `parent`, `uri`, `link_title`, `weight`, `enabled`, `expanded`, `uuid`, `options`, …).
- `log` — boolean, general logging toggle.

Because it is a config object it exports with `drush config:export` and travels through your
normal Git/config deployment. Deploy = export on source → commit `structure_sync.data.yml` →
`config:import` on target → run a Structure Sync **import** to turn the data back into entities.

## Import styles (safe / full / force)

Every import (UI or Drush) asks for a style. Entities are matched by **UUID**, so imports are
idempotent.

| Style | Behavior |
|---|---|
| `safe` | Only add entities that are missing. Never updates or deletes existing ones. |
| `full` | Safe import **plus** update entities that already exist (matched by UUID). |
| `force` | **Delete all** entities of that type first, then recreate everything from config. |

Choose `safe` to only add new items, `full` to also bring existing items up to date, and
`force` to make the target exactly mirror the exported data (destructive).

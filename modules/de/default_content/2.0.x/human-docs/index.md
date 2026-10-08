# Default Content — manual setup guide

**Default Content** (`default_content`) lets a module or install profile carry
real *content* — not just configuration. It exports content entities (nodes,
taxonomy terms, files, media, menu links, custom blocks, and so on) to YAML files
that live inside a module, and imports them automatically the moment that module
is enabled. That's how a freshly installed site or distribution can arrive with
demo content, starter pages, or test fixtures already in place instead of a bare,
empty database.

Each exported entity becomes a per‑entity YAML file at
`content/{entity_type}/{uuid}.yml` inside the providing module. Alongside the
field values, the file records a `_meta` block with the entity's UUID, bundle,
and a map of the other entities it references. On import, the module reads every
enabled module's `content/` directory, works out the dependency order (so a
taxonomy term is created before the node that references it, and an author before
the node they own), and saves everything in the right sequence with stable UUIDs
so references stay valid on every install. Files and media also copy their
physical file across.

This is a **developer / site‑builder tool** driven by Drush commands — it has
**no admin UI, no settings page, and no permissions**. You export content with
commands like `dce`, `dcer`, `dcem`, and `dcemr`, commit the resulting YAML into
a module, and the content imports itself when that module is installed (or during
a configuration import). It depends only on Drupal core. Note that this 2.0.x
release is a **beta** (`2.0.0-beta1`), and the older `hal_json` (`.json`) content
format is deprecated in favor of YAML.

This guide is written for a **human** getting the module installed and
understanding the workflow. For the full command reference, the YAML `_meta`
format, the service APIs, and the import/export events, an AI coding agent should
read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — Default Content has no admin pages. You work with it entirely from the
command line (Drush) and by committing YAML files into your modules. The content
it imports appears in the normal places (the content list, the media library,
menus), but the module itself adds no menu items or forms.

## How to use it

The typical loop is **export from a working site, commit, import on install**:

1. Build the content you want to ship on a working site.
2. Export it into a module's `content/` directory with Drush. For example:
   - `drush dce node 123 my_module` — export a single node.
   - `drush dcer node 123 my_module` — export that node *plus every entity it
     references*.
   - `drush dcem my_module` — export all the UUIDs listed under
     `default_content:` in the module's `.info.yml`.
   - `drush dcemr my_module` — the same, plus all referenced entities.
   Options like `--folder` and `--file` control where the export is written.
3. Commit the generated YAML files into the module and put it in version control.
4. When that module is enabled on any site (or during a config‑sync deployment),
   the content imports automatically, in dependency order, with its original
   UUIDs.

Common uses: shipping demo content with an install profile or distribution,
bundling example content with a feature module, seeding test fixtures, and moving
curated content between environments as reviewable code. Developers can also
react to imports and exports through the `default_content.import` and
`default_content.export` events, or swap the exporter/importer/normalizer
services — see the [`agent/`](../agent/start.md) docs.

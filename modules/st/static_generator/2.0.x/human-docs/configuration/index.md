# Configuration

Static Generator does nothing until you configure it. Configuration has two
parts: the **settings form** (where files go and how they are deployed) and the
**Drush commands** (which actually generate and deploy the site).

## Open the settings form

1. Log in as a user with the **Administer static generator** permission.
2. Go to **Configuration → Static Generator**
   (`/admin/config/static_generator`).

Per-entity-type generation options live at
`/admin/config/static_generator/type/{entity_type_id}`, where you choose which
node/media bundles participate in generation.

## Settings you will set

These are stored in `static_generator.settings`:

- **Generator directory** (`generator_directory`, default `private://`) — where the
  generated HTML files are written on the Drupal server before deployment.
- **rsync commands** (`rsync_public`, `rsync_code`) — the `rsync` invocations used
  to push public files and code out to the static host, with
  **`rsync_public_exclude`** letting you exclude file types (for example
  `css`/`js`/`php`) from the public sync.
- **Paths to generate** (`paths_generate`, default `/node`) — which paths are
  crawled and rendered.
- **Render method** (`render_method`, default `Guzzle`) — how each page is
  rendered. The default issues an internal HTTP request to **`guzzle_host`**,
  which sidesteps a core block-caching bug where blocks vary per page.
- **Guzzle options** (`guzzle_options`) — advanced. This string is evaluated as a
  PHP array on each render. It can, for instance, set `['verify' => false]` to
  disable TLS verification. Only a holder of *Administer static generator* can set
  it, but treat it as trusted code — leave it alone unless you know exactly why
  you are changing it.
- **ESI settings** (`esi_blocks`, `esi_sg_esi`) — control ESI fragment handling for
  shared blocks.
- **Generate unpublished** (`gen_unpublished`) — by default only *published* nodes
  are generated; enable this to also generate unpublished content.
- **Generate index** (`generate_index`) — whether an index page is produced.

## Driving generation with Drush

Day-to-day generation and deployment runs from the command line. All of these
require CLI/operator access (or the *Administer static generator* permission):

| Command | What it does |
|---------|--------------|
| `drush sg` | Generate everything — pages, blocks, files, and redirects. |
| `drush sgp [path] [--queued]` | Generate pages, optionally under a path or via the queue. |
| `drush sgpt <type> <bundle> [start] [length]` | Generate pages for one entity type/bundle (optionally a range). |
| `drush sgb [--frequent \| block_id]` | Generate blocks — all, only frequently-changing ones, or a single block. |
| `drush sgf [--public \| --code]` | Generate/deploy public files and/or code files via rsync. |
| `drush sgr` | Generate redirect rules. |
| `drush sgd [--pages \| --esi \| all]` | Delete generated pages / ESI fragments / everything (with a confirmation prompt). |

There is **no web deletion route** — removing generated files is Drush-only, by
design.

## How automatic regeneration works

If you use Content Moderation, the module queues a node's static page for
regeneration when its state becomes *published*, and deletes the static page when
the state becomes *archived*. This is scoped to the node bundles you configured on
the per-type settings page, and processed by a queue worker on cron.

## A word on shell safety

The `rsync`, `mkdir -p`, and `rm -rf` command strings are assembled from your
configuration values (plus the Drupal root and directory scans) **without shell
quoting**. No visitor input ever reaches them, but a careless or malicious value
in those config fields is effectively command injection on the Drupal server.
Because only *Administer static generator* holders can set those values, restrict
that permission to trusted administrators.

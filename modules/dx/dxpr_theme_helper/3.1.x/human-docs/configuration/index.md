# Configuration

DXPR Theme Helper has no single settings form. Instead you work with three things:
its two **blocks**, its per-node **page-layout fields**, and its **`dxt:*` Drush
command suite** (including the AI generators). This page covers each.

## The blocks

Place both from **Structure → Block layout** (`/admin/structure/block`).

### DXPR Theme Full Screen Search

A toggle button that opens a full-screen search overlay. Its settings are:

| Setting | Default | What it does |
|---|---|---|
| **Search provider** | `core` | Use `core` (the Core Search block form) or `search_api` (a Search API Block form). The `search_api` option only works when the `search_api_block` module is enabled; otherwise it is disabled and the block falls back to Core Search. |
| **Search URL** | `/search` | The path of the search-results page or view. |
| **Search parameter** | `search_api_fulltext` | The query-parameter name the results page expects (for example `keys` or `search_api_fulltext`). |

If neither Core Search nor Search API Block is available, the block renders nothing
and shows an error.

### User registration form

Renders the user-registration form. It has no settings of its own and only displays
for **anonymous** visitors, and only when your site's registration setting is not set
to "administrators only".

## Per-node page-layout fields

The module ships five fields as *optional* configuration. The field **storage**
already exists once the module is enabled, but the fields are **not attached to any
content type by default** — attach the ones you want via **Manage fields** on a
content type (or in code). Once attached, editors set them when editing a node.

| Field | Type | What it controls |
|---|---|---|
| **Page layout** (`field_dth_page_layout`) | list | `fullwidth` or `boxed`. |
| **Main content width** (`field_dth_main_content_width`) | list | The content column width (full, 1/3, 1/2, 2/3, 5/6). |
| **Hide regions** (`field_dth_hide_regions`) | list (multi) | Which theme regions to hide on this page (navigation, header, footer, sidebars, …). |
| **Body background** (`field_dth_body_background`) | media (image) | A per-node body background image. |
| **Page title background** (`field_dth_page_title_backgrou`) | media (image) | A per-node page-title background image. |

You can also set a node's layout fields from the command line with `dxt:page:set`
(below).

## The `dxt:*` Drush command suite

All commands live under the `dxt:` namespace. State-changing commands support
`--dry-run` (preview safely) and `--theme=<name>` (target a specific subtheme).

> **Targeting a theme:** the `dxt:config:*` and `dxt:palette:*` commands read and
> write a DXPR Theme's settings, so a DXPR Theme (or subtheme) must be installed —
> otherwise they error with "No DXPR theme found. Specify one with --theme."
> `dxt:config:list` works without one.

### Theme settings

| Command | Alias | What it does |
|---|---|---|
| `dxt:config:get <key>` | `dxt-cg` | Print a setting's value with its schema metadata. |
| `dxt:config:set <key> <value>` | `dxt-cs` | Change a setting (validated against schema; CSS is rebuilt). |
| `dxt:config:list` | `dxt-cl` | List settings; `--section`, `--detail`, `--keys-only`, `--sections-only`. |
| `dxt:config:export` | `dxt-ce` | Export settings as import-compatible YAML (`--file`, `--section`). |
| `dxt:config:import <file>` | `dxt-ci` | Import settings from YAML (validates all values first). |
| `dxt:config:reset` | `dxt-cr` | Reset a section (or all) to schema defaults. |
| `dxt:palette:get` | `dxt-pg-colors` | Show the palette and its Bootstrap variable/class mapping. |
| `dxt:palette:set <colors…>` | `dxt-ps-colors` | Set palette colors as `key=#hex` pairs. |

A typical flow is to introspect valid values before setting one:

```bash
drush dxt:config:list --sections-only
drush dxt:config:list --section=header --detail    # types, options, ranges, defaults
drush dxt:config:set header_top_layout centered
drush dxt:palette:set base=#6C3CE1 basetext=#ffffff accent1=#00D4FF
```

### Node layout

| Command | Alias | What it does |
|---|---|---|
| `dxt:page:get <nid>` | `dxt-pg` | Read a node's DXPR layout fields. |
| `dxt:page:set <nid>` | `dxt-ps` | Set them: `--layout` (fullwidth\|boxed), `--hide-regions` (csv), `--content-width` (full\|1-3\|1-2\|2-3\|5-6). |

These operate on the `field_dth_*` fields, which must be attached to the node's
content type first (see above).

### Subtheme and AI-assistant setup

- `dxt:subtheme:create [name]` (`dxt-sc`) — create a DXPR Theme subtheme from the
  starterkit.
- `dxt:setup-ai` (`dxt-sa`) — install AI-assistant skill files (`--host=claude|agents`)
  into the project root so coding tools discover the `dxt:*` commands.

## AI color-palette and font generators

Two commands turn a natural-language prompt into validated DXPR Theme settings:

| Command | Alias | What it does |
|---|---|---|
| `dxt:generate:palette "<prompt>"` | `dxt-gp` | Generate a color palette from a description. |
| `dxt:generate:fonts "<prompt>"` | `dxt-gf` | Generate a font pairing from a description. |

Both accept `--apply` (write the result to the theme), `--dry-run`, and `--theme`.

```bash
drush dxt:generate:palette "Modern tech startup" --apply
drush dxt:generate:fonts "Clean editorial" --dry-run
```

They require the optional **`drupal/ai`** module installed and configured with a chat
provider and default model, plus DXPR Theme installed (the palette fields come from
the theme's color settings). The palette generator asks the model to return colors
with WCAG-AA contrast between text and background pairs and validates that every
value is a 6-digit hex color. Without `drupal/ai` configured, both commands report
that the AI module is not available. The same generators back the HTTP endpoints used
by the DXPR Theme settings UI (both gated by the *administer themes* permission).

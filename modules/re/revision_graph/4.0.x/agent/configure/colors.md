<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure lane colours

The only configuration is which colour the graph draws each branch (= language) in.

- **UI:** Administration › Configuration › Content authoring › Revision Graph
  (`/admin/config/content/revision-graph`, route `revision_graph.settings`).
- **Permission:** `administer revision graph` (title "Administer Revision Graph"). This gates the
  settings form only; it does **not** gate viewing the graph.
- **Config object:** `revision_graph.settings` (schema `config/schema/revision_graph.schema.yml`).

Colour resolution, in order (first that applies wins), all resolved **server-side**:
1. `branch_colors[langcode]` — an explicit override for that branch.
2. The colour the module ships for that language code (a 95-entry built-in table; not stored in
   config — lives in `ColorSettings::LANGUAGE_COLORS`).
3. `palette` — a colour proposed by hashing the branch name onto this list (rarely reached, since
   an ordinary branch is a language code the shipped table covers).

## Config keys

```yaml
# revision_graph.settings
palette:                 # sequence of '#rrggbb' strings; last-resort proposal list.
  - '#a43631'            # empty -> falls back to the 7 shipped defaults (below), not to one flat colour.
  - '#d07e3f'
  - '#6209d4'
  - '#08c6cd'
  - '#e136a7'
  - '#076cfd'
  - '#8e4299'
branch_colors: {}        # sequence keyed by branch name -> '#rrggbb'. Empty by default.
```

Both are stored **parsed** (normalised). Colours are normalised to lowercase `#rrggbb`
(`#ABC`, `abc`, `#aabbcc` all become `#aabbcc`). A `branch_colors` key is a branch name (a
langcode for this module); an override for a language the site does not have is inert, not an error.

## Set it via drush

The form's textareas map to these keys. Set the config directly:

```bash
# Override German to a specific colour.
drush config:set revision_graph.settings branch_colors.de '#1a7f37' -y

# Replace the proposal palette (a sequence: set element by index, or the whole key).
drush config:set revision_graph.settings palette.0 '#a43631' -y
```

The settings form (`\Drupal\revision_graph\Form\SettingsForm`) accepts free-text: `branch_colors`
as one `name|#rrggbb` pair per line (splits on the *last* `|`, so a branch literally named `a|b`
keeps its name), `palette` as one `#rrggbb` per line. Invalid lines are reported per-line on save;
clearing `palette` stores an empty list and the page/client falls back to the shipped seven.

The resolved palette and branch colours are attached to the graph page as
`drupalSettings.revisionGraph.palette` / `.branchColors` and consumed by the JS renderer.

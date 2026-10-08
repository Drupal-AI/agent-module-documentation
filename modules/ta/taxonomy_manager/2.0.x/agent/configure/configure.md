# Configure — tree admin UI, operations & settings

## The tree admin UI

Routes (defined in `taxonomy_manager.routing.yml`):

| Route | Path | Purpose |
|---|---|---|
| `taxonomy_manager.admin` | `/admin/structure/taxonomy_manager/voc` | List vocabularies (perm: `access taxonomy manager list`) |
| `taxonomy_manager.admin_vocabulary` | `/admin/structure/taxonomy_manager/voc/{taxonomy_vocabulary}` | The Fancytree editor for one vocabulary (form `TaxonomyManagerForm`) |
| `taxonomy_manager.admin_vocabulary.add` | `.../{voc}/add` | Mass-add terms modal (`AddTermsToVocabularyForm`) |
| `taxonomy_manager.admin_vocabulary.delete` | `.../{voc}/delete` | Bulk-delete modal (`DeleteTermsForm`) |
| `taxonomy_manager.admin_vocabulary.move` | `.../{voc}/move` | Move / re-parent modal (`MoveTermsForm`) |
| `taxonomy_manager.admin_vocabulary.export` | `.../{voc}/export` | Export CSV (`ExportTermsForm`) |
| `taxonomy_manager.admin_vocabulary.exportlist` | `.../{voc}/export/list` | Export list (`ExportTermsMiniForm`) |
| `taxonomy_manager.taxonomy_term.edit` | `/taxonomy_manager/term/{taxonomy_term}/edit` | Term edit form (entity form op `taxonomy_manager`) |
| `taxonomy_manager.term_form` | `/ajax/taxonomy_manager/term/{tid}/edit` | AJAX term-data callback |
| `taxonomy_manager.subtree` / `.child_parents` | `/taxonomy_manager/subtree...` | JSON endpoints that lazy-load tree children |

The editor form (`taxonomy_manager_vocabulary_terms_form`) renders a `taxonomy_manager_tree`
render element (Fancytree), a **Toolbar** fieldset (Add, Delete, Move, Export CSV, Export list,
a vocabulary switcher `select`, and a Search autocomplete), a pager, and an AJAX-loaded
term-data form. Toolbar buttons open modal dialogs via AJAX callbacks
(`OpenModalDialogCommand`). If a vocabulary is empty, the page shows only the add form.

### Operation semantics (from source)

- **Add** — textarea, one term per line. A line prefixed with `-` (one dash per level) becomes
  a child of the previously added term at that depth; a leading-dash name kept as a top-level
  term is wrapped in double quotes. `name{delimiter}description` splits name from description
  (delimiter is configurable, default `|`). Terms selected in the tree become parents of the
  new terms. Optional "Create in order provided" sets sequential weights after the last term.
  Names over the term-name field length are truncated (255 by default) with a warning.
- **Delete** — bulk deletes selected terms; an option "Delete children of selected" also removes
  orphans, otherwise orphaned children are re-parented (to remaining parents or root).
- **Move** — re-parents selected terms; option "Keep old parents and add new ones" preserves
  existing parents for multi-parent hierarchies instead of replacing them.
- **Edit** — clicking a term loads its full edit form beside the tree and saves over AJAX.
  Weights can also be nudged up/down (saved instantly via AJAX).

## Settings — `taxonomy_manager.settings` (the `configure` route)

Form `TaxonomyManagerAdmin` at `/admin/config/user-interface/taxonomy-manager-settings`.
Config object `taxonomy_manager.settings` (schema in `config/schema/`), so it exports with
`drush config:export`. Keys and defaults (`config/install/taxonomy_manager.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `taxonomy_manager_pager_tree_page_size` | `500` | Terms per tree page (select of 25–10000) |
| `taxonomy_manager_description_delimiter` | `"|"` | Splits name from description on mass-add import |
| `taxonomy_manager_disable_mouseover` | `0` | Disable hover weight/link controls (speeds up the tree) |
| `taxonomy_manager_translations` | `false` | Show translatable term fields side-by-side per language (needs `content_translation`) |

Set from the CLI, e.g. `drush cset taxonomy_manager.settings taxonomy_manager_pager_tree_page_size 100`.

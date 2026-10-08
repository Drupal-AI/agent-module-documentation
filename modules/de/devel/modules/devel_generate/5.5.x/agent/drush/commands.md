# Devel Generate Drush commands

From `src/Drush/Commands/` (Drush 13+). Each maps to a `DevelGenerate` plugin.

| Command | Generates |
|---|---|
| `devel-generate:content` (`genc`) | Nodes (+ comments/aliases/authors). |
| `devel-generate:users` (`genu`) | Users. |
| `devel-generate:terms` (`gent`) | Taxonomy terms. |
| `devel-generate:vocabs` (`genv`) | Vocabularies. |
| `devel-generate:menus` (`genm`) | Menus and links. |
| `devel-generate:media` | Media entities. |
| `devel-generate:block-content` | Custom block content. |

Typical: `drush genc 50 5` (50 nodes, up to 5 comments each). Most accept `--kill` to delete
existing items first, `--bundles=`, `--languages=`, and count arguments. Run
`drush <command> --help` for the full option list of each generator.

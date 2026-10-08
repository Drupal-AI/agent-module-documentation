# Configuration

Most of your time with Taxonomy Manager is spent in the tree editor itself, but a
small settings form and a set of permissions govern how it behaves and who can use
it.

## Settings form

Go to **Configuration → User interface → Taxonomy Manager settings**
(`/admin/config/user-interface/taxonomy-manager-settings`). It writes to the
`taxonomy_manager.settings` config object (which exports with `drush
config:export`). The options are:

- **Tree page size** (`taxonomy_manager_pager_tree_page_size`, *default: 500*) — how
  many terms load per page in the tree, chosen from a select ranging 25–10000.
  Lower it for very large vocabularies if the tree feels slow; raise it to see more
  terms at once.
- **Description delimiter** (`taxonomy_manager_description_delimiter`, *default:
  `|`*) — the character that separates a term name from its description when you
  mass‑add terms with `name|description` lines.
- **Disable mouse‑over** (`taxonomy_manager_disable_mouseover`, *off by default*) —
  turn off the hover weight/link controls on tree rows. Disabling them can speed up
  a large tree.
- **Show translations** (`taxonomy_manager_translations`, *off by default*) —
  display translatable term fields side by side per language. Requires the core
  **Content Translation** module to be configured.

Set any of these from the command line too, for example:

```bash
drush cset taxonomy_manager.settings taxonomy_manager_pager_tree_page_size 100
```

## The toolbar operations

Inside the tree editor, selecting terms enables the toolbar:

- **Add** — a textarea where you paste terms, one per line. Prefix a line with
  dashes (`-`, `--`, …) to make it a child at that depth; use the description
  delimiter to import a description on the same line. Terms selected in the tree
  become the parents of the new terms, and an option can assign sequential weights
  in the order provided.
- **Delete** — bulk‑deletes the selected terms. An option also deletes their
  orphaned children; otherwise orphans are re‑parented to remaining parents or to
  the root.
- **Move** — re‑parents the selected terms. An option keeps the old parents and adds
  the new one, creating multi‑parent relationships instead of replacing them.
- **Export CSV / Export list** — export the vocabulary's terms.
- **Search** and the **vocabulary switcher** let you jump to a term or change
  vocabulary without leaving the page.

Clicking a single term loads its full edit form beside the tree, saved over AJAX.

## Permissions

Taxonomy Manager leans on core Taxonomy permissions and adds a few of its own.

Permissions the module defines:

| Permission | What it allows |
|-----------|----------------|
| **Access taxonomy manager list** | Reach the vocabulary list, the tree editor, the settings form, and the tree's data endpoints. |
| **Taxonomy manager export csv for *(vocabulary)*** | Use the Export CSV button for that vocabulary (one per vocabulary). |
| **Taxonomy manager export list for *(vocabulary)*** | Use the Export list button for that vocabulary (one per vocabulary). |

Core Taxonomy permissions gate the actual term operations:

- **Administer taxonomy** — full access to every operation on every vocabulary
  (grant this for unrestricted use).
- **Create terms in *(vocabulary)*** — shows the **Add** button.
- **Edit terms in *(vocabulary)*** — gates **Move** and inline term editing.
- **Delete terms in *(vocabulary)*** — shows the **Delete** button.

So a non‑admin editor needs **Access taxonomy manager list** plus the relevant
per‑vocabulary create/edit/delete term permissions:

```bash
drush role:perm:add editor 'access taxonomy manager list'
drush role:perm:add editor 'edit terms in tags'
```

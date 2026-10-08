# Configure book

All settings live in the single config object **`book.settings`** (schema:
`config/schema/book.schema.yml`, defaults: `config/install/book.settings.yml`).
`configure` route = `book.settings`.

## Routes (from book.routing.yml)

| Route | Path | Gate |
|---|---|---|
| `book.settings` | `/admin/structure/book/settings` | perm `administer book settings` |
| `book.admin` | `/admin/structure/book` (all-books overview) | perm `administer book outlines` |
| `book.admin_edit` | `/admin/structure/book/{node}` (re-order pages) | perm `administer book outlines` |
| `book.book_delete_confirmation_form` | `/admin/structure/book/delete/{book_id}` | perm `delete book` |
| `book.render` | `/book` (list of all books) | perm `access book list` |
| `entity.node.book_outline_form` | `/node/{node}/outline` (place/move a node) | `_access_node_book_outline` |
| `entity.node.book_remove_form` | `/node/{node}/outline/remove` | `_access_node_book_outline` + `_access_book_removable` |
| `book.node_child_ordering` | `/node/{node}/child-ordering` | perm `administer book outlines` |
| `book.export` | `/book/export/{type}/{node}` (e.g. type `html`) | node view + `_access_node_book_print` |

## book.settings keys

| Key | Type / default | Meaning |
|---|---|---|
| `allowed_types` | sequence of `{content_type, child_type}` (default `{}` = empty) | Which node bundles may join a book, and the allowed child type for each. `child_type` must be one of the selected `content_type`s (validated by `ExistsIn`). If empty, no type can be added to books. |
| `book_sort` | string `weight` (default) or `title` | Sibling ordering: manual weight, or automatic by title. |
| `truncate_label` | bool, default `true` | Truncate long titles in outline/select widgets. |
| `use_parent_selector` | bool, default `true` | Show the parent-page select widget on the node form. |
| `use_alternative_form` | bool, default `false` | Experimental alternative book-outline form on node edit. |

## Set via Drush (preferred over UI)

```bash
# Allow the "page" content type in books, children also "page"
drush config:set book.settings allowed_types.0.content_type page -y
drush config:set book.settings allowed_types.0.child_type page -y
# Sort siblings by title instead of weight
drush config:set book.settings book_sort title -y
```

Changing `allowed_types` fires `BookSettingsSaveEventSubscriber`, which reacts to
newly (dis)allowed types. The module cannot be uninstalled while any book outline
still exists (`BookUninstallValidator`).

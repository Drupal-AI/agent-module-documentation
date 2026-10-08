# Configure LocalGov Publications

There is **no settings form** (`configure` is null). Configuration is the content model plus a set of
one-time install actions the module performs on core config. All operational config below is shipped
in `config/install/` and `config/localgov/`.

## Content types

| Type (machine name) | Purpose | Key fields |
|---|---|---|
| `localgov_publication_page` | A page/chapter of a publication. Arranged into a Book outline to form the hierarchy; single-page publications are allowed. | `body`(via base) rendered through fields below, `localgov_publication_content` (paragraphs), `localgov_published_date`, `localgov_updated_date` |
| `localgov_publication_cover_page` | Optional landing page that links to one or more publications and can offer downloadable documents. | `localgov_publication` (entity_reference → publication root nodes, via the `publication_entity_reference_widget` view), `localgov_documents` (entity_reference → `media:document`, cardinality -1), `localgov_publication_content`, `localgov_publications_banner`, `localgov_published_date`, `localgov_updated_date`, `body` |

Both types are `new_revision: true`, `display_submitted: false`, and are placed in the `main` menu by
default (menu_ui third-party settings). A `localgov_publications_banner` paragraph type
(fields: `localgov_title`, `localgov_publications_text`, `localgov_image`, `localgov_url`) is also
provided for cover pages.

`localgov_publications_is_publication_type($type)` (in the `.module`) is the canonical check for
"is this one of the two publication node types".

## Book (hierarchy) integration

- On install, `localgov_publication_page` is appended to `book.settings.allowed_types` so editors can
  build outlines with it (`localgov_publications_install_book_settings()`).
- **Re-order route** `publication.admin_edit` → `/admin/structure/publications/{node}` reuses
  `\Drupal\book\Form\BookAdminEditForm`; requirements `_permission: 'administer book outlines'` **and**
  `_entity_access: 'node.view'`, `node: \d+`. `localgov_publications_form_book_admin_edit_alter()`
  relabels its Save button.
- The node add/edit forms are altered (`_localgov_publications_node_form_alter()`): the Book select is
  relabelled "book"→"publication" throughout, filtered so publication pages can only be added to
  publication books (and non-publication books hide publication roots), and a validation
  (`localgov_publications_validate_node_form()`) forces the editor to pick "new publication" or an
  existing one. "Add child page" links on publication nodes are rewritten to create a
  `localgov_publication_page` (`localgov_publications_node_links_alter()`).
- The **book admin listing** route `book.admin` has only its controller swapped
  (`LocalgovPublicationsRouteSubscriber`, priority -300) to
  `LocalgovPublicationsBookController::build()`, which lists all books **except** publication books
  (access unchanged: core's `administer book outlines`).
- When the `book` module is installed, `localgov_publications_modules_installed()` **deletes** the
  stock `node.type.book` content type and its dependent optional config, and cleans the leftover
  `book` bundle from the `entity.definitions.bundle_field_map` key-value store (repeated for existing
  sites by `hook_update_10001`). So enabling Book does not add a "Book" content type.

## Pathauto URLs + tokens

Two pathauto patterns are shipped:

| Pattern id | Applies to | `pattern` |
|---|---|---|
| `publication_page` | `localgov_publication_page` | `[node:localgov-publication-path]/[node:title]` |
| `localgov_publication_cover_page` | `localgov_publication_cover_page` | `publications/[node:title]` |

Install adds `localgov-publication-cover-page-alias` and `localgov-publication-path` to
`pathauto.settings.safe_tokens` (prevents double-escaping). `hook_update_10002` migrates old installs
from the legacy `[node:localgov-publication-cover-page-alias]/[node:book:parents:join-path]/[node:title]`
pattern to the new `localgov-publication-path` one. See [../api/api.md](../api/api.md) for what the
tokens resolve to. When a cover page is saved, every page in each referenced publication has its alias
regenerated (`localgov_publications_entity_insert`/`_update` → `localgov_publications_update_path_aliases()`,
deliberately ordered after pathauto via `hook_module_implements_alter`).

## Heading-id filter (needed by the ToC block)

On install, `localgov_publications_install_filter()` enables the `localgov_publications_heading_ids`
filter on the **`wysiwyg`** text format with `keep_existing_ids: TRUE`. This adds `id` anchors to
`h2`–`h6` headings so the table-of-contents block can link to them. Config schema key:
`filter_settings.localgov_publications_heading_ids` → `{ keep_existing_ids: boolean }`. See
[../api/api.md](../api/api.md) for the plugin.

## Set config via drush/PHP

```php
// Add the page type to Book's allowed types (what install does):
$c = \Drupal::configFactory()->getEditable('book.settings');
$c->set('allowed_types', array_unique(array_merge($c->get('allowed_types') ?: [], ['localgov_publication_page'])))->save();

// Enable the heading-id filter on a text format:
$f = \Drupal\filter\Entity\FilterFormat::load('wysiwyg');
$f->setFilterConfig('localgov_publications_heading_ids', ['status' => TRUE, 'settings' => ['keep_existing_ids' => TRUE]])->save();
```

`drush pmu`/`en`: enabling `book` after this module still triggers the book-type removal above.

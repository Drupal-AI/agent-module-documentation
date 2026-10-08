<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Tree Menu (book_tree_menu) — agent index

Makes core Book's navigation render the **whole book outline as an always-expandable tree menu**
instead of only expanding the branch you are currently on. It does this without adding any block,
route, form or permission of its own: a service-provider swaps the `book.manager` service class, and
a replacement `book-tree.html.twig` re-renders the tree with expand/collapse markup. The tree still
appears in core Book's own **"Book navigation"** block — you place/enable that block as usual.

Version **3.0.1**, core `^10 || ^11`. Requires contrib **`drupal/book` ^2.0** (the D11 Book module).
No settings page (`configure` is null), no permissions, no Drush, no config, no plugin types.

- **How the tree is built / the `book.manager` service override** → [api/book-manager.md](api/book-manager.md)
- **The `book_tree` theme hook and the template override (re-theming the tree)** → [theme/book-tree.md](theme/book-tree.md)

Key facts:
- `BookTreeMenuServiceProvider::alter()` (in `Drupal\book_tree_menu`) rewrites the `book.manager`
  service definition to the class `Drupal\book_tree_menu\oscBookManager`.
- `oscBookManager extends Drupal\book\BookManager` and overrides one method:
  `bookTreeAllData(int $bid, ?array $link, ?int $max_depth, ?int $min_depth)`. It builds the tree
  with **no `expanded` restriction**, so the full outline (all branches, all depths) is returned
  regardless of the active page.
- Node access is still enforced: the override calls the inherited `bookTreeBuild()`, which runs
  `bookTreeCheckAccess()` → `bookLinkTranslate()` (`$node->access('view')`) and prunes any item the
  current user cannot view.
- `hook_theme()` in `book_tree_menu.module` registers theme hook **`book_tree`** with template
  **`book-tree`**, overriding core Book's `book-tree.html.twig`. The replacement emits Bootstrap-style
  `dropdown` / `dropdown-menu` / `caret` markup for client-side expand/collapse.
- No `book_tree_menu.services.yml`; wiring is entirely via the `ServiceProviderBase` alter.

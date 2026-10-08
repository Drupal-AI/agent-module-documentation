<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Blocks — the blocks & their settings

No admin settings page. Place the blocks via *Structure → Block layout* or Layout Builder. Each block
reads the current node's book outline (`$node->book['bid']`) and renders nothing off a book page.

## The four blocks (`src/Plugin/Block/`)

| Block id | Admin label | What it renders |
|---|---|---|
| `book_block_children` | Book Children Links | List of the current page's child pages (`book.outline` childrenLinks). |
| `book_block_navigation` | Book Navigation Links | Prior / up / next links (like the page-bottom nav). |
| `book_block_toc` | Book Table of Contents | The book's table of contents + a link to the top page. |
| `book_block_edit` | Book Edit Links | Combined navigation + TOC + edit links; the only configurable block. |

All extend `BookBlocksBlockBase` (abstract `BlockBase` + `ContainerFactoryPluginInterface`), injecting
the request stack, `book.manager`, and node storage.

## `book_block_edit` settings (`blockForm`)

Schema `block.settings.book_block_edit`:

| Setting | Type | Meaning |
|---|---|---|
| `css` | select | Display-style CSS class preset (default `book_blocks_edit_normal`). |
| `icons` | checkbox | Use icons instead of text. |
| `toc` | checkbox | Include the Table of Contents link/section. |
| `nav` | checkbox | Include prior/up/next navigation links. |
| `add_sibling` | textfield | "Add sibling page" link text; empty = omit the link. |
| `left_link` / `middle_link` / `right_link` | mapping (`name`, `url`, `hint`) | Custom links. `left_link` defaults to Book → `/books` (typical use: a `/book-index/{{ book_id }}` View). |

Install default (`config/install/book_blocks.settings.yml`) seeds `book_block_edit` with
`css: book_blocks_edit_normal`, `toc/nav/icons: true`, `add_sibling: 'Add sibling page'`, and a
`left_link` of Book → `/books`. The Edit block builds a collapsible TOC element with a random id
(`book-blocks-toc-element-<rand>`) so it can expand/collapse without Collapsiblock.

## Templates & cache

- Theme hooks (`.module` `book_blocks_theme()`): `book_blocks_navigation`, `book_blocks_edit`,
  `book_blocks_children`. Preprocessors expose `book_id`, `book_title`, `book_url`, `current_depth`,
  prev/parent/next url+title, `tree` (children), and add `rel=prev/up/next` head links.
- Cache contexts (`*.services.yml`): `route.book_block_toc`, `route.book_block_navigation`
  (`Drupal\book\Cache\BookNavigationCacheContext`) so output varies per book page.

## Requirement

Enable the **Book** module. On Drupal 11 Book is a contrib project (`composer require drupal/book`);
`book_blocks.info.yml` does not declare it, but the blocks/services depend on `Drupal\book\*`.

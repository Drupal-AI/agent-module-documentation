# Configuration

Book Blocks has no central settings page. You configure it by placing its blocks and, for the
Edit block, filling in its block settings form. Every block reads the current node's book
outline and renders nothing on pages that aren't part of a book, so they're safe to place
site-wide.

## Place the blocks

Go to **Structure → Block layout** (or open Layout Builder) and add whichever of the four
blocks you want:

| Block | What it renders |
|---|---|
| **Book Children Links** (`book_block_children`) | A list of the current page's child pages. |
| **Book Navigation Links** (`book_block_navigation`) | Prior / up / next links, like the page-bottom navigation. |
| **Book Table of Contents** (`book_block_toc`) | The book's table of contents, plus a link to the top page. |
| **Book Edit Links** (`book_block_edit`) | A combined navigation + TOC + edit-links block — the only configurable one. |

A typical documentation layout uses the Table of Contents in a sidebar and Navigation Links
inline, but mix and match to taste.

## Book Edit Links — settings

When you place the **Book Edit Links** block, its configuration form offers:

- **Display style** (`css`) — a CSS class preset controlling the look (default
  *book_blocks_edit_normal*).
- **Use icons** (`icons`) — show icon controls instead of text labels.
- **Include Table of Contents** (`toc`) — whether the block includes the TOC section.
- **Include navigation** (`nav`) — whether the block includes the prior/up/next links.
- **Add sibling page** (`add_sibling`) — the text for an editor-facing "add a sibling page"
  link. Leave it empty to omit the link.
- **Left / Middle / Right links** (`left_link`, `middle_link`, `right_link`) — three custom
  links, each with a **name**, **URL** and **hint** (tooltip). The **left link** defaults to
  the Book landing page (`/books`); a common customisation is to point it at a book-index View
  such as `/book-index/{{ book_id }}` so readers can jump back to a list of all books.

The install defaults seed the Edit block with the *normal* display style, the TOC, navigation
and icons enabled, an "Add sibling page" link, and the left link set to Book. The Edit block's
built-in TOC is collapsible on its own, so you don't need Collapsiblock for it.

Save the block placement as usual. The other three blocks have no settings — just place them.

## Notes

- The blocks emit `rel=prev/up/next` head links on book pages automatically, which helps SEO
  and browser prefetching.
- Output is cached per book page via book-navigation cache contexts, so the right links show on
  each page without manual cache tuning.
- The block templates (`book_blocks_navigation`, `book_blocks_edit`, `book_blocks_children`)
  can be overridden in your theme if you need custom markup.

# Configuration

TOC API's only admin screen manages **TOC types** — reusable presets that decide
how a table of contents looks and behaves. A downstream module or your custom code
picks a type by its machine name and applies its options when it builds a TOC.
Editing a type here changes the result everywhere that type is used.

## Open the TOC types screen

1. Log in as a user with the **Administer table of contents types** permission
   (an administrator by default). This one permission gates the whole screen.
2. Go to **Structure → TOC types**, or navigate directly to
   `/admin/structure/toc`.

You'll see the five pre-installed types — **default**, **simple**, **simple
numbered**, **full**, and **full numbered**. Use **Add TOC type** to create a new
one, or **Edit** on any row to change it. (Deleting a type that another module
relies on will change that module's output, so be careful with the bundled ones.)

## What a TOC type controls

Each type is a set of options. When you add or edit a type, the form groups them
into general, header, "back to top", and numbering sections. The most useful
options are:

- **Template** — which style renders the TOC: a nested **tree** outline, a
  **menu** (a `<select>` jump menu), a **responsive** version that shows the tree
  on desktop and the menu on mobile, or the plain **default** wrapper. The
  `default` type uses *responsive*.
- **Title** and its wrapper — the heading text above the TOC (default *Table of
  Contents*) and the HTML tag it sits in (default `h3`).
- **Minimum headers to show** (`header_count`) — the TOC only appears once the
  document has at least this many top-level headings. The default is **2**, so a
  page with a single heading shows no TOC at all.
- **Header range** — the lowest and highest heading levels to include, from 1 to
  6. For example, include only `h2`–`h4` and ignore `h1`, `h5`, and `h6`.
- **Anchor id strategy** — how each heading's anchor `id` is generated: from its
  **title** (slugified text), a **key**, or the **number path**. The last two can
  take a prefix (default `section`).
- **Exclude XPath** — an XPath that skips matching headings; by default it skips
  anything hidden.
- **Back to top** — the heading-level range that gets a "Back to top" link after
  it, plus the link label (default *Back to top*).
- **Numbering** — the list style (**decimal**, **upper/lower alpha**, **upper/
  lower roman**, disc/circle/square, or **none**), plus optional prefix and suffix
  text around each number (the `default` type wraps numbers as `1) `). You can
  override the numbering per heading level.

## Which type does what

The bundled presets give you sensible starting points: **simple** is an
unnumbered menu, **simple numbered** adds numbering, **full** and **full
numbered** include more heading levels and back-to-top links, and **default** is
the responsive tree/menu style. The quickest way to a custom look is to add a new
type, start from the closest bundled one's settings, and adjust from there.

## Save

Click **Save** on the add/edit form. The new options take effect the next time
anything renders a TOC with that type. Note that the form recomputes the full
options from its detail groups on save, so if you also script TOC types in code,
write the complete options map rather than relying on partial merges (see the
[`agent/`](../agent/start.md) references for details).

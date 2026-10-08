# Configuration

Setting up Citation Select is three tasks: place the block, tell it how your
fields map to citation fields, and manage which CSL styles are available. Every
admin screen below lives under `/admin/config/citation-select` and requires the
**Administer site configuration** permission.

## 1. Place the citation block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the citation to appear
   (often the content or sidebar region).
3. Choose **Citation Select Block** (in the "Citation Select" category).
4. Under the block's **Visibility** settings, restrict it to the content types you
   actually cite — otherwise it appears on every node.

The block resolves the node from the current page URL, so it always cites the page
it is shown on.

## 2. Settings form

Go to **Configuration → Citation Select** (`/admin/config/citation-select`). Here
you set the block's behavior:

- **Default style** — the CSL style shown first (ships as APA). Only *enabled*
  styles appear in the list, and you cannot delete or disable the style that is
  currently the default.
- **Show on load** — when ticked, the default style's citation renders
  immediately when the page opens. When unticked, the visitor must pick a style
  from the drop-down before a citation appears.

This form also stores the field maps described below (`csl_map`,
`reference_type_field_map`, `typed_relation_map`), though the field mapping itself
is edited on its own screen.

## 3. CSL Mapping — connect your fields to citation fields

Go to **CSL Mapping** (`/admin/config/citation-select/csl_map`). This is the heart
of the setup: for each of your node fields, choose which CSL field(s) it should
fill — for example title, author, issued date, publisher, DOI, page numbers, and
around 80 others the form lists.

Two pseudo-fields are always available even though they are not real fields:

- **title** — the node's title.
- **current url** — the node's absolute URL.

Special cases:

- **Author/editor names from a Typed Relation field** — map the field here *and*
  add its role machine names to the **Typed relation map** so the module knows
  which roles are authors, editors, contributors, and so on. The install defaults
  map `relators:aut → author`, `relators:ctb → contributor`,
  `relators:edt → editor`, and `relators:pbl → publisher`.
- **Reference type** — the **reference-type field map** turns a node's own type
  value (for example a "Paged Content" content type) into a valid CSL type such as
  `book`. Anything unmapped falls back to the generic CSL type `document`.

Citation Select already understands person names, plain strings,
entity-reference labels, standard dates, and EDTF dates out of the box; developers
can add support for other field types with a `CitationFieldFormatter` plugin (see
the [`agent/`](../../agent/plugins/citation-field-formatter.md) docs).

## 4. Manage CSL styles

Go to **CSL Styles** (`/admin/config/citation-select/csl_style`). The module ships
with APA, MLA (current and 8th edition), Chicago author-date, and American Medical
Association already enabled. To add your own:

- **Add** (`…/add`) — paste the style's CSL XML into the **CSL text** box. The
  form validates that it is well-formed XML, that the CSL id is unique, and (for
  dependent styles) that the parent style is present.
- **Add from file** (`…/add-file`) — upload a `.csl` or `.xml` file; its contents
  become the CSL text after the same validation.
- **Edit / Delete** — standard entity forms. Remember you cannot disable or delete
  whichever style is set as the default.

Only **enabled** styles show up in the block's style selector.

## How it all comes together

When a visitor changes the style in the block, Citation Select rebuilds the
citation with AJAX: it reads your field map to assemble the node's data as
CSL-JSON, resolves the reference type, cleans the values for safe output, and
hands the result to `citeproc-php`, which renders it in the chosen style and the
current interface language. That last point means citations come out multilingual
automatically.

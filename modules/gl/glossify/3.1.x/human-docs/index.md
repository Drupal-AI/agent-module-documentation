# Glossify — manual setup guide

**Glossify** (`glossify`) is an API/base module that provides the shared machinery for
text-format filters that scan your rendered text and automatically turn matching entity
labels into glossary **links** or hover **tooltips**. Think of a domain glossary where
every mention of a defined term links to its definition page, or shows the definition in
a tooltip on hover — without editors having to add any markup by hand.

On its own, Glossify does nothing user-facing. It ships the abstract filter engine and
the templates; you activate it by enabling one of its **submodules**, each of which
sources its term list from a different place:

- **Glossify Node** (`glossify_node`) — match against node titles.
- **Glossify Taxonomy** (`glossify_taxonomy`) — match against taxonomy terms.
- **Glossify Commerce** (`glossify_commerce`) — match against commerce products
  (requires Drupal Commerce).

Once a submodule is enabled you add its filter to a text format, and from then on the
matching happens at display time — your stored content is never modified. The engine is
careful: it skips text already inside links or `<abbr>` elements, honours a
`glossify-exclude` CSS class for opting text out, can link only the first occurrence of
each term, supports a configurable URL pattern with an `[id]` token, and can match
alternate spellings via a **synonyms** field.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose a submodule.

## Where it lives in the admin menu

Glossify has no settings page of its own. You configure it wherever text formats are
configured: **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). Each Glossify filter is enabled and configured on a
specific text format.

## How to use it

1. Enable the base module **and** the submodule that matches your term source (see
   [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the text format you want glossified (for
   example *Full HTML*).
3. In the **Enabled filters** list, tick the Glossify filter provided by your submodule.
4. Expand the filter's settings (under **Filter settings**) to tune its behaviour:
   - **Tooltip vs link vs both** — render matches as `<abbr>` tooltips, as links, or as
     both.
   - **First occurrence only** — link only the first mention of each term per field.
   - **Case sensitivity** — match terms case-sensitively or not.
   - **URL pattern** — where links point, using an `[id]` token for the target entity.
   - **Ignore tags** — HTML tags to skip (e.g. `h1,h2,strong`).
   - **Synonyms field** — a plain-text field whose values are treated as alternate
     spellings of the term.
5. Save the text format. Content displayed through that format now has its matching
   terms auto-linked or tooltipped.

Handy details: wrap any text in `class="glossify-exclude"` to keep it from being
glossified, long tooltip definitions are truncated to 300 characters automatically, and
the output tooltips are keyboard-focusable (`tabindex="0"`) for accessibility.
Developers can override the `glossify_link` / `glossify_tooltip` templates to change the
markup, or narrow the term source with the filters' query-alter hooks.

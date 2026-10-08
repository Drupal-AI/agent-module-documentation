# Configuration

This module has no settings page of its own. You configure it as a **processor on
each Search API index** — so its settings live wherever your index is defined.

## Add the processor to an index

1. Go to **Configuration → Search and metadata → Search API** and edit the index
   you want to clean.
2. Open the **Processors** tab
   (`/admin/config/search/search-api/index/<id>/processors`).
3. Tick **HTML Element Filter** to enable it.
4. Its settings appear lower on the page. Fill them in (below), then **Save**.
5. **Re-index** the index so existing content is re-processed with the new rules
   (new and updated content is processed automatically going forward).

## Settings — field by field

- **CSS Selectors** *(required)* — a textarea where you list the elements to
  remove, **one selector per line**. Any valid CSS selector works: a tag name, a
  class, an id, or a combination. For example:

  ```
  .sidebar-filters
  .advert
  nav
  ```

  During indexing, every element matching one of these selectors is removed from
  the field's markup before it is indexed. If you enter a selector the parser
  can't understand, the form flags it when you save; at runtime an invalid
  selector is simply skipped, so it can never break indexing.

- **Enable post-process query** *(checked by default)* — when ticked, the same
  stripping also runs over the field values of returned result items, so search
  result snippets and highlighting are cleaned too. Untick it if you only want to
  clean the index itself and leave rendered results untouched.

## Which fields it applies to

Like other Search API field processors, it offers the standard field-selection
controls, so you can run it on all your text/fulltext fields or restrict it to
specific ones. Choose whichever fields carry the boilerplate you want removed.

## Good to know

- The filter only does anything when a field's value contains **HTML**. A
  plain-text field with no markup is left untouched — there is nothing for a CSS
  selector to match.
- Matching is done against each field's HTML and the matched nodes are removed
  from the DOM, so the surrounding text and other elements are preserved.
- After changing selectors, remember to **re-index** for the change to apply to
  already-indexed content.

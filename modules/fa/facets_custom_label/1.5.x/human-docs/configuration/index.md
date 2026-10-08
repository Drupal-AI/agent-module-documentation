# Configuration

Facets Custom Label has no global settings page. You configure it per facet, by
enabling its processor and filling in a list of label mappings.

## Open the facet and enable the processor

1. Go to **Configuration → Search and metadata → Facets**
   (`/admin/config/search/facets`) and edit the facet whose items you want to
   relabel.
2. Scroll to the **Processors** section (the list of transformations applied to
   the facet).
3. Tick **Facets custom label processor** to enable it.

A **Replacement values** textarea appears once the processor is enabled — this is
the only setting.

## Write the mappings — the Replacement values textarea

Enter **one mapping per line**, in this format:

```
origin|value|new label
```

The three parts are separated by the pipe character `|`:

- **origin** — how to match the facet item. Use one of two letters:
  - `r` — match the item's **raw value**: its machine name, or an entity ID such
    as a node or term ID. Example: `r|article|Awesome news` relabels the
    content-type item `article` to *Awesome news*.
  - `d` — match the item's **display value**: the title or term name that's
    currently shown. Example: `d|Apple|Apple products` relabels the item that
    currently reads *Apple* to *Apple products*.
- **value** — the raw value or display value to look for (matching the `origin`
  you chose).
- **new label** — the text visitors should see instead.

A few examples together in the box:

```
r|article|Awesome news
r|1|Published
d|Apple|Apple products
d|en|English
```

### Rules and limits

- Lines that don't contain at least two `|` separators are ignored.
- Raw-value (`r`) mappings are applied first, then display-value (`d`) mappings,
  for each facet item.
- A display value that itself contains a `|` pipe character is **not** supported.
- Only the visible label is changed. The item's raw value, the search query, and
  the result counts are untouched — so counts and filtering keep working exactly
  as before.

## Mind the processor order

The custom-label processor runs at the facet's **build** stage. If another
processor sets or transforms the labels you're trying to match (for example a
processor that turns IDs into names), make sure that processor runs **before**
this one, or your `d|…` display-value matches may not line up. The Processors
section lets you order and weight the processors accordingly.

## Save

Click **Save** on the facet. Reload the search page and the facet items now show
your custom labels.

## Translating labels

To provide different custom labels per language, enable core **Configuration
Translation** and translate the facet's configuration. The Replacement values are
part of the facet config, so they become translatable strings.

Taxonomy Container adds an entity-reference selection handler that renders a taxonomy term reference field as a single `<select>` where each top-level (parent) term becomes an `<optgroup>` and its descendant terms become the selectable options.

---

The module ships one plugin, `TermSelection` (id `taxonomy_container`, group `taxonomy_container`), which extends core's taxonomy `TermSelection`. You enable it per field by setting the field's **Reference method** to "Taxonomy term selection (with groups)" on the field settings form; there is no global config page (`configure` is null) and no permissions. When chosen, `getReferenceableEntities()` walks each target vocabulary with `loadTree()`, turns every root term (parent target_id `0`) into an optgroup label, and nests its children under it, prefixing each child label with a configurable character (default `-`) repeated per depth level. Deeper hierarchies are flattened into their top-level group — only the first level produces the optgroup, so a three-level tree still renders as one group per root with indented children. Term labels are run through `Html::escape()` and each term is access-checked with `->access('view')`; children of an inaccessible parent are also hidden. The handler exposes one extra setting, `prefix` (a 1–5 character string, schema `entity_reference_selection.taxonomy_container`), and hides core's "Create referenced entities if they don't already exist" (auto_create) options because grouped options are not compatible with autocomplete auto-creation. When a match string or limit is supplied (i.e. autocomplete), it falls back to the parent's flat behaviour.

---

- Render a taxonomy term reference field as a grouped `<select>` instead of a flat list or autocomplete.
- Turn each root/parent term into an `<optgroup>` heading in the dropdown.
- Present child terms indented under their parent group with a prefix character.
- Give content editors a clearer picture of vocabulary hierarchy while selecting a term.
- Restrict selection so only leaf/child terms are picked while parents act as non-selectable group headers.
- Change the indentation character (e.g. `-`, `–`, `»`) shown before child terms via the `prefix` setting.
- Increase indentation depth automatically for deeper terms (prefix repeats per depth level).
- Use grouped selection on a node's category field backed by a hierarchical vocabulary.
- Apply grouped selection to a media, user, or paragraph entity-reference field targeting terms.
- Limit the field to specific vocabularies and still get per-vocabulary grouping.
- Respect term view access so users never see terms they may not view in the dropdown.
- Replace the default checkbox/radio widget UX for hierarchical taxonomies with a compact grouped select.
- Avoid autocomplete for small-to-medium hierarchical vocabularies where a visible tree is friendlier.
- Configure the reference method purely through the field settings UI without writing code.
- Keep auto-create disabled deliberately so editors cannot accidentally spawn new terms from this widget.
- Provide a consistent grouped dropdown across multiple content types referencing the same vocabulary.
- Support both numeric and string term IDs (the plugin loose-compares parent id to `'0'`).
- Fall back to standard flat matching when the field is used with autocomplete (match/limit supplied).
- Model a two-level taxonomy (section → topic) as select optgroups without a contrib widget.
- Improve accessibility/scannability of long term lists by chunking them under headings.

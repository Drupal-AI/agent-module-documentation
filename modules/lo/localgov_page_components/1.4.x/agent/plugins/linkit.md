# LinkIt plugins

Two LinkIt plugins let rich-text authors link to reusable page components
(`paragraphs_library_item` entities) and resolve them to sensible URLs.

## Matcher — `PageComponentMatcher`
`src/Plugin/Linkit/Matcher/PageComponentMatcher.php`, annotation:
```
@Matcher(
  id = "entity:paragraphs_library_item",
  label = "Page components",
  target_entity = "paragraphs_library_item",
  provider = "paragraphs_library"
)
```
Extends LinkIt's `EntityMatcher`. `paragraphs_library_item` has **no bundle**, so the plugin
temporarily swaps `$this->targetType` to `paragraph` while building the summary and config form
so the admin can restrict/group by *Paragraph* bundle instead. Overrides:
- `getSummary()` / `buildConfigurationForm()` — borrow the paragraph entity's bundle fields
  (`bundle_restrictions`, `bundle_grouping`).
- `execute($string)` — runs the entity query without bundle conditions (library items have none),
  merges URL-based results, then filters by `isTargetParagraphBundle()` (does the item's referenced
  paragraph belong to a configured bundle?). **Each surviving entity is checked for `view` access
  via `$entity->access('view', $this->currentUser, TRUE)`** before a suggestion is created.
- `buildGroup()` — group label = entity type label + ` - ` + paragraph bundle.

## Substitution — `ParagraphsLibraryItem`
`src/Plugin/Linkit/Substitution/ParagraphsLibraryItem.php`, `@Substitution(id =
"paragraphs_library_item_localgovdrupal", label = "Page components")`. `getUrl()` reads the URL
out of the referenced paragraph instead of returning the useless `/admin/content/paragraphs/N`:

Hardcoded bundle→field map (`PARAGRAPH_TO_URL_FIELD_MAPPING`):
- `localgov_contact` → `localgov_contact_url`
- `localgov_link` → `localgov_url`

For a mapped bundle it reads that field: `link`-type → `->getUrl()`; `string`-type →
`Url::fromUri(value)`; empty → `base:`. Unmapped bundles fall back to the item's canonical URL.
`isApplicable()` returns true only for entity type `paragraphs_library_item`.

## Extending
There is no config form for the substitution mapping (LinkIt substitutions don't support one),
so supporting more bundles/fields means subclassing `ParagraphsLibraryItem` and overriding
`PARAGRAPH_TO_URL_FIELD_MAPPING` / `getUrl()`, or patching the map. The matcher can be
subclassed like any LinkIt `EntityMatcher`.

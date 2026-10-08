<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Basic Content Info analyzer (`content_info`)

`src/Plugin/Analyze/ContentInfo.php` — `final class ContentInfo extends AnalyzePluginBase`.

## Definition

```
@Analyze(
  id = "content_info",
  label = @Translation("Basic Content Info"),
  description = @Translation("Provides basic statistics about content for Analyzer.")
)
```

## Dependencies injected (`create()` / constructor)

Base three (`analyze.helper`, `current_user`, `config.factory`) plus `entity_type.manager`,
`renderer`, `language_manager`.

## What it renders

`renderSummary(EntityInterface $entity)` returns an `analyze_table`:

- `#table_title` = `'Basic Info'`
- rows: `['label' => 'Word count', 'data' => getWordCount($entity)]` and
  `['label' => 'Image count', 'data' => getImageCount($entity)]`

`getFullReportUrl()` returns `NULL`, so there is no full-report route/link (the parent's access
check treats the URL as overridden and denies the per-plugin report route).

## How the counts are computed

- `getHtml($entity)` — resolves the current langcode from `language_manager`, builds the entity's
  view with `entity_type.manager->getViewBuilder($type)->view($entity, 'default', $langcode)`,
  renders it via `renderer->render()`, and casts to string. So counts cover the **whole default
  display**, not a single field.
- `getWordCount()` — `strip_tags()` the HTML, replace `&nbsp;` with a space, then
  `str_word_count()`. Returns int (default 0).
- `getImageCount()` — `preg_match_all('/<img/', $html, $matches)` and `count($matches[0])`.

## Enable / operate

1. `drush en analyze_basic_content_info` (pulls in `analyze`).
2. Enable "Basic Content Info" per entity type/bundle at Configuration > Content > Content
   Analysis, or in the bundle edit form's "Analyze settings" section (perm `administer analyze`).
3. Grant `view analyze reports` to roles that should see the tab.
4. Open any enabled entity's canonical page → "Analyze" tab → "Basic Info" table.

## Notes

- Summary-only analyzer; a good reference for `renderSummary()` returning `analyze_table` and for
  suppressing the full report via `getFullReportUrl(): NULL`.
- Rows' `data` values are cast to string by `analyze_preprocess_analyze_table` and escaped by the
  `analyze_table` twig (`{{ row['data']|t }}`); here they are integers, so nothing is user-markup.
- Rendering the full default view on each uncached tab load costs a full entity render — a
  performance note for very large content, not an access concern.

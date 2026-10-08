# LocalGov Core — plugins

## Blocks

- **`localgov_page_header_block`** (`PageHeaderBlock`) — renders a page header (title / subtitle /
  lede) derived from the current route's entity or View. Dispatches `PageHeaderDisplayEvent` so other
  code can override the content, visibility, or cache tags (see api/services.md). Themed via
  `localgov_page_header_block` (variables: `title`, `subtitle`, `lede`, `entity`) with per-bundle/type
  template suggestions.
- **`localgov_powered_by_block`** (`PoweredByLocalGovDrupal`) — outputs a "Powered by
  [LocalGov Drupal](https://localgovdrupal.org/)" span; `label_display` off by default.

## Field widget

- **`localgov_entity_reference_labels`** (`LabelsWidget`, for `entity_reference` fields) — displays
  referenced entities as read-only labels with a hidden `target_id` and preserved delta/weight
  (reorderable), removing the autocomplete and "Add more" controls. Use when references are populated
  elsewhere but their order remains editable (e.g. overview/landing pages).

## Linkit matchers (autocomplete label overrides)

- **`entity:node`** (`NodeMatcher` extends Linkit's node matcher) — `buildLabel()` HTML-escapes the
  node label and prepends `Unpublished: ` for unpublished nodes.
- **`EntityMatcher`** — LocalGov variant of the generic entity matcher (base label behaviour for
  other entity types).

## Views display extender

- **`localgov_page_header_display_extender`** (`PageHeaderDisplayExtender`, `no_ui = FALSE`) — adds
  page-header options to Views displays so a View page can supply the header title/lede (works with
  the Page Header block/event). Exposes options + a settings form on the View display.

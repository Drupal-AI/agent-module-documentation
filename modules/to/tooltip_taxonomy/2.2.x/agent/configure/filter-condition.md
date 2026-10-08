# Configure Tooltip Taxonomy

## The `filter_condition` config entity

Config entity type `filter_condition` (`config_prefix: filter_condition`; full config name
`tooltip_taxonomy.filter_condition.<cid>`), defined in `src/Entity/FilterCondition.php`,
`admin_permission = administer site configuration`. Exported keys:

| Key | Meaning |
|---|---|
| `cid` | machine id |
| `name` | label |
| `weight` | ordering; higher weight overrides same term name from lower-weight conditions (ambiguous terms) |
| `vids` | vocabularies whose terms become tooltips |
| `path` | `request_path` condition config (`pages`, `negate`) — which paths this applies to |
| `contentTypes` | `entity_bundle:node` condition config (`bundles`, negate forced 0) |
| `field` | list of `entitytype-fieldname` keys; empty = all text fields |
| `view` | view modes (`0` in the list means "all") |
| `formats` | text formats this condition applies to (matched against the field's `#format`) |
| `allowed_html_tags` | tags kept in the tooltip description (default `<b> <i> <strong> <span> <br> <a>`) |
| `excluded_tags` | space/comma list of HTML tag names in which term replacement is skipped (e.g. `h1 h2 strong`) |

## UI / routes

List/add/edit/delete under `/admin/config/content/tooltip_taxonomy` (form `FilterConditionForm`,
list builder `FilterConditionListBuilder` — a draggable weight list). All four routes require permission
`administer site configuration` **or** `administer filters` (comma = OR in `tooltip_taxonomy.routing.yml`).
`configure` route = `entity.tooltip_taxonomy.config`.

Form fields map 1:1 to the keys above: `vids` (checkboxes, required), `formats` (checkboxes, required),
`view` (checkboxes), the core path condition, the content-type condition (negate removed), a `field` select
(multiple; only unlocked configurable text fields on nodes — `body` or `field_*` of type text/text_long/
text_with_summary/string_long), `allowed_html_tags`, and `excluded_tags`. Saving invalidates the `node_view`
cache tag.

## How tooltips are injected (runtime)

`tooltip_taxonomy.module`:
- `hook_entity_display_build_alter()` iterates a content entity's rendered fields; for each field that
  `isContentField` (name is `body` or starts `field_`) and `isTextField` (text/text_long/text_with_summary/
  string_long) it calls `TooltipManager::addTooltip($view_mode, $entity, $field_name, $value, $tags)` and
  replaces `#text` with the returned markup. Adds cache tags `tooltip_taxonomy:<cid>` and attaches the
  `tooltip_taxonomy/simple_tooltip` CSS library.
- `hook_taxonomy_term_presave()` invalidates the matching condition cache tags so tooltips refresh when a term
  changes.

`Drupal\tooltip_taxonomy\Services\TooltipManager`:
- `checkPathAndContentType()` filters conditions by the path + content-type conditions.
- For each matching condition it also enforces view-mode, field, and text-format scoping, then
  `addVocabularyReplacement()` loads accessible terms and builds a whole-word regex
  (`/\b<preg_quote name>\b/`) → replacement = the isolated render of the `tooltip_taxonomy` theme element.
- `replaceContent()` walks the HTML, applying replacements only in text segments (never inside tags) and
  skipping the interior of any configured `excluded_tags` block; duplicate/substring term matches are pruned.

## Escaping (security-relevant, but sanitized)

In `addVocabularyReplacement()` the term description is run through
`Xss::filter($term->get('description')->value, $allowed_tags_array)` before it is placed into the
`#description` variable of the theme element; the term **name** goes through `#term_name` and is autoescaped by
the Twig template. So term-derived text is sanitized when injected — even though term descriptions may be
editable by lower-privilege term editors, `Xss::filter` strips scriptable markup (the project also ships an
`XSSInjectionTest`). Not a vulnerability; just note that the set of kept tags is the condition's
`allowed_html_tags`.

## Field formatter

`Plugin/Field/FieldFormatter/TooltipTaxonomyFormatter.php` (id `tooltip_taxonomy`) is applicable to
`entity_reference` fields targeting `taxonomy_term`. It renders each referenced term via the same theme hook;
the description is passed through `strip_tags($text, $allowed_html_tags)` (formatter setting `allowed_html_tags`,
default `<b><i><strong><span><br><a>`). Choose it on *Manage display* for a taxonomy reference field.

## Text-format requirement

For the display-alter tooltips to survive text-format filtering, the field's text format must allow the tooltip
markup — add `<span class="tx-tooltip tx-tooltip-text">` to the format's Allowed HTML (see README / the
`tooltip_taxonomy_update_8101` install hook that migrates the older class names).

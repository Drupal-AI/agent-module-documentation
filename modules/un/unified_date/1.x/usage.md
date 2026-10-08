Unified Date adds a single `unified_date` timestamp base field to every node and syncs a per-content-type date source into it, so content types with different date fields can be sorted and filtered together on one consistent value.

---

Sites that list several content types together (e.g. publications, articles, events, job vacancies) often store their "important date" in different fields — a datetime field, a date range's end value, a Smart Date value, or just the core created/changed timestamp. Sorting or filtering such a mixed list by date is awkward because there is no common column. Unified Date solves this by declaring one `timestamp` base field, `unified_date`, on the node entity (via `hook_entity_base_field_info`) and, on every node presave, copying the value of the bundle's chosen source field into it. You configure the mapping at `/admin/config/content/unified-date`; bundles left unset fall back to the node's created time. Existing content is backfilled with a batch form or the `unified-date:write-all` / `unified-date:write-missing` Drush commands. The field is then available to Views (with a dedicated `unified_datetime` filter), to a `[node:unified_date]` token, and to any query, and other modules can adjust the computed value through `hook_unified_date_alter()`. It requires core `node` and `datetime`; administration is limited to users with `administer site configuration`.

---

- Sort a mixed listing of several content types by one shared date column.
- Give publications, articles, events and job vacancies a common sort key.
- Map each content type to the date field that matters for it.
- Use a datetime field on one bundle and the created date on another, unified into one value.
- Sort on the `end_value` of a date range field rather than its start.
- Include Smart Date (`smartdate`) or Date range timezone (`daterange_timezone`) fields as the unified source.
- Fall back to the node created time for content types with no configured date field.
- Build a "recent content" block across content types ordered by the unified date.
- Add an exposed `unified_datetime` Views filter with custom min/max labels.
- Offer a grouped date filter with a custom "Specific dates" range in Views.
- Filter a Views listing by a strtotime-style relative date on the unified field.
- Backfill unified dates for all existing nodes after first configuring the module.
- Populate only nodes that are missing a unified date value, leaving others untouched.
- Re-run a bulk update after changing the per-bundle field mapping.
- Restrict a bulk backfill to selected content types via the batch form checkboxes.
- Rewrite unified dates from the command line with `drush unified-date:write-all`.
- Write missing unified dates for one content type with `drush unified-date:write-missing article`.
- Print the unified date in text with the `[node:unified_date]` token.
- Use `[node:unified_date:custom:...]` and other date sub-tokens in messages or templates.
- Feed a consistent date into Search API or a "related content" list across bundles.
- Adjust the computed value programmatically with `hook_unified_date_alter()`.
- Keep the unified value automatically in sync as editors save nodes.
- Sort RSS or JSON feeds that aggregate multiple content types by one date.
- Provide a single column to power a cross-type archive or calendar listing.

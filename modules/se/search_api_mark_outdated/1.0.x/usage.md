<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Mark Outdated visually flags rows in a Search API view whose content has been edited since the search index last indexed it.

---

The point of the module is to close a small but confusing gap: after you edit content, the search index does not update instantly — indexing usually runs on cron or in a queue — so for a while your Search API views keep showing the old, indexed version. This module makes that staleness visible instead of silent. Whenever a **content entity** is saved, it records that entity's Search API item id(s) in Drupal `State` (one entry per index, keyed `search_api_mark_outdated_<index_id>`), for every translation; when Search API later reindexes those items it fires the `ITEMS_INDEXED` event and the module clears them again. You surface the flag by adding the Views field **"Search API mark outdated field"** to a view built on a Search API index. The field renders a hidden `<div data-is-outdated="0|1">` for each row, and — when its `add_row_class` option is on (the default) — attaches a small JS behavior that adds the CSS class `search-api-outdated` to the row's `<tr>`, which your theme can then style (a badge, a background tint, a "may be out of date" note). Note two things: "outdated" means **index-stale, not old** — it is unrelated to how long ago content was authored and there is no time threshold to configure; and the JS row class assumes a **table** row style, so for a non-table view you turn the option off and style the `[data-is-outdated="1"]` attribute directly. There is no settings page, permission, or drush command — the only configuration is that one checkbox on the Views field.

---

- Flag search-result rows whose indexed copy is out of date.
- Warn editors that a page they just edited is not yet reindexed.
- Show a "may be outdated" badge on stale Search API view rows.
- Tint or outline stale rows in a search results table.
- Add the "Search API mark outdated field" to a Search API view.
- Keep the default `add_row_class` option to auto-add the `search-api-outdated` class.
- Turn `add_row_class` off and style the `data-is-outdated` attribute yourself.
- Style stale rows in a non-table view via the `[data-is-outdated="1"]` attribute.
- Give a QA reviewer a visual cue that a result predates the latest edit.
- Reassure editors that outdated markers clear automatically once cron reindexes.
- Track index staleness per Search API index in Drupal State.
- Flag every translation of an edited entity, not just the current language.
- Read the outdated state from custom code via the manager service.
- Manually mark or clear items as outdated from a script.
- Explain to a content team why edits do not appear in search immediately.
- Highlight rows to prioritise a manual reindex.
- Distinguish freshly edited content from already-indexed content in a view.
- Add a visual freshness cue without changing the search backend.
- Document the module's index-staleness behaviour for the team.
- Review its assumptions after a Search API or Drupal upgrade.

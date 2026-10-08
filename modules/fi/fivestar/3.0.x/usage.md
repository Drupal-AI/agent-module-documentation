<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fivestar adds a clean, AJAX-powered n-star rating widget to Drupal entities on top of Voting API. It ships a `fivestar` field type with star widgets and formatters, plus a reusable `fivestar` Form API element.

---

Fivestar is a rating system built on the Voting API (`votingapi`) module. Its core offering is a `fivestar` field type (class `FivestarItem`) that stores a per-item `rating` (0–100 internally) and optional `target`, and mirrors each save into a Voting API `vote` entity of a configurable **vote type** (default `vote`). It provides two field widgets — `fivestar_stars` (interactive stars) and `fivestar_select` (a plain select list) — and three field formatters — `fivestar_stars` (interactive/average stars), `fivestar_percentage` (e.g. 92), and `fivestar_rating` (e.g. 4.2/5). A pluggable widget/skin system (`hook_fivestar_widgets`) supplies the visual star sets (Basic, Craft, Drupal, Flames, Hearts, Lullabot, Minimal, Outline, Oxygen, Small), each backed by a CSS library. Field settings control the number of stars, whether users may clear/re-vote/vote on their own content, whether rating happens *while viewing* or *while editing*, and an optional "voting target" that also records the vote against a bridged entity via an entity-reference field. Three services do the heavy lifting: `fivestar.vote_manager` (cast/query votes), `fivestar.vote_result_manager` (read aggregated results from Voting API), and `fivestar.widget_manager` (discover star skins). A single permission, **rate content**, gates voting. There is no central admin settings page — the `configure` route declared in the info file (`fivestar.admin_overview`) is not actually registered, so all configuration is per field on the Manage fields / form display / display pages.

---

- Add a star rating field to Articles or any content type so visitors can rate them.
- Let users rate a node directly on its full view (rate-while-viewing) with AJAX, no page reload.
- Collect an author's self-assessment on edit forms (rate-while-editing) instead of on view.
- Show the community **average** rating as filled stars using the `fivestar_stars` formatter.
- Display a numeric rating like "4.2/5" with the `fivestar_rating` formatter.
- Display a percentage score like "92" with the `fivestar_percentage` formatter.
- Offer an accessible non-JS rating via the `fivestar_select` widget (a select list).
- Change the star skin (Hearts, Flames, Oxygen, …) per field display without writing CSS.
- Use a custom number of stars (1–10) instead of the default five.
- Let anonymous users vote (subject to the "rate content" permission and Voting API).
- Allow or forbid users changing their vote (`allow_revote`) or clearing it (`allow_clear`).
- Prevent authors from rating their own content (`allow_ownvote`).
- Record a rating on a related/parent entity too via the "voting target" bridge field.
- Rate users, comments, taxonomy terms or media — any fieldable entity, not just nodes.
- Provide a "quality", "satisfaction" or custom **vote type** so one entity can carry several rating axes.
- Programmatically cast a vote from custom code with `fivestar.vote_manager->addVote()`.
- Read the aggregated average/count for an entity with `fivestar.vote_result_manager->getResults()`.
- Register a custom star skin from your own module via `hook_fivestar_widgets()`.
- Rename or remove built-in star skins with `hook_fivestar_widgets_alter()`.
- Deny or force voting access with `hook_fivestar_access()` (e.g. never let uid 1 vote).
- Embed a standalone rating control in a custom form using the `#type => 'fivestar'` element.
- Sort or filter Views by rating by exposing the underlying Voting API results.
- Build a "top rated" list by combining a fivestar field with Voting API aggregation.
- Show a static, non-interactive star display of a stored rating in a template via the `fivestar_static` theme hook.
- Theme the average/summary output with the `fivestar_summary` and `fivestar_static_element` theme hooks.
- Migrate a legacy star-rating system onto Voting API storage while keeping a familiar UI.

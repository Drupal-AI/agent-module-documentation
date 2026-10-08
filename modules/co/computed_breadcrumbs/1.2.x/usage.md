<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Computed Breadcrumbs adds a computed `breadcrumbs` field to every content entity, so an entity's breadcrumb trail can be read like any other field instead of only appearing when a page is rendered.

---

Drupal builds breadcrumbs during rendering, through breadcrumb builders that run when a page is themed. That works for a themed site and fails everywhere else: a decoupled front end fetching a node over JSON:API gets its fields and no breadcrumb, because the breadcrumb was never a property of the node — it was a property of rendering it.

This module turns the trail into data. `hook_entity_base_field_info()` attaches a computed, unlimited-cardinality base field called `breadcrumbs` to every content entity type (nodes, taxonomy terms, and so on). Reading that field runs the entity's canonical route through the HTTP kernel as an internal sub-request, asks Drupal's own breadcrumb manager to build the trail for it, and returns each step as a link item with a `uri` and a `title`. The field type extends core's Link field, so the values behave like ordinary link-field values — a View can output them, JSON:API serialises them, and a search index can store them. URLs are absolute by default; a single settings checkbox switches them to relative.

**That is the whole argument, and it is a good one for decoupled sites specifically.** Rebuilding breadcrumb logic in a front end means reimplementing the site's own hierarchy rules in a second place, where they drift.

Two things to know. **The field is computed per read** — building each trail is a full internal sub-request, so a listing of fifty entities builds fifty trails; check the cost before putting the field on a high-volume API response, and cache the response where you can. And **breadcrumbs depend on context** in core: the same entity reached through two paths can legitimately have two trails, and the field builds the one Drupal produces for its canonical route as the current user. Know which trail it picks before relying on it for navigation rather than for SEO markup.

---

- Read a node's breadcrumb trail over JSON:API.
- Give a decoupled/headless front end breadcrumb data without rendering the page.
- Expose a taxonomy term's ancestor trail as data (works on any content entity, not just nodes).
- Avoid reimplementing site hierarchy rules in a front end.
- Output a breadcrumb trail in a View as a link field.
- Store a breadcrumb trail in a Search API index.
- Generate breadcrumb structured data (schema.org BreadcrumbList) from the field.
- Keep hierarchy/breadcrumb rules in one place — Drupal's breadcrumb builders.
- Read the trail in custom code with `$entity->get('breadcrumbs')->getValue()`.
- Switch breadcrumb URLs from absolute to relative for a same-origin front end.
- Check computation cost before adding the field to a large API collection.
- Cache JSON:API/REST responses that include the field to avoid per-read sub-requests.
- Decide which contextual trail you want before relying on it for navigation.
- Handle an entity reachable by two paths (the field returns the canonical-route trail).
- Use the trail for SEO markup rather than as the primary site navigation.
- Plan navigation/breadcrumb data for a headless build up front.
- Feed breadcrumb steps into an app or mobile client as plain link data.
- Audit breadcrumb output against expectations after a content-model change.
- Verify the trail's assumptions after a core or contrib upgrade.
- Hide the field on the default entity display (it ships hidden) and expose it only where needed.
- Document the module's per-read cost for the team before rollout.

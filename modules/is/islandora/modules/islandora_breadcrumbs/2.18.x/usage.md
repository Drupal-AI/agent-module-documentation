Islandora Breadcrumbs generates node breadcrumbs by walking the `field_member_of` parent/child hierarchy, so a child object's breadcrumb trail shows its ancestor objects.

---

The submodule registers a breadcrumb builder (`IslandoraBreadcrumbBuilder`, service in
`islandora_breadcrumbs.services.yml`) that `applies()` to Islandora node routes and `build()`s a trail by
following the configured reference field(s) up the hierarchy. Behavior is controlled by
`islandora_breadcrumbs.breadcrumbs` config (settings form at `/admin/config/islandora/breadcrumbs`,
`IslandoraBreadcrumbsSettingsForm`): `referenceFields` (default `[field_member_of]`) — which entity-reference
field(s) define the parent link; `maxDepth` (default `-1`, unlimited) — how many ancestors to include; and
`includeSelf` (default `FALSE`) — whether the current node appears as the last crumb. It uses Islandora
Core's utilities to resolve ancestors. Depends on `islandora`. No permissions of its own (settings form uses
`administer site configuration`).

---

- Show a breadcrumb trail of ancestor objects for a child in a compound object.
- Reflect the `field_member_of` hierarchy in page navigation automatically.
- Configure which reference field defines the parent relationship (default `field_member_of`).
- Limit breadcrumb depth with `maxDepth` for very deep hierarchies.
- Include or exclude the current node as the final breadcrumb via `includeSelf`.
- Provide intuitive navigation for paged content (book → page).
- Support multiple parent-reference fields if your model uses more than one.
- Give collection → sub-collection → item navigation out of the box.
- Improve SEO/UX with hierarchical breadcrumbs on repository pages.
- Avoid writing custom breadcrumb code for Islandora member relationships.
- Walk unlimited ancestor levels by default (`maxDepth: -1`).
- Apply only to Islandora node routes (does not disturb other breadcrumbs).
- Change breadcrumb behavior site-wide from one settings form.
- Pair with Islandora IIIF/viewers so users can navigate up from a page to its book.
- Keep breadcrumbs in sync with membership changes since they are computed live.

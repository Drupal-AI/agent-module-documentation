Brightcove Gallery (experimental) integrates Brightcove **In-Page Experiences** (IPE) — Brightcove Gallery's interactive video-page layouts — into Drupal as local entities that can be previewed and rendered.

---

This experimental submodule (`lifecycle: experimental`) defines an `in_page_experience` content
entity and a service layer (`InPageExperienceApi`, `InPageExperienceCache`,
`InPageExperienceSettings`, plus a custom query builder) that fetches In-Page Experiences from the
Brightcove Gallery API using the credentials of the main `brightcove` module's API clients. A
settings form lives at `/admin/structure/brightcove_in_page_experience/settings`
(route `brightcove_in_page_experience.settings`, permission `administer brightcove gallery in-page
experience`) and stores config in `brightcove_gallery.settings` (default `cache_seconds: -1`). A
route subscriber wires up entity routes, an access control handler enforces the module's three
permissions, and a Twig template (`brightcove-in-page-experience-preview.html.twig`) renders a
preview. Depends on the main `brightcove` module.

---

- Import Brightcove In-Page Experiences (Gallery) into Drupal.
- Preview an In-Page Experience inside the Drupal admin.
- Manage In-Page Experience entities (view/delete) with dedicated permissions.
- Cache fetched In-Page Experience data with a configurable TTL.
- Reuse the main module's Brightcove API clients for Gallery API calls.
- Embed a Brightcove Gallery layout on a Drupal page.
- Restrict who can administer In-Page Experience settings.
- Restrict who can view or delete In-Page Experience entities.
- Evaluate Brightcove Gallery integration behind an experimental flag.
- Set a cache TTL for fetched In-Page Experience data.
- Render an In-Page Experience preview via the bundled Twig template.
- List and delete imported In-Page Experience entities from the admin UI.
- Reuse an existing Brightcove API client's credentials for Gallery API calls.
- Query In-Page Experiences with the module's custom entity query layer.
- Present a curated Brightcove video gallery layout on a landing page.
- Refresh In-Page Experience data on demand by clearing its cache.

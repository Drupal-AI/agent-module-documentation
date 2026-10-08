# Brightcove Gallery — agent index

Submodule of `brightcove` (**experimental**). Integrates Brightcove In-Page Experiences (Gallery)
as `in_page_experience` entities with preview/rendering. Settings at
`/admin/structure/brightcove_in_page_experience/settings`
(route `brightcove_in_page_experience.settings`). Depends on `brightcove`. Provides permissions +
config schema; no Drush or plugin types.

- **Settings, the entity, permissions, and the API/cache services** → [configure/settings.md](configure/settings.md)

Key facts:
- Content entity `in_page_experience`; storage/query in `src/Entity/` + `src/Query/`.
- Services: `InPageExperienceApi` (fetch from Brightcove Gallery API via a brightcove API client), `InPageExperienceCache`, `InPageExperienceSettings`.
- Config object `brightcove_gallery.settings` → `cache_seconds` (default `-1`).
- Permissions: `administer brightcove gallery in-page experience` (restricted), `view brightcove gallery in-page experience entity`, `delete brightcove gallery in-page experience entity`.
- Preview template `brightcove-in-page-experience-preview.html.twig`.

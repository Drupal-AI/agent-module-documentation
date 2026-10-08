# Configure Brightcove Gallery (In-Page Experiences)

**Experimental module** (`lifecycle: experimental`). Enable with
`ddev drush en brightcove_gallery -y`. Requires the main `brightcove` module configured with at
least one API client.

## Settings — `/admin/structure/brightcove_in_page_experience/settings`

Form `Drupal\brightcove_gallery\Form\Settings` (route `brightcove_in_page_experience.settings`,
permission `administer brightcove gallery in-page experience`). Config object
`brightcove_gallery.settings`:

| Key | Default | Meaning |
|---|---|---|
| `cache_seconds` | `-1` | TTL for cached In-Page Experience data (`-1` = per the module's cache handling). |

## Entity & services

- Content entity `in_page_experience` (storage `InPageExperienceStorage`, custom `Query`/`Condition`
  builder, `InPageExperienceListBuilder`, delete form). Routes are added by
  `src/Routing/RouteSubscriber.php`; access enforced by `InPageExperienceAccessControlHandler`.
- `InPageExperienceApi` fetches In-Page Experiences from the Brightcove Gallery API, reusing a
  `brightcove` API client's credentials; `InPageExperienceCache` caches responses;
  `InPageExperienceSettings` reads the config above.
- Preview rendered via `templates/brightcove-in-page-experience-preview.html.twig`.

## Permissions

| Permission | Gates |
|---|---|
| `administer brightcove gallery in-page experience` (restricted) | Settings form + administering IPE content. |
| `view brightcove gallery in-page experience entity` | Viewing IPE entities. |
| `delete brightcove gallery in-page experience entity` | Deleting IPE entities. |

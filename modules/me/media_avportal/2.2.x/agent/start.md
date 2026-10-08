<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media AV Portal (media_avportal) — agent index

Adds the European Commission's **Audiovisual Portal** (audiovisual.ec.europa.eu) as a Drupal media
source. An editor references a portal PHOTO, VIDEO or REPORTAGE by pasting its public URL; the module
extracts the resource **ref** (e.g. `I-183993`, `P-038924/00-15`), stores **only that ref** in a
`string` source field, and renders it as an `<iframe>` (video) or `<img>` (photo). Title and thumbnail
are pulled live from the portal's JSON API and cached. Depends on core `media`. Core `^10 || ^11`.
No settings page (`configure` null); defines no permissions of its own.

- **The two media source plugins — supported URL formats, ref extraction, metadata mapping** → [plugins/media-sources.md](plugins/media-sources.md)
- **The input widget + the three field formatters (video iframe / photo / responsive photo)** → [plugins/field-formatters.md](plugins/field-formatters.md)
- **The API client service, the `AvPortalResource` value object, the `avportal://` stream wrapper, response caching, the metadata-refresh service** → [api/client.md](api/client.md)
- **Settings config object (API / iframe / photo base URIs, cache age) + creating an AV Portal media type** → [configure/settings.md](configure/settings.md)
- **Drush: refresh stored metadata from the portal** → [drush/commands.md](drush/commands.md)

Key facts:
- Config object `media_avportal.settings`: `client_api_uri` (JSON search API), `iframe_base_uri`
  (video player), `photos_base_uri` (photo file host prefix), `cache_max_age` (seconds, default 3600;
  `0` disables caching).
- Media source plugin ids: `media_avportal_photo`, `media_avportal_video` (both `allowed_field_types = {string}`).
- Field widget id `avportal_textfield`; formatter ids `avportal_video`, `avportal_photo`, `avportal_photo_responsive`.
- Validation constraint `avportal_resource` — fails unless the stored ref resolves to a real resource.
- Stream wrapper scheme `avportal://` (service `media_avportal.photo_stream_wrapper`), read-only; resolves a photo ref to its remote file so image styles work.
- Services: `media_avportal.client` (an `AvPortalClient`, built by `media_avportal.client_factory`), `media_avportal.media_updater` (`AvPortalMediaUpdater`).
- Drush command `media-avportal:refresh-mapped-fields` (`--mids=`).
- Supported resource types (`AvPortalClient::ALLOWED_TYPES`): `VIDEO`, `PHOTO`, `REPORTAGE`.

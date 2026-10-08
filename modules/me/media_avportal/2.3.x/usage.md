<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media AV Portal makes the European Commission's Audiovisual Portal a media source in Drupal, so official EU photos, videos and reportages can be referenced from the media library by their portal URL instead of being downloaded and re-uploaded.

---

An editor pastes a portal URL (video like `https://audiovisual.ec.europa.eu/en/video/I-183993`, or a photo/album URL) into the `avportal_textfield` widget; the source plugins (`media_avportal_photo`, `media_avportal_video`) extract the resource ref and store only that in a `string` field, validating it against the `avportal_resource` constraint. Title and thumbnail are fetched live from the portal's JSON API through the `media_avportal.client` service (an `AvPortalClient` built by `media_avportal.client_factory`, modelling each item as an `AvPortalResource`) and cached for `cache_max_age` seconds. Videos render as an `<iframe>` to the corporate player via the `avportal_video` formatter; photos render as `<img>` via `avportal_photo` or `avportal_photo_responsive`, using the read-only `avportal://` stream wrapper so core image styles and responsive images work on the remote files. Because remote metadata drifts, `AvPortalMediaUpdater` (service `media_avportal.media_updater`) plus the Drush command `media-avportal:refresh-mapped-fields` re-pull stored titles and thumbnails on demand. All endpoints (`client_api_uri`, `iframe_base_uri`, `photos_base_uri`) live in the `media_avportal.settings` config object; there is no settings page. The only dependency is core `media`, on Drupal `^10 || ^11`. The 2.3.x branch moves `photos_base_uri` to the new EU photo repository (migrated by `media_avportal_post_update_photos_base_uri`), prefers the ORIGINAL image over the 1200px-capped HIGH file for photo derivatives, and adds a dedicated `logger.channel.media_avportal` channel. The module comes from the OpenEuropa (EU institutional Drupal) ecosystem and is deliberately narrow — the AV Portal specifically, not remote media in general.

---

- Reference official EU photos and videos from the media library.
- Avoid downloading and re-uploading Commission imagery.
- Embed an AV Portal video in an article as an iframe.
- Show AV Portal photos in a gallery with an image style.
- Serve AV Portal photos as responsive images.
- Keep AV Portal titles and thumbnails current with a Drush command.
- Refresh stored metadata for specific media by id (`--mids`).
- Comply with a requirement to use official EU sources.
- Reduce local storage for institutional media.
- Address portal assets through the `avportal://` stream wrapper.
- Apply core image styles to a remote portal photo.
- Generate image-style derivatives from the full-resolution ORIGINAL photo.
- Point the client at a different AV Portal API endpoint via config.
- Change the video iframe player base URL.
- Migrate a site to the new EU photo repository base URI on update.
- Tune AV Portal API response caching (or disable it).
- Reference a video the Commission later updates, then refresh it.
- Build an EU institutional site's media library.
- Combine AV Portal media with local uploads in one library.
- Validate that a pasted URL resolves to a real AV Portal resource.
- Set the maximum width/height of an embedded video.
- Support multilingual titles and captions on referenced media.
- Store only the resource ref, not a full URL, in the field.
- Use AV Portal media inside Layout Builder.
- Add photo, video and reportage assets from audiovisual.ec.europa.eu.

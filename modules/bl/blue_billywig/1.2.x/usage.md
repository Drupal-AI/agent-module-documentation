Blue Billywig integrates Drupal's core Media system with the Blue Billywig online video platform (OVP): editors browse and import existing videos, upload new ones (directly to the platform's S3 storage from the browser), and render them through configurable Blue Billywig playouts.

---

The module ships a `blue_billywig` **media source** plugin (backed by a custom `blue_billywig_id` field type/widget/formatter) so you create a media type whose items reference clips on the Blue Billywig platform. It talks to the platform through the `bluebillywig/bb-sapi-php-sdk` Composer library, wrapped by the `blue_billywig.client` service (`BlueBillywigClient`) which handles search, embed-code, playout, upload, content-protection and accessibility calls (with 1-hour caching of playouts/embed codes/policies and Solr query escaping for search). Global connection settings live at `/admin/config/media/blue-billywig` (`blue_billywig.settings`, permission `administer blue_billywig`): publication subdomain, optional client identifier, API key ID + secret, default playout, embed type (JavaScript/iframe), debug logging, and feature toggles for accessibility, content protection and delete-sync. A custom **Media library add form** searches the platform and imports clips; uploads use one of two paths — when key+secret are set, the JS **Uppy** widget requests presigned S3 URLs via three POST controller routes (`initializeUpload` / `completeUpload` / `abortUpload`, all gated by the `upload videos to blue_billywig s3` permission) and uploads directly to S3 (up to ~20 GB, multipart), otherwise it falls back to a normal Drupal file field uploaded through the SDK. The **embed formatter** (`blue_billywig_embed_code`) fetches ready-made embed markup from the platform per clip/playout/embed-type. Two extra per-media forms (gated by `media.update`) let editors request Scribit.Pro accessibility assets (`field_bb_accessibility_requested`) and assign a content-protection policy (`field_bb_cpp`, custom `blue_billywig_cpp` select widget); those fields are added by update hooks to every media type using the source. Deleting a Drupal media entity optionally deletes the platform clip (`enable_delete_sync`), and cron cleans up uncompleted uploads after 4 hours. Depends on core Media (Media Library recommended).

---

- Create a Blue Billywig media type that references videos hosted on the OVP.
- Browse and import existing Blue Billywig clips via the Media Library "Add media" flow.
- Search the platform by keyword (title) from the media library, scoped by client identifier.
- Upload large videos (up to ~20 GB) directly from the browser to S3, bypassing the web server.
- Use multipart, parallel uploads for big files via the bundled Uppy widget.
- Fall back to a standard Drupal file upload when API key/secret are not configured.
- Embed videos on the front end using a chosen Blue Billywig playout.
- Switch embed output between JavaScript and iframe embed types.
- Set a site-wide default playout and embed type, overridable per view-mode formatter.
- Add a media reference field to a content type and pick the "Media library" widget for BB videos.
- Restrict who can upload to the platform via the `upload videos to blue_billywig s3` permission.
- Restrict who can configure the integration via the `administer blue_billywig` permission.
- Validate API credentials against the platform on settings save and on the status report.
- Request Scribit.Pro accessibility assets (audio description, subtitles, transcript) for a clip.
- Track which clips have accessibility requested via the `field_bb_accessibility_requested` field.
- Assign a content-protection policy (CPP) to a video from a live list of platform policies.
- Preview a policy's hide/tease behaviour and rulesets before applying it.
- Automatically delete the platform clip when the Drupal media entity is deleted (delete-sync).
- Clean up orphaned/uncompleted uploads automatically via cron (4-hour limit).
- Enable debug logging so the Uppy widget logs upload detail to the browser console.
- Filter platform search results to a specific publication/client via the client identifier setting.
- Call the `blue_billywig.client` service from custom code to search, load, embed, or upload clips.
- Cache playouts, embed codes and content-protection policies for an hour to reduce API calls.
- Serve videos with adaptive streaming and monetization handled by the Blue Billywig platform.
- Migrate from older AWS-credential versions (update hook removes the old AWS config keys).

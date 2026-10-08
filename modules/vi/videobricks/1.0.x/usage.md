<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds the 42videobricks SaaS video platform (upload, transcode, DRM streaming, player) to Drupal as a media source and admin library.

---
The module registers a `videobricks` media source so editors can create media entities backed by 42videobricks-hosted videos, with a dedicated field type, widget and formatter that embeds the service's player. An admin area under `/admin/config/videobricks` provides an API settings form (`VideobricksSettingsForm`) for the API key and environment (sandbox/staging/production), a library listing (`VideobricksLibraryController`), an add form, and video init/finalize controllers that drive the chunked upload handshake with the remote API. All calls go through the vendor `Api42Vb\Client` SDK over Guzzle to the fixed per-environment HTTPS hosts (`api-sbx`/`api-stg`/`api`.42videobricks.com); the API key is sent as the `x-api-key` header and validated on settings save.

Every route is gated by the `administer 42videobricks` permission (marked `restrict access: true`), so the whole surface is admin-only. TLS uses the SDK/Guzzle defaults (verification on) and the endpoint host is not user-controllable (no SSRF); the API key is saved in module config (`videobricks.settings`). Setup: obtain a 42videobricks API key, enter it and pick an environment, then use the library/add flow or the media source to attach videos.
---
- Register 42videobricks as a Drupal media source.
- Create media entities backed by remotely hosted videos.
- Embed the 42videobricks player via a field formatter.
- Provide a video field type and widget for entities.
- Configure the API key and environment (sandbox/staging/production).
- Validate the API key against the service on save.
- Browse the 42videobricks video library in the admin UI.
- Add a new video from the admin area.
- Initialise a chunked video upload (init controller).
- Finalize a chunked video upload (finalize controller).
- Look up a video by ID during widget validation.
- Restrict all video administration to the `administer 42videobricks` permission.
- Switch between sandbox, staging and production endpoints.
- Attach hosted videos to content via a media field.
- Rely on the vendor SDK for API communication over HTTPS.
- Use transcoded/DRM-protected streaming from Drupal content.

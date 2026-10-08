Cloudflare Stream integrates the Cloudflare Stream video platform as a Drupal field: uploaded videos are pushed to your Cloudflare account (via resumable TUS upload) and played back through Cloudflare's embed player, with an optional Media source.

---

The module adds a `cloudflarevideo` field type (extending core's file field), a `cloudflarevideo_default` widget (extending `FileWidget`), and matching video and thumbnail formatters. A `cfstream://` stream wrapper backs the field: writes go to a local temp file, then on stream close the module initiates a TUS resumable upload to Cloudflare's Stream API, stores the returned video id in a private tempstore for the field's `preSave`, and deletes the local copy. Reads proxy the Cloudflare API for video details, and `getExternalUrl()` builds the `https://<subdomain>.cloudflarestream.com/<id>/watch` playback URL. Two services do the work: `cloudflare_stream` (reads config) and `cloudflare_stream.api` (a Guzzle client wrapping the Cloudflare Stream REST API — upload, TUS init, list, details, delete, token verify). Credentials — API token, account id, customer subdomain, and a debug-messages toggle — are entered at `/admin/config/media/cloudflare-stream/settings` (config object `cloudflare_stream.settings`; the settings form verifies the token against Cloudflare before saving). A `cloudflare_stream` Media source plugin lets you build a Media type whose source field is a Cloudflare video, restricting uploads to a fixed video-extension whitelist. Two permissions gate the config area: `access cloudflare stream config page` and `administer cloudflare stream settings`. The bundled **Cloudflare Stream - Sync** submodule imports videos that already exist in your Cloudflare account back into Drupal as Media items. Depends on core `media`.

---

- Add a video field to a content type that stores/serves the video via Cloudflare Stream.
- Upload large videos with resumable TUS uploads instead of a single blocking POST.
- Offload video encoding, storage, and adaptive delivery to Cloudflare's network.
- Embed the Cloudflare player with configurable controls, autoplay, loop, mute, width, height.
- Show a Cloudflare-hosted thumbnail for a video via the thumbnail formatter.
- Keep (or discard) the original uploaded file locally after pushing to Cloudflare.
- Create a Media type backed by Cloudflare Stream (media source `cloudflare_stream`).
- Restrict uploads to supported video extensions (mp4, mkv, mov, webm, etc.).
- Build a reusable video library as Media entities streamed from Cloudflare.
- Configure API token, account id, and customer subdomain in one settings form.
- Validate the Cloudflare API token on save so bad credentials are caught early.
- Delete a Cloudflare video automatically when the Drupal file/field is removed.
- Reference a `cfstream://<video-id>` URI through Drupal's stream-wrapper system.
- Import existing Cloudflare videos into Drupal Media via the Sync submodule.
- Automate periodic import with the `drush cloudflarestream:sync` (alias `css`) command (Sync submodule).
- Surface Cloudflare API errors on the frontend for debugging via the debug-messages toggle.
- Serve responsive, device-appropriate video without building your own transcoding pipeline.
- Play videos from a customer subdomain URL (`<subdomain>.cloudflarestream.com/<id>/watch`).
- Add multiple display variants of the same video by cloning the formatter settings.
- Gate access to the credentials/config screens with dedicated permissions.

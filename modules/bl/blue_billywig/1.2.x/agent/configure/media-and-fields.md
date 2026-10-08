# Media type, fields, upload & embed

How the media source, field plugins, upload paths, and the two per-media workflow forms fit together.

## 1. Create the media type

1. *Structure → Media types → Add media type* (`admin/structure/media/add`).
2. Set **Media source = Blue Billywig**. The source (`Plugin\media\Source\BlueBillywig`, id
   `blue_billywig`) allows only the `blue_billywig_id` field type and provides its own
   `media_library_add` form (`MediaLibraryAddForm`). It auto-creates/reuses the source field storing
   the platform clip id. Source config schema `media.source.blue_billywig` adds
   `thumbnails_directory`.
3. Save. Update hooks add two extra fields to every BB media type:
   - `field_bb_accessibility_requested` (boolean) — `blue_billywig_update_10001`.
   - `field_bb_cpp` (string, content-protection policy code) with the `blue_billywig_cpp` widget on
     the default form display — `blue_billywig_update_10003`.

## 2. Reference the media from content

Add a **Media** reference field to your content type pointing at the BB media type and use the
**Media library** widget. On the content edit form, *Add media* opens the BB media library
(`MediaLibraryAddForm`) where editors search the platform and import clips, or upload new ones.

## 3. Field plugins (all `no_ui` / auto-selected)

| Plugin | Id | Notes |
|---|---|---|
| Field type | `blue_billywig_id` | `StringItem` subclass, `no_ui`, cardinality 1. Stores the clip id. |
| Widget | `blue_billywig_id` | `BlueBillywigWidget` (extends `StringTextfieldWidget`). New items: shows the **Uppy** upload widget when key+secret are set, else a plain file upload. Existing items: renders a video preview. |
| Formatter | `blue_billywig_embed_code` | `BlueBillywigFormatter` (extends `StringFormatter`). Renders platform embed markup. Settings `playout` + `embed_type` (default to site settings). |
| CPP widget | `blue_billywig_cpp` | `BlueBillywigCppWidget` — select of live content-protection policies; hidden (`#access` FALSE) when `enable_content_protection` is off, preserving the stored value. |

## 4. Display / embed formatter

On the BB media type's **Manage display**, set the source field formatter to **"Blue Billywig embed
code"** and pick a **Playout** and **Embed type** (or leave "- Site defaults -" to inherit
`blue_billywig.settings`). `BlueBillywigFormatter` calls `client->embedCode(id, playout, embed_type)`
which returns the platform-generated embed markup (cached 1h) rendered via `Markup` — the markup is
produced by the Blue Billywig platform, not user input.

## 5. Upload paths (from `BlueBillywigWidget` + `S3UploadController`)

- **Uppy → direct-to-S3 (when `key` and `secret` are configured):** the widget requests presigned
  URLs via three POST routes, all gated by permission `upload videos to blue_billywig s3`:
  - `blue_billywig.s3.initialize_upload` → `S3UploadController::initializeUpload` — validates
    `filename`/`filesize`/`contentType`, rejects non-video MIME types
    (`ALLOWED_VIDEO_TYPES`), then `client->initializeUpload()` creates a mediaclip and returns
    presigned URLs / chunk data.
  - `blue_billywig.s3.complete_upload` → `completeUpload` — finalizes the multipart upload.
  - `blue_billywig.s3.abort_upload` → `abortUpload` — aborts it.
  Files go straight from the browser to S3 (up to ~20 GB, multipart), bypassing the web server.
- **Fallback file upload (no key/secret):** a normal Drupal file field; the file is uploaded through
  the web server then pushed to the platform via `client->uploadFile()` (subject to
  `upload_max_filesize` / `post_max_size`).
- Uncompleted uploads are tracked in key-value store `blue_billywig.s3.uploads` and cleaned up by
  cron after `UNCOMPLETED_S3_UPLOADS_LIMIT` (4 hours).

## 6. Per-media workflow forms (permission: `media.update` on the entity)

- **Request accessibility** — `blue_billywig.request_accessibility` →
  `/media/{media}/blue-billywig/request-accessibility` (`AccessibilityRequestForm`). Confirmation
  form that submits a Scribit.Pro transcription job (audio description, subtitles, transcript;
  Dutch, male voice) via `client->requestAccessibility()` and sets
  `field_bb_accessibility_requested`. Shown only when `enable_accessibility` is on.
- **Content protection** — `blue_billywig.content_protection` →
  `/media/{media}/blue-billywig/content-protection` (`ContentProtectionForm`). Assigns a
  content-protection policy (`field_bb_cpp`) chosen from `client->getContentProtectionPolicies()`,
  with a preview of the policy's hide/tease behaviour and rulesets. Shown only when
  `enable_content_protection` is on.

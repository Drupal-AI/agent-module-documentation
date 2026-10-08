<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lightning Media is the media authoring layer from the Lightning distribution: it upgrades core Media with live source previews on media forms, "type or drop anything and we work out the media type" input matching, an in-library visibility flag, extra view modes, and eight optional component submodules that each ship a ready-made media type.

---

The base module owns no media types of its own; it improves the plumbing. Its central idea is `Drupal\lightning_media\InputMatchInterface`: media source plugins that implement `appliesTo($value, MediaTypeInterface $type)` can be asked "can you handle this file / URL / embed code?", and `MediaHelper` (service `lightning.media_helper`) uses that to turn arbitrary input into an unsaved media entity (`createFromInput()`), to list matching bundles (`getBundlesFromInput()`), or to collect every accepted file extension (`getFileExtensions()`). The submodules supply input-matching subclasses of the core source plugins via `hook_media_source_info_alter()` plus `Override::pluginClass()`. `hook_entity_type_alter()` swaps the media entity form for `Drupal\lightning_media\Form\MediaForm`, which renders a **live preview** of the source field as you type (any source whose plugin definition carries `preview`), and toggles the media revision UI from `lightning_media.settings:revision_ui`. A `media_type` insert hook adds a `field_media_in_library` boolean to every new media type, and `hook_views_pre_view()` filters the media library widget views to items where it is TRUE, giving editors a "hide from library" switch. Two extra media view modes ship (`embedded`, `thumbnail`), plus optional config for a `rich_text` text format/editor, a `media/[media:bundle]/[media:mid]` Pathauto pattern and two roles (`media_creator`, `media_manager`) that only install when `lightning_roles` is present. When Entity Browser and Inline Entity Form are installed it registers two EB widgets — `file_upload` and `embed_code` — and it decorates Entity Embed: the dialog form is swapped for its own (honouring `lightning_media.settings:entity_embed.choose_display`) and a `media_image` Entity Embed display plugin renders an embedded item through the image formatter. Image fields also gain two third-party widget settings (`file_links`, `remove_button`). Configuration is a single settings form at `/admin/config/system/lightning/media`.

---

- Give editors a live preview of a YouTube URL or tweet while they are still filling in the media form.
- Let editors paste any URL or drop any file and have Drupal pick the right media type automatically.
- Hide working files from the media library with the per-item "Show in media library" checkbox.
- Turn the media revision UI on for a compliance-driven editorial workflow.
- Render embedded media in CKEditor through an image formatter instead of the raw thumbnail.
- Stop editors choosing an embed display and force the `embedded` view mode for every embed.
- Add an `embedded` view mode used specifically for in-body media rendering.
- Give every media type a consistent `thumbnail` view mode for library grids.
- Add an Entity Browser "File Upload" widget that creates media entities directly from uploads.
- Add an Entity Browser "Embed Code" widget that creates media entities from a pasted URL or embed code.
- Validate an uploaded file against the *matching* media type's own extension and resolution limits.
- Collect the union of all accepted file extensions to build an upload widget's `#upload_validators`.
- Give image widgets a "hide the Remove button" or "do not link to uploaded files" option.
- Give a media library "Add via URL" form for oEmbed-style sources such as tweets and Instagram posts.
- Install a `media/<bundle>/<id>` Pathauto pattern for media canonical URLs.
- Provision `Media creator` and `Media manager` roles on a Lightning site with `lightning_roles`.
- Grant content creators the `rich_text` text format so they can embed media in body fields.
- Show SVG images inside image styles by inferring dimensions from the style's resize effects.
- Restrict which media bundles an entity browser widget will create.
- Cap entity-browser selections at the referencing field's cardinality.
- Build a media library where the media type is derived from the dropped file's extension.
- Add audio, document, image, video, remote video, tweet and Instagram media types with one module each.
- Bulk-upload dozens of assets at once with the DropzoneJS-powered bulk upload form.
- Create a slideshow/carousel block from any set of media items.
- Give image media a freeform crop workflow via Image Widget Crop.
- Standardise media handling across several sites by installing the same Lightning Media components.
- Use `lightning.media_helper` in custom code to attach a file to a media entity and move it into place.
- Migrate off a bespoke media browser onto a supported, config-driven one.

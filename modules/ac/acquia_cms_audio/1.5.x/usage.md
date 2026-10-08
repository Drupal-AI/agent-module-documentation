Acquia CMS Audio installs a ready-made "Audio" media type (backed by SoundCloud) plus its fields, form/view displays, permissions and an optional Site Studio component for Acquia CMS / Acquia Drupal Starter Kit sites.

---

Acquia CMS Audio is a configuration-and-glue module: it ships an `audio` media bundle whose source is SoundCloud (via `media_entity_soundcloud`), a required `field_media_soundcloud` string field for the track URL, and optional `field_categories` / `field_tags` taxonomy references. It also ships default, `media_library` and `embedded` form/view displays, five "audio media" permissions, and a Site Studio (Cohesion) "Audio" component packaged for `acquia_cms_site_studio`. On install it rewrites the shared Acquia CMS CKEditor config and, via a content-model role hook, grants the new permissions to the `content_author` and `content_editor` roles. It has no routes, services, settings form or config schema of its own — everything is delivered as installable config that plugs into core Media, Media Library and Field Group. It is designed to be enabled as part of the Acquia CMS component set rather than as a standalone feature.

---

- Add a turnkey "Audio" media type to an Acquia CMS site without hand-building the bundle.
- Let editors embed SoundCloud-hosted audio by pasting a track URL into a media item.
- Reuse the audio bundle across nodes/paragraphs through core Media reference fields.
- Pick audio in the Media Library modal (a `media_library` form/view display is provided).
- Render audio in-page with the `embedded` view mode used by other Acquia CMS components.
- Categorize audio media with the shared `categories` taxonomy (`field_categories`).
- Tag audio media freely with the `tags` vocabulary (`field_tags`, auto-create enabled).
- Grant authors the "create / edit own / delete own audio media" permissions out of the box.
- Grant editors the "edit any / delete any audio media" permissions out of the box.
- Have Acquia CMS wire those permissions onto `content_author` / `content_editor` automatically.
- Offer a drag-and-drop Site Studio "Audio" component (`cpt_audio`) for low-code layout building.
- Standardize how audio is stored and displayed across an Acquia CMS content model.
- Provide a consistent SoundCloud embed (visual player, 100% width, 450px height) via the default display.
- Support translated audio media (fields are translatable; content language settings shipped).
- Serve as a dependency target so other Acquia CMS packages can rely on an `audio` bundle existing.
- Add audio media capability to an existing Drupal Media stack with a single `composer require`.
- Keep audio configuration versioned and re-installable as optional config.
- Give content teams a documented in-editor help panel for the audio component (Site Studio help text).
- Extend an editorial workflow to cover audio assets alongside images, video and documents.
- Bootstrap audio media on a Starter Kit site so no manual media-type setup is required.
- Integrate SoundCloud tracks into Site Studio layouts through the media library entity browser.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media source, SDC components & CKEditor integration

Non-formatter pieces the module ships. None add routes, permissions, or config forms.

## `image_gallery` media source

`src/Plugin/media/Source/ImageGallery.php` — class `ImageGallery extends MediaSourceBase`, declared with the `#[MediaSource]` attribute:
- id `image_gallery`, label "Image Gallery", `allowed_field_types: ["image"]`.
- One metadata attribute: `name` (`METADATA_ATTRIBUTE_NAME`). `getMetadata()` returns the file name / delegates to `parent::getMetadata()`; `createSourceField()` just calls the parent.

Use it to create a Media type (Structure → Media types) whose source is "Image Gallery", giving you a reusable image field to pair with the PhotoSwipe gallery formatter or the Media Library.

## Theme hooks & templates

`ddeck_advanced_media_theme()` in `ddeck_advanced_media.module` registers four hooks (Twig in `templates/`):
- `ddeck_advanced_media_file_audio` → `<audio>` with `data-plyr-config`.
- `ddeck_advanced_media_file_video` → `<video playsinline>` with `data-plyr-config`.
- `ddeck_advanced_media_file_remote_video` → `<div>` with `data-plyr-provider`, `data-plyr-embed-id`, `data-plyr-config`, and an optional thumbnail poster `<img class="plyr__poster">`.
- `photoswipe_media_gallery` → the gallery `<a>`/`<img>` list.

Variables include `attributes`, `files`, `plyr_settings`, and (remote) `video_provider`, `video_embed_id`, `thumbnail`.

## SDC components (`components/`)

- `ddeck_advanced_media:plyr` (`components/plyr/`) — wrapper the audio/video/remote templates `{% embed %}` around a `media` block. Ships `plyr.js` (`Drupal.behaviors.ddeckPlyrSetupPlayers` runs `Plyr.setup('.plyr-player', {...})` with localized i18n labels) and `plyr.css`.
- `ddeck_advanced_media:media_gallery` (`components/media_gallery/`) — wraps gallery items in `.advanced-media-gallery`. `media_gallery.js` (`Drupal.behaviors.mediaGallery`) initializes a `PhotoSwipeLightbox` once over `.advanced-media-gallery a`.

## Libraries (`ddeck_advanced_media.libraries.yml`)

- `plyr-player` — `/libraries/plyr/dist/plyr.js` + `plyr.css`.
- `photoswipe` — external `/libraries/photoswipe/dist/umd/photoswipe.umd.min.js`, `photoswipe-lightbox.umd.min.js`, `photoswipe.css`; deps `core/drupal`, `core/drupalSettings`, `core/once`.
- `advanced-media-gallery` — `css/advanced-media-gallery.css`, dep `core/drupal`.
- `ckeditor5` — `css/ckeditor5.css`.

Install the Plyr and PhotoSwipe front-end libraries under the web root's `/libraries/` directory (e.g. via `wikimedia/composer-merge-plugin` + asset-packagist or manual download) for playback and lightbox to work.

## CKEditor 5 stylesheet injection

`ddeck_advanced_media_library_info_alter()` reads this module's `ckeditor5-stylesheets` info-key (`css/ckeditor5.css`) and merges it into the core `internal.drupal.ckeditor5.stylesheets` library, so media/gallery markup is styled inside the CKEditor 5 editing area. External or root-relative URLs are used as-is; module-relative paths are prefixed with the module path.

## Install / enable

```
drush en ddeck_advanced_media -y
```

Pulls core `media`, `media_library`, `ckeditor5`, `image`. There is no settings route (`configure` is null) — configure everything on entity Manage display pages and Media type forms.

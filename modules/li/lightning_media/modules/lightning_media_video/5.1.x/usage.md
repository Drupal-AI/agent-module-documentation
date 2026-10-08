<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Video is the Lightning Media component that installs **two** media types — **Video** for locally hosted video files and **Remote video** for YouTube and Vimeo oEmbed URLs — and makes core's `video_file` source recognise a video file from its extension.

---

The code is a single `hook_media_source_info_alter()` that calls `Override::pluginClass($sources['video_file'], VideoFile::class)`, where `VideoFile` is core's source plus `InputMatchInterface` via `FileInputExtensionMatchTrait`. Everything else is `config/optional/`. `media.type.video` uses the `video_file` source with `field_media_video_file` (default extension list: `mp4`), while `media.type.remote_video` uses core's `oembed:video` source with `field_media_oembed_video` and a provider list of **YouTube** and **Vimeo**, thumbnails stored under `public://oembed_thumbnails/[date:custom:Y-m]`. Both types get Lightning Media's `field_media_in_library` boolean and a full set of form and view displays (`default`, `media_library`, plus `embedded` and `thumbnail` for viewing). Because the remote type relies on core's oEmbed system, adding another provider is a matter of editing the media type's `source_configuration.providers` (or installing the `oembed_providers` contrib module), not of touching this submodule. Note that `remote_video` is **not** input-matching: only the local `video_file` source implements `InputMatchInterface`, so a pasted YouTube URL is not auto-detected the way an uploaded MP4 is.

---

- Add both a local Video and a Remote video media type in one `drush en`.
- Let editors drop an MP4 into the media library and have Drupal file it as a Video.
- Embed a YouTube video in an article by pasting its URL into a Remote video item.
- Embed a Vimeo video the same way, without any third-party module.
- Host product demo videos locally when a CDN embed is not acceptable.
- Serve short looping background videos as media entities.
- Extend the allowed local extensions (e.g. add `webm`, `mov`) on `field_media_video_file`.
- Cap local video upload size with the source field's `max_filesize` setting.
- Add another oEmbed provider to `media.type.remote_video`'s `source_configuration.providers`.
- Change where remote video thumbnails are cached via `thumbnails_directory`.
- Hide raw footage from the media library with `field_media_in_library`.
- Give videos an `embedded` view display used when they are inserted into body text.
- Give videos a `thumbnail` view display for the media library grid.
- Bulk-upload a batch of local videos with Lightning Media Bulk Upload.
- Reference video media from paragraphs, Layout Builder blocks or Views.
- Build a video gallery view filtered to the `remote_video` bundle.
- Include videos in a media slideshow with Lightning Media Slideshow.
- Use `MediaHelper::createFromInput($file)` to get a Video media entity for an uploaded MP4.
- Validate an uploaded video against the Video type's own rules with `lightning_media_validate_upload()`.
- Migrate a legacy video URL field onto Remote video media entities.
- Grant `create remote_video media` to marketing editors but not `create video media`.
- Separate self-hosted and third-party video in reporting by filtering on bundle.
- Translate video titles and descriptions on a multilingual site.
- Give an entity browser widget a `target_bundles` limited to video types.

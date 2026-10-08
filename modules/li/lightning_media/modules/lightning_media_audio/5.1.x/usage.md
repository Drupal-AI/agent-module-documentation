<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Audio is the Lightning Media component that installs a ready-made **Audio** media type for locally hosted audio files and makes core's `audio_file` media source able to recognise an audio file from its extension.

---

The module is deliberately tiny: one `hook_media_source_info_alter()` implementation and one class. `Drupal\lightning_media_audio\Plugin\media\Source\AudioFile` extends core's `AudioFile` source and mixes in `Drupal\lightning_media\FileInputExtensionMatchTrait`, which implements `InputMatchInterface::appliesTo()` by comparing the uploaded file's extension against the source field's `file_extensions` setting. `Override::pluginClass($sources['audio_file'], AudioFile::class)` swaps the class in the plugin definition only when the replacement's immediate parent is the current class, so it composes safely with other modules. Everything else is configuration in `config/optional/`: a `media.type.audio` media type (source `audio_file`, source field `field_media_audio_file` with extensions `mp3 wav aac`), a `field_media_in_library` field instance, and form/view displays for the `default`, `media_library`, `embedded` and `thumbnail` modes. Because the config lives in `config/optional/`, an existing site that already has an `audio` media type keeps it. The practical payoff is that dropping an MP3 into a Lightning Media entity browser or bulk upload form resolves to the Audio media type automatically, without the editor choosing a type.

---

- Add a ready-made Audio media type to a Drupal site in one `drush en`.
- Let editors drop an MP3 into the media library and have Drupal pick the Audio type for them.
- Host podcast episodes as media entities with a proper media library entry.
- Attach interview recordings to articles through a media reference field.
- Serve WAV masters to an internal team through the media library.
- Provide AAC files for a mobile-friendly audio player.
- Give audio assets an `embedded` view mode used when they are inserted into body text.
- Give audio assets a `thumbnail` view mode for the media library grid.
- Hide working audio files from the media library with `field_media_in_library`.
- Restrict which audio extensions editors may upload by editing `field_media_audio_file`'s `file_extensions`.
- Add extra formats (e.g. `flac`, `ogg`, `m4a`) to the allowed extension list.
- Cap audio upload size with the source field's `max_filesize` setting.
- Bulk-upload a whole album of audio files with Lightning Media Bulk Upload.
- Reference audio media from a paragraph or Layout Builder block.
- Include audio items in a media slideshow with Lightning Media Slideshow.
- Let an entity browser widget accept audio files alongside images and documents.
- Use `MediaHelper::createFromInput($file)` in custom code and get an Audio media entity back for an MP3.
- Validate an uploaded audio file against the Audio type's own extension rules with `lightning_media_validate_upload()`.
- Standardise the audio media type across several sites by installing the same module.
- Migrate legacy audio file fields onto media entities with a known target bundle.
- Give audio a dedicated `media_library` view display so the library grid shows something useful.
- Change the upload directory of audio files by editing the source field's `file_directory`.
- Translate audio media metadata on a multilingual site.
- Grant `create audio media` to a limited editorial role.

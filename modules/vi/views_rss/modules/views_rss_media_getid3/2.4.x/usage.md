<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views RSS: Media getID3 enriches `views_rss_media`'s `media:content`/`media:thumbnail` elements with real audio/video technical metadata (bitrate, resolution, sample rate, duration) read from the actual media file via the getID3 PHP library.

---

This submodule adds **no new RSS elements** of its own; it implements a single alter hook, `hook_views_rss_item_elements_alter()`, that appends two preprocess functions onto `views_rss_media`'s already-registered `media:content` and `media:thumbnail` element definitions: `views_rss_media_getid3_preprocess_media_content()` and `...preprocess_media_thumbnail()`. Each locates the underlying file (resolving an image-style derivative's URI first if one is configured), gets its real filesystem path via `\Drupal::service('file_system')->realpath()`, and runs it through `(new \JamesHeinrich\GetID3\GetID3())->analyze($realpath)`. From the returned analysis it adds attributes: for video, `framerate`, `bitrate`, `width`/`height` (`resolution_x`/`resolution_y`); for audio, `bitrate`, `samplingrate` (Hz converted to kHz), `channels`; and `duration` (whole seconds) for either. **This module requires the `james-heinrich/getid3` PHP library**, which is not a normal Composer dependency of the `views_rss` project (declared only under `require-dev` for CI) — installing it in production means running `composer require "james-heinrich/getid3:^2.0@beta"` yourself (see the module's `README.md`). Its `hook_requirements()` flags an install-time error if the `GetID3` class isn't autoloadable, though this only warns; it doesn't hard-block enabling the module on all Drupal/Drush versions.

---

- Add real video `framerate`/`bitrate`/`width`/`height` attributes to `media:content` from the source file, not guesses.
- Add real audio `bitrate`/`samplingrate`/`channels` attributes to `media:content` for a podcast feed.
- Add a `duration` attribute (seconds) to `media:content` so podcast apps show accurate episode length.
- Add real `width`/`height` to `media:thumbnail` derived from the actual thumbnail image file.
- Publish a podcast/video RSS feed whose MRSS technical metadata matches the real file, not an assumption.
- Enrich a `media:content` element even when the underlying field uses an image-style-derived thumbnail.
- Get accurate metadata for a video field regardless of upload resolution, without manual attribute entry.
- Feed audio sample-rate/channel-count data to Media RSS consumers that use it for quality display.
- Understand why `media:content`/`media:thumbnail` gained extra attributes after enabling this module.
- Diagnose a missing getID3-derived attribute by checking `james-heinrich/getid3` is composer-required.
- Add the getID3 library to a views_rss project via `composer require "james-heinrich/getid3:^2.0@beta"`.
- Trace a fatal error referencing `JamesHeinrich\GetID3\GetID3` back to a missing library install.
- See install-time requirements warnings (`hook_requirements()`) surfaced when the library class is absent.
- Layer technical audio/video metadata onto a feed without writing a custom `hook_views_rss_item_elements_alter()`.
- Understand that this submodule adds no configurable form elements of its own — it only decorates existing ones.

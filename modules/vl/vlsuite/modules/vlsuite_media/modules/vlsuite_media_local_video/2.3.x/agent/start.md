<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Media: Local Video (vlsuite_media_local_video) — agent index

Nested submodule of **vlsuite_media**. **Self-hosted video** media type.
Version **2.3.3**. Core `^10.3 || ^11`.

**Check the caption track field first.** A video without captions excludes deaf and hard-of-hearing
visitors, is unusable sound-off (most mobile viewing), and fails accessibility requirements binding
on most public-sector and many commercial sites.

Storage/delivery: video files dominate file storage and Drupal serves them without adaptive
bitrate. Fine for short clips — which is why `vlsuite_media_remote_video` exists for anything
longer.
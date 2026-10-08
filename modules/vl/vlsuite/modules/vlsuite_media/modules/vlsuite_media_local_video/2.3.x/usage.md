<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Media Local Video defines the media type for video files hosted on the site.

---

Self-hosted video as a media entity gets the same benefits as any other media: library management, one entity reused across pages, and a place to hang a poster image and caption track rather than attaching them ad hoc.

The caption track is the field to care about. A video without captions excludes deaf and hard-of-hearing visitors, is unusable in a sound-off context (which is most mobile viewing), and fails accessibility requirements that apply to most public-sector and many commercial sites. Whether this media type provides a place for a caption file is the first thing to check.

Storage and delivery are the other consideration: video files are large, they will dominate the site's file storage, and serving them from Drupal means no adaptive bitrate. That is acceptable for short clips and is the reason `vlsuite_media_remote_video` exists for anything longer.

---

- Manage self-hosted video as media.
- Reuse a video across pages.
- Attach a poster image to a video.
- Provide a caption track.
- Meet accessibility requirements for video.
- Support sound-off viewing.
- Serve video from your own domain.
- Avoid third-party video tracking.
- Check storage impact of video files.
- Decide between local and remote video.
- Replace a video in one place.
- Translate video metadata.
- Audit videos without captions.
- Limit video length for self-hosting.
- Set a consistent video display.

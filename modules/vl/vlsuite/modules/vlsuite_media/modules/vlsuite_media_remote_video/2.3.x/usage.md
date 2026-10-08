<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Media Remote Video defines the media type for provider-hosted video, using core's oEmbed handling.

---

For anything beyond a short clip, a video provider handles transcoding, adaptive bitrate and global delivery — problems a Drupal site should not be solving. This media type wraps that, using core's oEmbed support, so a remote video is a media entity like any other and can be selected from the library and reused.

Core's oEmbed handling includes a **provider allow-list**, and that list is the security boundary. It decides which third parties may be embedded, and by extension whose scripts may run in a page. Review it rather than inheriting whatever is there, and be deliberate about additions.

The privacy consequence carries from the media type to every component that renders it: the provider's script and cookies load for every visitor who reaches the page, before any interaction. On an EU-facing site that needs consent gating. See the notes on `vlsuite_block_remote_video`, `usercentrics` and `consent_mode`.

---

- Manage provider-hosted video as media.
- Embed a YouTube or Vimeo video.
- Reuse a remote video across pages.
- Let a provider handle transcoding.
- Review the oEmbed provider allow-list.
- Restrict which providers may be embedded.
- Gate video embeds behind consent.
- Document provider cookies in a privacy notice.
- Select a remote video from the library.
- Replace a video reference in one place.
- Decide between remote and local video.
- Audit which providers a site allows.
- Translate video metadata.
- Check consent gating before launch.
- Limit third-party payload on a page.

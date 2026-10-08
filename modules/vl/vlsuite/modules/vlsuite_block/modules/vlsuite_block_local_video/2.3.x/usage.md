<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Local Video places a self-hosted video file as a component.

---

Self-hosting video is the right choice when a third-party player is unacceptable — no tracking cookies, no vendor branding, no external requests — and the wrong choice when the video is long or the audience large, because serving video is expensive and doing it well needs adaptive bitrate the site probably does not have.

This component covers the cases where self-hosting is right: a short background loop, a product demo, a testimonial clip. It uses `vlsuite_media`'s local video type so the file is a media entity like anything else.

Three things to plan. **Autoplay** should be muted or not used, because unmuted autoplay is blocked by browsers and hostile to users regardless. **Captions** are an accessibility requirement, not an enhancement, and a video component that offers no caption track is one that cannot be used for anything meaningful. And **file size** — a background loop that is a 40MB MP4 is a slow page for everyone, so check what is actually uploaded.

---

- Place a self-hosted video in a layout.
- Show a short background loop.
- Embed a product demo clip.
- Avoid third-party video tracking.
- Serve video without vendor branding.
- Add captions to a video component.
- Mute autoplaying video.
- Select a video from the media library.
- Check uploaded file sizes.
- Decide between self-hosting and a provider.
- Keep video requests on your own domain.
- Style video placement with utility classes.
- Provide a poster image.
- Audit videos missing captions.
- Avoid unmuted autoplay.

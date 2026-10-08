<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Remote Video places a provider-hosted video — YouTube, Vimeo and similar — as a component.

---

For anything longer than a clip, a video provider is the sensible answer: they handle transcoding, adaptive bitrate, global delivery and the player. This component places one as a block, using `vlsuite_media`'s remote video type, which is core's oEmbed handling underneath.

**The privacy consequence is the thing to state.** Embedding a provider's player loads their script and sets their cookies for every visitor who reaches the page — before they press play. On an EU-facing site that is processing that needs a lawful basis and, in practice, consent; a video embed is one of the most common reasons a site fails a cookie audit. If the site runs a consent management platform, the embed needs gating through it (see `usercentrics` and `consent_mode`), and "privacy-enhanced" provider modes reduce but do not eliminate the issue.

The performance consequence follows the same shape: a provider embed is a substantial third-party payload, so a page with three of them is slow before your own code runs. Lazy-loading or a click-to-load facade is worth considering.

---

- Embed a YouTube video in a layout.
- Place a Vimeo video as a component.
- Let a provider handle transcoding and delivery.
- Show a long-form video without self-hosting.
- Gate a video embed behind cookie consent.
- Document provider cookies in a privacy notice.
- Use a privacy-enhanced provider mode.
- Lazy-load a video embed.
- Use a click-to-load facade.
- Reduce third-party payload on a page.
- Select a remote video from the media library.
- Style video placement with utility classes.
- Audit pages with several video embeds.
- Check consent gating before launch.
- Decide between remote and local video.

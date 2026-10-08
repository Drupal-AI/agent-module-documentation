<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Video adds one paragraph type that references a core Media **Remote Video** (oEmbed — YouTube, Vimeo, etc.) and renders it, by default, as a thumbnail that opens the video in a **GLightbox** overlay player, with the shared EPT design options for spacing, background and width.

---

Video in a component-built page looks trivial and hides several decisions: remote or local, inline or overlay, poster or first frame, autoplay or not, and what happens on a phone. EPT Video supplies a pre-made answer built on core **Media** plus `ept_core`, `paragraphs` and the **GLightbox** modules. Out of the box the paragraph's video field (`field_ept_video`) is an entity reference restricted to the core **`remote_video`** media bundle — an oEmbed video URL that core Media resolves against its provider allowlist — so the shipped configuration handles remote videos (the "Local" in the module's title requires you to add and wire a local `video_file` media type yourself). The referenced media is shown through the `glightbox_media_remote_video` field formatter in a dedicated `ept_video` media view mode, which renders a thumbnail and opens the embed in a lightbox overlay rather than playing inline — the right default for a page whose layout should not be dictated by a video's aspect ratio, and it also lets the third-party embed be deferred until the overlay is opened. The paragraph also carries an optional title (`field_ept_title`) and body text (`field_ept_text`), and a **Settings** tab (`field_ept_settings`, from `ept_core`) with the family's design options: margin/border/padding, border/background color, background image or video, edge-to-edge, container max-width, an ID anchor and additional CSS classes. Version **2.0.0**, core `^10.1 || ^11 || ^12`; there is no admin settings form of its own and no permissions, Drush commands or config schema. Install is blocked by `hook_requirements()` until a **Remote Video** media type exists. Three things belong in any "add video" conversation: a remote video is a **third-party request** (the player sets cookies and reports the view before anyone presses play, so it belongs behind the consent manager); video **needs captions** (a WCAG requirement for prerecorded content and the only way the words become searchable); and **autoplay with sound is blocked by every current browser**, so if a design calls for it that is a conversation, not a setting.

---

- Add a video to a page section built with Paragraphs.
- Embed a YouTube video in a paragraph.
- Embed a Vimeo video on a landing page.
- Play a video in a lightbox / overlay instead of inline.
- Give editors a ready-made video component without custom code.
- Add a product demonstration video to a service page.
- Show a testimonial or case-study video.
- Embed a training or explainer video.
- Add a conference or webinar recording.
- Defer a third-party video embed until it is clicked (consent-friendly).
- Add a video with an accompanying title and body text.
- Add a welcome or intro video to a campaign page.
- Control per-paragraph spacing, background and container width around a video.
- Give a video block an ID anchor for direct linking.
- Apply custom CSS classes to a video section for theme styling.
- Reuse the same video component across many content types.
- Install only the video paragraph type from the EPT family.
- Wrap a remote video in the site's design system (margins, borders, background).
- Show an edge-to-edge full-width video band.
- Place a video inside a specific container max-width.

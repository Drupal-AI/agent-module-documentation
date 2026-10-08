<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Panopto Media Remote adds Panopto as a provider for the `media_remote` module, so a lecture-capture recording is referenced as a media entity by its URL and shown as an embedded iframe.

---

Install it with Composer (`composer require drupal/panopto_media_remote`, which pulls in **`media_remote`**) and enable both modules; there is no settings page. You wire it up through the Media system: at **Structure → Media types → Add media type**, name the type (for example `Panopto`) and choose **"Remote Media URL"** as the media source, then on that type's **Manage display** set the URL field's format to **"Remote Media - Panopto"**. Open the formatter's settings to set the iframe **width** and **height** (defaults `640px` × `480px`, given in pixels or as a percentage like `100%`). Finally add a media reference field to any content type and point it at the new media type, so editors paste a Panopto **Embed** or **Viewer** URL (`https://…​.panopto.<tld>/Panopto/Pages/Embed.aspx?id=…`) when creating media. The module **references rather than downloads** the video: it stores only the URL, validates it against a Panopto URL pattern when the media is saved, and renders an `<iframe>` that the visitor's browser loads directly from Panopto — Drupal itself makes no request to Panopto. Because the recording still lives on Panopto, **access, retention and captioning stay with the platform**: a recording restricted to a course will only play for viewers Panopto authorises, and whether a lecture is captioned is decided in Panopto, not in Drupal — worth remembering on public pages and in a privacy notice, since each embed is a third-party request to Panopto.

---

- Embed a Panopto lecture recording on a page.
- Reference lecture capture in a course page.
- Add a recorded seminar to an article.
- Show training recordings from Drupal without hosting the video.
- Reference video that is governed by the LMS/Panopto.
- Add a Panopto video to the media library for reuse.
- Reference a recording without copying its storage.
- Set the embed iframe size per view display (width/height).
- Support a university's video platform inside Drupal.
- Embed a recorded conference session.
- Add lecture video to a course listing.
- Reference recordings that keep Panopto's access controls.
- Embed a training video from a Panopto Embed URL.
- Support a hybrid teaching site.
- Add a recorded lab demonstration to content.
- Reference a webinar recording by URL.
- Embed a captioned lecture whose captions live in Panopto.
- Build a Panopto media type on the Remote Media URL source.
- Let editors paste an Embed or Viewer URL to create media.

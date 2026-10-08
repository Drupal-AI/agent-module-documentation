<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Vimeo Domain Privacy makes core's media system work with Vimeo videos restricted to play only on specified domains.

---

Vimeo's domain-level privacy is the setting an organisation uses when a video should be watchable on its own site and nowhere else — training material, an internal briefing, a client deliverable, a film whose licence covers one site. The video plays when embedded on an allowed domain and refuses everywhere else, enforced by the referrer. It interacts badly with Drupal's media system for a specific reason: core's remote video source uses **oEmbed**, and Vimeo's oEmbed endpoint refuses to return metadata for a domain-restricted video to an unauthenticated caller — the server making that request is not the browser on the allowed domain — so adding the video fails at the point where Drupal tries to fetch its title and thumbnail. This module handles that case, depending on core `media`, version **1.2.0** on `^8.8` through `^11`. Two things worth saying about the mechanism rather than the module. **Domain privacy is a deterrent, not an access control**: it is enforced by a request header that a determined person can set, and the video URL still exists — so it keeps a video off other people's sites and does not keep it from someone who wants it. Vimeo's own stronger options are password protection and unlisted-with-hash links, and if the requirement is genuinely confidential material the answer is not a domain allow-list. And **any embedded player is still a third-party request** with cookies and a view reported to Vimeo, so the consent question applies exactly as it does to a public video.

---

- Embed a domain-restricted Vimeo video.
- Show training video on one site only.
- Fix oEmbed failures for private videos.
- Add a client's restricted video to a page.
- Keep a video off other websites.
- Embed an internal briefing video.
- Support a licensed film's single-site use.
- Fix a media add failing for a private video.
- Show a members-only video.
- Support a corporate video library.
- Embed a video restricted by referrer.
- Use Vimeo privacy with Drupal media.
- Show a course video on one domain.
- Support a media-managed private video.
- Fix a missing thumbnail for a private video.
- Embed a restricted promotional video.
- Support a broadcaster's licensing terms.
- Add domain-private videos to the library.

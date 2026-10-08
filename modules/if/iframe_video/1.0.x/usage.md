<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Iframe Media Embed Video provides functionality to add an embedded remote video without an oEmbed provider using iframes.

---

Iframe Media Embed Video lets editors embed remote videos that don't have an oEmbed provider — by
storing an iframe embed as a core media source, so videos from platforms core's oEmbed doesn't support can
still be added as media. It depends on core Media and Media Library, in the Other package.

Use it to embed videos from providers lacking oEmbed support. The security-relevant point: because it renders
an **iframe** to a remote source, keep control over which URLs/domains can be embedded — an iframe embeds
third-party content in your page context, so restrict embedding to trusted editors and, ideally, an
allow-list of trusted video domains (an unrestricted iframe embed of an arbitrary URL is a
clickjacking/malicious-content vector). It has no access-control role. Configure the iframe video source.

---

- Embed remote videos via iframe.
- Support providers without oEmbed.
- Store iframe embeds as media.
- Depend on core Media and Media Library.
- Restrict which URLs/domains embed.
- Restrict embedding to trusted editors.
- Prefer an allow-list of video domains.
- Avoid arbitrary-URL iframe embeds.
- Have no access-control role.
- Configure the iframe video source.
- Embed non-oEmbed videos.
- Add iframe videos.
- Handle remote video embeds.
- Configure the source.
- Embed video iframes.
- Add remote videos.
- Handle iframe embeds.
- Embed videos.
- Configure video embedding.
- Add non-oEmbed media.

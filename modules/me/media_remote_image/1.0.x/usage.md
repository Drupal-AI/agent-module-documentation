<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Remote Image provides a media source for oEmbed image providers.

---

Media Remote Image provides a **media source for oEmbed image providers** — letting you add remote images
(from supported oEmbed providers) as Drupal media, similar to how core Media handles oEmbed video. It depends on
core Media.

Use it to embed remote provider images as media. It is a media/integration feature. Security note: like core's
oEmbed handling, remote content comes from **configured/allowlisted oEmbed providers** (not arbitrary
attacker-supplied URLs), which bounds the server-side-request surface; still, images load from the **remote
provider** (third-party). It has no access-control role. Configure the remote-image media source.

---

- Provide an oEmbed image media source.
- Embed remote provider images as media.
- Mirror core's oEmbed handling.
- Depend on core Media.
- Serve media integration.
- Support oEmbed image providers.
- Use allowlisted oEmbed providers (bounded SSRF).
- Load images from the remote provider (third-party).
- Have no access-control role.
- Configure the media source.
- Handle remote images.
- Embed images.
- Configure the source.
- Handle the media.
- Add remote images.
- Configure media.
- Handle the integration.
- Embed remote media.
- Set the source.
- Provide remote-image media.

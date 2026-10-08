<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Remote Social creates a Remote social media type for easily adding oEmbed social media posts from Facebook and Instagram.

---

Media Remote Social creates a "Remote social" media type for embedding social posts — letting editors
add oEmbed-based Facebook and Instagram posts as Drupal media, so social content displays within the site.
It depends on core Media and the Key module (for storing the platform access token), and provides its own
permissions.

Use it to embed Facebook/Instagram posts as media. The security-relevant point is handled well: it uses the
**Key module** to store the required Facebook/Instagram oEmbed access token — so the credential is stored via
Key (env/secret provider) rather than plain config; configure the Key with the token as a secret. Embedded
posts are remote content from the platforms. It has no content-access role beyond its permission. Configure
the media type and the access-token Key.

---

- Embed Facebook/Instagram posts.
- Create a Remote social media type.
- Add oEmbed social posts as media.
- Depend on core Media and Key.
- Store the access token via the Key module.
- Provide its own permissions.
- Keep the token as a secret (Key provider).
- Embed remote social content.
- Have no content-access role beyond permission.
- Configure the access-token Key.
- Add social media.
- Embed oEmbed posts.
- Display social content.
- Configure the media type.
- Handle social embeds.
- Use Key for the token.
- Embed FB/IG posts.
- Add remote posts.
- Configure social media.
- Embed social posts.

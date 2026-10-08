<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Instagram Nodes imports instagram posts to an instagram_post content type.

---

Instagram Nodes **imports Instagram posts into Drupal nodes** — pulling posts from Instagram into an
`instagram_post` content type so Instagram content can be stored and displayed as native Drupal content. It
provides its own permissions, in the Other package.

Use it to bring Instagram posts into the site as content. It is an integration/content feature. Security/data
handling: it authenticates to the **Instagram/Meta API with credentials/tokens** — store those as **secrets**
(env/Key, HTTPS) — and it imports **external content** (Instagram post text/media) as nodes, so treat the
imported content appropriately (apply safe text formats; the media is hosted/subject to Instagram's terms).
Its permission gates configuration. Configure the Instagram credentials and import.

---

- Import Instagram posts to nodes.
- Use an instagram_post content type.
- Store Instagram as Drupal content.
- Authenticate with Instagram API tokens.
- Store credentials as secrets.
- Use HTTPS.
- Import external content as nodes.
- Apply safe text formats to imports.
- Provide its own permissions.
- Have no access-control role beyond permission.
- Configure the credentials and import.
- Handle Instagram import.
- Import posts.
- Configure the import.
- Pull Instagram content.
- Handle the integration.
- Store posts.
- Import social content.
- Secure the tokens.
- Provide Instagram import.

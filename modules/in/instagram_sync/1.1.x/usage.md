<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Instagram Sync provides the possibility to import Instagram posts to the website.

---

Instagram Sync imports Instagram posts into Drupal — fetching posts from an Instagram account (via the
Instagram API) and storing them as content, so an Instagram feed can be displayed on the site. It is
configured at `instagram_sync.settings_form`, provides its own permissions, in the Custom package.

Use it to mirror Instagram posts on the site. Security note: it authenticates to the Instagram/Meta API with
an access token — **store that token as a secret** (not in exported config), operate over HTTPS, and refresh
tokens per Meta's policy. Imported posts are external content (escape on display). It has no access-control
role beyond its permission. Configure the Instagram connection.

---

- Import Instagram posts.
- Fetch posts via the Instagram API.
- Display an Instagram feed.
- Configure at instagram_sync.settings_form.
- Provide its own permissions.
- Store the Instagram token as a secret.
- Operate over HTTPS.
- Refresh tokens per Meta's policy.
- Escape imported posts on display.
- Have no access-control role beyond permission.
- Configure the Instagram connection.
- Mirror Instagram content.
- Handle the access token securely.
- Configure credentials.
- Import social posts.
- Sync Instagram.
- Handle the feed.
- Configure Instagram.
- Fetch social content.
- Import posts.

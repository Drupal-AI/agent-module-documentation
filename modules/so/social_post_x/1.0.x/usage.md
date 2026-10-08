<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Post X provides Social Post integration for X (formerly Twitter).

---

Social Post X provides Social Post integration for X (formerly Twitter) — letting the site post content
to an X account automatically (via the X API), building on the Social Post framework. It is configured at
`social_post_x.settings_form`, provides its own permissions, in the Social package.

Use it to auto-post to X from Drupal. Security notes: it authenticates to the X API with OAuth **credentials/
tokens** — **store those as secrets** (not exported config), operate over HTTPS, and be deliberate about what
is auto-posted (a public post reaches your audience — restrict who can trigger posts). It has no access-control
role beyond its permission. Configure the X API credentials.

---

- Post to X (Twitter) from Drupal.
- Auto-post content to an X account.
- Use the X API via Social Post.
- Configure at social_post_x.settings_form.
- Provide its own permissions.
- Store X OAuth credentials/tokens as secrets.
- Operate over HTTPS.
- Be deliberate about what is auto-posted.
- Restrict who can trigger posts.
- Have no access-control role beyond permission.
- Configure the X credentials.
- Handle X posting.
- Auto-post to X.
- Configure credentials.
- Handle the API.
- Handle credentials securely.
- Post to social media.
- Configure X.
- Integrate X.
- Post content to X.

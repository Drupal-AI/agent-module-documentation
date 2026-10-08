<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bluesky Post adds a per-node "Share to Bluesky" tab whose form posts a node's title, summary and link to a Bluesky account through the bsky module.

---

Bluesky Post (bsky_post) is a small UI layer on top of the Bluesky Integration (bsky) module. It does not post automatically: an editor with the right permission opens the "Share to Bluesky" tab on a node, reviews a form pre-filled with the node's Title, body Summary (or the first 300 characters of the body when no summary exists) and an absolute link back to the node, edits the text as desired, and submits it. The submission is handed to bsky's post service, which uses the potibm/phluesky PHP library to publish to Bluesky over the AT Protocol. Bluesky credentials (handle + app password) live entirely in the bsky module, so every post goes to that single configured account regardless of which user triggers it — the maintainer notes the module is mainly useful on single-account sites. A settings form lets administrators choose which content types display the tab, and two permissions separate configuring the module from actually posting. Requires Drupal 10 or 11 and the bsky module.

---

- Add a "Share to Bluesky" tab to chosen content types.
- Let an editor manually post a node to Bluesky from its tab.
- Pre-fill the post with the node's title and body summary.
- Fall back to the first 300 characters of the body when there is no summary.
- Include an absolute link back to the node as a website card.
- Edit the post title, summary and link before sending.
- Enforce Bluesky's 300-character limit before posting.
- Announce a Drupal article to your Bluesky followers.
- Cross-post blog posts to the AT Protocol network.
- Restrict the tab to only news or announcement content types.
- Let marketing staff post without granting site-config access.
- Grant "post to bluesky" to editors and keep config admin-only.
- Choose in one settings form which node bundles get the tab.
- Reuse the single Bluesky account configured in the bsky module.
- Keep Bluesky credentials out of this module entirely (bsky/Key module holds them).
- Share content on publish workflows by opening the tab after publishing.
- Provide a simple share UI instead of scripting the AT Protocol directly.
- Post a link card that shows your site name and a "Read the full post." blurb.
- Redirect back to the node after a successful share.
- Show the returned Bluesky error message when a post fails.
- Support both Drupal 10 and Drupal 11 sites.
- Drive posting through Drupal's Form API (CSRF-protected submission).

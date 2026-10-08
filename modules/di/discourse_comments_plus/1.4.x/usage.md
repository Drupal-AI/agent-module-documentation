Discourse Comments (+) turns a Discourse forum into the comment system for Drupal nodes: it publishes nodes as Discourse topics, embeds their replies as comments, and lets visitors post back through Discourse SSO.

---

The module adds a per-node base field (`discourse_plus_field`) to all node types holding the linked Discourse topic id, url, category and reply count. On the first publish of a node whose "Push to Discourse" checkbox is ticked, a submit handler calls the Discourse REST API (`POST /posts.json`) to create a topic and stores the returned ids on the node. A "Discourse comment block" placed on node pages fetches that topic (`GET /t/{id}.json`) and renders its posts as comments; a "Latest Comments block" shows recent replies across topics from a warmed cache. Visitors authenticate through a DiscourseConnect (SSO) provider round-trip at `/discourse-comments/sso`, after which they can submit replies straight from the node page; those replies are posted to Discourse under their Discourse username using the site's configured API key. All settings (Discourse base URL, optional internal URL, SSO secret, API key/username, cache lifetime, default/overridden categories, footer template, enabled content types) live on one admin form at `/admin/config/discourse_comments_plus/discourse_comments_settings`. A Drush command (`drush fetch:latest_comments_plus`) refreshes the latest-comments cache for cron/scheduled use.

---

- Use Discourse as the comment engine for a Drupal blog or news site instead of core comments.
- Automatically create a Discourse topic when an editor publishes a new article.
- Embed the discussion thread from Discourse directly beneath the corresponding Drupal node.
- Let readers log in via their existing Discourse account (DiscourseConnect SSO) to comment.
- Allow authenticated visitors to post replies to a topic without leaving the Drupal page.
- Show a "latest comments" sidebar block aggregating recent replies across all linked topics.
- Choose per content type whether "Push to Discourse" is enabled by default on new nodes.
- Route each content type's topics to a specific Discourse category via default + per-type overrides.
- Append a standardised footer (author, canonical link, attribution) to every pushed post using node tokens.
- Rewrite relative `/sites/...` image paths in node bodies to absolute URLs before pushing to Discourse.
- Run Discourse behind a reverse proxy or in Docker by configuring a separate internal base URL.
- Display a live reply count for each node using the "Comment count plus formatter" field formatter.
- Warm the latest-comments cache on a schedule with `drush fetch:latest_comments_plus` (e.g. from cron).
- Migrate existing data from the legacy `discourse_comments` module's field on install.
- Provide a "Login to comment" call-to-action that starts the Discourse SSO flow for anonymous visitors.
- Cache fetched Discourse topics and categories to limit API traffic (configurable cache lifetime).
- Integrate with the Domain module so multi-domain sites generate correct absolute image URLs per domain.
- Give community/documentation sites a single canonical discussion venue (Discourse) surfaced in-context on Drupal.
- Keep the node's stored reply count in sync each time the comment block renders the topic.
- Pull category lists from Discourse into the node edit form so editors pick a target category at publish time.
- Offer readers avatars and post excerpts from Discourse in the embedded comment and latest-comment blocks.

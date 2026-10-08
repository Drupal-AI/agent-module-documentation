<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Feed Fetcher pulls posts from Facebook, Twitter/X, Instagram and LinkedIn into a Drupal "Social Post" content type, so a social wall is built from content the site owns rather than from an embedded widget.

---

The requirement — "show our social feed on the site" — has two implementations that differ in almost every respect. **An embedded widget** is a third-party script that loads on page view, tracks the visitor, needs consent, and disappears the day the platform changes its embed. **Fetching into nodes** stores the posts locally: they are cached, themed like the rest of the site, indexed by the site's own search, and keep working when the API does not. This module does the second. Enabling it installs a **`social_post`** content type (fields for platform, post id, post text, date, link and image) and a `social_posts` view, and depends on core `node`. You configure it at **`/admin/config/social_feed_fetcher_settings`** (permission **`administer socialpost entity`**): enable each platform, enter that platform's app credentials, choose how many posts to pull and which **text format** to apply to the imported post text, then — for Instagram and LinkedIn — click the generated **connect** link to authorize the account and store an access token. Fetching runs from the Drush command **`drush social_feed_fetcher:import`** (alias `sff-import`), which enqueues new posts and drains the per-platform queues; the queue workers also drain on normal core cron. Version **3.1.1** runs on core `^10 || ^11` and needs four Composer libraries (`abraham/twitteroauth`, `league/oauth2-facebook`, `espresso-dev/instagram-basic-display-php`, `samoritano/linkedin-api-php-client-v2`). The reality to plan around is that **social platform APIs are hostile to this use case**: Twitter/X restricts free access and works only on live hosts, Instagram and Facebook require an app review and business account, and tokens expire (~60 days) and must be re-connected — so the ongoing cost is the credentials and someone noticing when a feed quietly stops updating.

---

- Show an Instagram feed on a homepage.
- Build a social wall from stored posts.
- Aggregate Facebook, Twitter/X, Instagram and LinkedIn into one content type.
- Avoid third-party embed widgets and their consent burden.
- Keep social content after an API or embed change.
- Index imported social posts in the site's own search.
- Theme social posts like the rest of the site's content.
- Archive a campaign's social posts as nodes.
- Show Facebook page updates as content.
- Pull the latest tweets into a news wall.
- Show LinkedIn company or people posts.
- Cache social content locally to cut page weight.
- Curate or edit imported social posts before publishing.
- Show imported posts through the shipped `social_posts` view.
- Schedule fetches with `drush sff-import` and cron.
- Choose the text format applied to imported post text.
- Limit how many posts each platform imports.
- Store downloaded post images as managed files.
- Keep a local record of published social posts.
- Support an events or announcements social feed.

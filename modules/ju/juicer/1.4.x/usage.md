<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Juicer embeds Juicer.io social media feeds into Drupal.

---

Juicer **embeds Juicer.io social-media feeds** into Drupal — displaying an aggregated social feed (from the
Juicer.io hosted service) on the site via its embed. It is in the Social Media package. You place a "Juicer
Social Feed" block, enter your Juicer feed slug, and the feed is fetched client-side from the Juicer API and
rendered in the block.

Use it to show a Juicer.io social feed. It is a social-media/integration feature. Security/data handling: it
loads content and assets from the **external Juicer.io service** (third-party embed/scripts — trust that
provider and note it can set cookies / load remote JS), and the feed is public content; it has no access-control
role. Configure your Juicer feed ID. As of 1.4.0 the module identifies itself to Juicer as `drupal-plugin-1-4`
and sends the `X-Juicer-Embed` / `X-Juicer-Referrer` headers Juicer's own embed sends.

---

- Embed Juicer.io social feeds.
- Show aggregated social posts.
- Use the Juicer.io service.
- Serve social media.
- Display a social feed.
- Load the Juicer embed.
- Load assets from an external service.
- Trust the third-party embed/scripts.
- Note remote JS/cookies.
- Have no access-control role.
- Configure the feed ID.
- Handle the Juicer feed.
- Filter posts by source network.
- Set the number of posts per page.
- Add a title, subtitle, and heading level.
- Paginate with Load More / infinite scroll.
- Embed feeds.
- Configure the feed.
- Show social posts.
- Handle the integration.
- Display feeds.
- Embed social.
- Set the feed ID.
- Provide Juicer feeds.

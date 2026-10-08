<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Feeds Block renders recent posts from seven social networks as Drupal blocks, each fed by that network's official HTTP API using site-configured credentials.

---

Each network has its own settings form under `/admin/config/social-feeds-block/*` (Facebook, X/Twitter, Instagram, Pinterest, YouTube, LinkedIn, Google Business Profile), all gated by the `administer social_feeds_block` permission (restricted). Per-network "post collector" services fetch and cache posts through Guzzle (`@http_client`) against hardcoded HTTPS API hosts (graph.facebook.com, api.instagram.com, api.pinterest.com, googleapis.com, api.linkedin.com, mybusiness.googleapis.com), and a set of block plugins (`FacebookPostBlock`, `InstagramPostBlock`, etc.) render the results. An `InstagramAuthController::accessToken` route handles the Instagram OAuth token exchange and is also permission-gated.

Security review: all outbound API hosts are fixed HTTPS constants (no request-supplied URLs, so no SSRF) and TLS verification is left at Guzzle defaults (not disabled). Credentials are entered by administrators; note that some Facebook Graph calls place the access token in the URL query string, which can surface in logs. Typical setup is: obtain API tokens/app credentials from each provider, enter them on the relevant settings form, then place the matching block.

---
- Show a Facebook Page's latest posts in a block.
- Embed an Instagram feed on the site.
- Display recent tweets/X posts.
- Show a YouTube channel's latest videos.
- Render Pinterest pins in a sidebar.
- Display LinkedIn company updates.
- Show Google Business Profile posts.
- Configure Facebook Graph credentials and page.
- Complete the Instagram OAuth token exchange.
- Cache social posts to reduce API calls.
- Limit the number of posts shown per block.
- Place different network blocks in different regions.
- Restrict feed configuration to trusted admins.
- Refresh feeds on a cache lifetime.
- Aggregate multiple social channels on one page.
- Theme social post blocks to match the site.
- Use appsecret_proof for Facebook API calls.
- Swap tokens without code changes.
- Troubleshoot feed errors via the logger channel.
- Drive a "follow us" section from live posts.

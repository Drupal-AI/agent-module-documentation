<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Social Feeds Block

Each network is configured independently; enable only what you need.

## Steps
1. Enable the module and grant `administer social_feeds_block` to trusted admins only (permission is marked `restrict access`).
2. Go to **Configuration → Web services → Social Feeds Block** (`/admin/config/services/social-feeds-block`) — a menu links to each network form.
3. Per network, open its form and enter API credentials:
   - **Facebook** (`/admin/config/social-feeds-block/facebook`): app id/secret, page, Graph version, long-lived token. Uses `appsecret_proof` on Graph calls.
   - **X/Twitter**, **Pinterest**, **YouTube**, **LinkedIn**, **Google Business**: API keys/tokens on their respective forms.
   - **Instagram** (`/admin/config/social-feeds-block/instagram`): app credentials, then run the OAuth exchange via `social_feeds_block.instagram_auth` (`/social-feeds-block/instagram/auth`).
4. Place the matching block (e.g. "Facebook Posts") in a region and set the post count.

## Notes
- Post collectors cache results in `cache.default`; adjust cache lifetime to balance freshness vs. API quota.
- All API hosts are fixed HTTPS constants — no request-controlled URLs.
- Errors are logged to the module's logger channel; check logs if a feed is empty.

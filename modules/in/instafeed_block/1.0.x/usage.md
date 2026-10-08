<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Instafeed Block displays Instagram posts in a configurable block, rendered client-side by the instafeed.js library.

---

"Show our Instagram in the sidebar" is a standing request and there are two ways to answer it, differing in almost every respect. **Client-side** — this module's approach — has the visitor's browser fetch and render the posts: simple to set up, always current, and it means every visitor's browser contacts Instagram, which is a consent and data-protection question, and the block is empty whenever the API is unavailable or the token has expired. **Server-side fetching into content** — the approach `social_feed_fetcher` takes — stores posts locally: cached, themed, searchable, and it keeps working when the API does not. Version **1.0.12** on `^9 || ^10 || ^11`, configured at its own settings form. The credential reality is the thing that decides whether this stays working: **Instagram's API requires a Facebook app, a business or creator account, and app review for the permissions involved, and its access tokens expire and must be refreshed**. The common failure is not an error but silence — the block renders empty, nobody is notified, and it is discovered weeks later. Two further points: **instafeed.js has been through breaking rewrites** alongside Instagram's API changes, so check which version the module ships against what the API now expects; and **posts are other people's content when the account reposts**, so a wall of user-generated images carries whatever rights questions came with them.

---

- Show an Instagram feed in a sidebar.
- Add a social wall to a homepage.
- Display recent posts in a block.
- Show a campaign hashtag's images.
- Add visual content to a page.
- Show an organisation's Instagram.
- Place a feed block per region.
- Display posts client-side.
- Add a social presence to a site.
- Show a photographer's latest work.
- Display event photographs.
- Add an Instagram grid.
- Show a restaurant's food photos.
- Display a brand's social imagery.
- Add a feed to a footer.
- Show recent posts on a landing page.
- Support a marketing campaign.
- Display a curated account's images.

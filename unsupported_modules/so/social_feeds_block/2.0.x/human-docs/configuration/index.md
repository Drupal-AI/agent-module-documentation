# Configuration

Each network is configured independently — enable only the ones you need. The
module fetches nothing until a network has valid credentials and its block has
been placed.

## Step 1 — grant the permission

Go to **People → Permissions** and grant **administer social_feeds_block** to
trusted administrators only. The permission is marked *restrict access*, because
its holder enters API credentials and controls what the feeds show.

## Step 2 — open the configuration hub

Go to **Configuration → Web services → Social Feeds Block**
(`/admin/config/services/social-feeds-block`). This page is a menu that links to
each network's own settings form.

## Step 3 — enter credentials per network

Open the form for each network you want and fill in its credentials:

- **Facebook** (`/admin/config/social-feeds-block/facebook`) — app id and secret,
  the page, the Graph API version, and a long-lived token. Graph calls use an
  `appsecret_proof` for added security. Note that some Graph calls carry the
  access token in the URL query string, so it may appear in logs — keep logs
  protected.
- **Instagram** (`/admin/config/social-feeds-block/instagram`) — enter the app
  credentials, then complete the OAuth token exchange by running the Instagram
  auth route (`/social-feeds-block/instagram/auth`), which is also permission-
  gated.
- **X/Twitter**, **Pinterest**, **YouTube**, **LinkedIn**, and **Google Business
  Profile** — enter the API keys or tokens on each network's respective form.

All the API hosts the module talks to are fixed HTTPS addresses; you never supply
a URL yourself, only credentials.

## Step 4 — place the blocks

For each configured network, go to **Structure → Block layout**, place the
matching block (for example "Facebook Posts") in a region, and set how many posts
it should show.

## Caching, freshness and troubleshooting

- Post collectors cache their results. Adjust the cache lifetime to balance
  freshness against each provider's API quota — a longer lifetime means fewer API
  calls.
- If a block is empty, check the module's log messages: fetch errors are written
  to its logger channel, which usually points to an expired token or a
  misconfigured credential.
- You can swap tokens at any time by re-entering them on the relevant form — no
  code changes are needed.

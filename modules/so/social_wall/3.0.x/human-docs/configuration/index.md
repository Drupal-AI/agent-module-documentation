# Configuration

Social Wall is configured by adding one **social network configuration entity**
per platform. Each one holds that network's credentials and settings, and the
wall combines them into a single feed.

## Before you configure: confirm API access

This is the step people skip and regret. Confirm, per network, that you can
actually obtain API access on acceptable terms **before** you set anything up:

- **Twitter/X** — the API is now a paid product; there is no free read tier of the
  kind a social wall assumes.
- **Instagram** — the Basic Display API this module's library used has been shut
  down; the replacement Graph API is restricted to business and creator accounts.

If a network's access is not obtainable, that network cannot populate the wall no
matter how the module is configured.

## Add and configure a network

1. Log in as a user with the **administer social networks** permission.
2. Go to **Configuration → Web services → Social Wall**
   (`/admin/config/services/social-wall`). This is the collection page listing your
   configured networks.
3. Add a network configuration entity and enter that platform's credentials and
   settings — for example the OAuth keys and tokens for Twitter/X, or the access
   details for Instagram.
4. Repeat for each network you want to include, then save.

## Keep credentials out of exported configuration

Because each network is a configuration entity, its keys and tokens would
otherwise be written into exported YAML. Follow this project's convention and keep
API keys and tokens in **environment variables** (referenced via a Key entity or
settings), not committed to version control.

## Displaying and refreshing the wall

Once at least one network is configured with valid credentials, the combined wall
can be displayed and styled to match your theme. The wall refreshes on the
schedule the module uses (typically on cron), so posts stay reasonably current
without manual intervention. If a network is empty, re-check its API access and
credentials first — that is by far the most common cause given the platform
changes described above.

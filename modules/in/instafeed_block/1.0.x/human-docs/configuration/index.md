# Configuration

Configuring Instafeed Block happens in two places: a **module settings page**
where you enter your Instagram access token, and the **block settings** for each
Instafeed block you place.

## 1. Add your Instagram access token

The module provides a settings form (its configure route is
`instafeed_block.settings_form`, reached from **Configuration**). On it you:

- **Instagram access token** — paste the access token you obtained from Instagram
  (this requires a Facebook app and an Instagram business or creator account).
  This token is the credential that lets the feed read your posts.
- **Token refresh** — the module can automatically refresh the access token before
  it expires, on cron. Enabling this is what keeps the feed working over time
  rather than going silently blank when the token lapses. For the details of
  turning this on, see the module's README.

> **Treat the access token as a secret.** It grants access to your Instagram
> content, so avoid committing it to version control or sharing it. On this
> project's DDEV-based convention, keep secrets in an environment variable
> (`ddev dotenv set …`) rather than in exported configuration. Also remember that
> because the feed is rendered client-side, visitors' browsers contact Instagram
> directly — a consent and data-protection consideration for your site.

## 2. Create and place an Instafeed block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a new **Instafeed** block in the region where you want the feed to
   appear.
3. In the block's settings, tune the display options:
   - **Markup** — change the HTML markup used to render each Instagram post.
   - **Number of results** — limit how many posts the block shows.
   - **Media types** — choose which kinds of media (images, videos, and so on) to
     display.
   - **Disable module CSS** — turn off the module's own styles if you want to
     style the feed entirely from your theme.
4. Save the block.

## Verify it worked

View a page where the block is placed. Your recent Instagram posts should render
in the region. If the block is empty, check that the instafeed.js library is
installed (see [Installation](../installation/index.md)) and that your access
token is valid and not expired.

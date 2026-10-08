# Configuration

Setting up Sharerich has three parts: build one or more **button sets**, fill in the
**global settings** that tokens draw on, and **place the block** that renders a set.
All of these pages require the restricted `administer sharerich` permission.

## Manage button sets

Go to **Structure → Sharerich** (`/admin/structure/sharerich`). Each button set is a
configuration entity with an `id`, a human-readable `label`, and a list of services.
For every service in a set you control:

- **Enabled** — whether that service's button appears in the set.
- **Weight** — the order buttons appear in; lower weights come first.
- **Markup** — the raw HTML for that button, containing `[sharerich:*]` tokens (and
  usually an SVG icon). This is where the button's appearance and link are defined.

Default service markups ship with the module (as `.inc` files under its `services/`
directory) and are scanned in automatically, so you start with a set of familiar
services — Facebook, Twitter/X, email, Tumblr, and so on — that you can enable,
reorder, and edit. You can duplicate a set to build variants for different content
types.

### Available tokens

Inside a service's markup you can use tokens that are replaced at render time using
the current page's node, term, or user:

- `[sharerich:url]` — the URL of the current page.
- `[sharerich:title]` — the page title.
- `[sharerich:summary]` — a summary of the page.
- `[sharerich:twitter_user]` — the Twitter *via* username from global settings.
- `[sharerich:fb_app_id]` — the Facebook App ID from global settings.
- `[sharerich:fb_site_url]` — the Facebook site URL from global settings.

## Global settings

Go to **Configuration → Sharerich → settings** (`/admin/config/sharerich/settings`).
These values feed the tokens above and cap what button markup may contain:

- **Allowed HTML** (`allowed_html`) — the set of HTML tags permitted in button
  markup. When a button renders, its markup is filtered against this list, so it acts
  as a safety limit on what the markup can output.
- **Facebook App ID** (`facebook_app_id`) — used by the Facebook share dialog widget
  and available as `[sharerich:fb_app_id]`.
- **Facebook site URL** (`facebook_site_url`) — the site URL for the Facebook dialog,
  available as `[sharerich:fb_site_url]`.
- **Twitter user** (`twitter_user`) — the Twitter *via* username, available as
  `[sharerich:twitter_user]`.
- **YouTube / GitHub / Instagram usernames** — additional social usernames you can
  reference in markup.

Fill in the ones your button set uses and save.

## Place the block

Go to **Structure → Block layout** (`/admin/structure/block`) and place the
**Sharerich** block in the region you want. In the block's settings you choose:

- **Which set** it renders.
- **Orientation** — horizontal or vertical.
- **Sticky** — for a vertical bar, whether it floats and follows the visitor as they
  scroll.

When the block renders, each service's markup is filtered against your *allowed HTML*
setting, passed through the `hook_sharerich_buttons_alter()` alter hook (for modules
that want to change it programmatically), and finally has its tokens replaced using
the current route's node, term, or user context.

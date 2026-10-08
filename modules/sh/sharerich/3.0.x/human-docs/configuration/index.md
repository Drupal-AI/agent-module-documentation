# Configuration

Setting up Sharerich has three parts: build one or more **button sets**, fill in the
**global settings** that tokens draw on, and **place the block** that renders a set.
All of these pages require the restricted `administer sharerich` permission.

## Manage button sets

Go to **Structure → Sharerich** (`/admin/structure/sharerich`). Each button set is a
configuration entity with an `id`, a human-readable `label`, and a list of services.
For every service in a set you control:

- **Enabled** — whether that service's button appears in the set.
- **Weight** — the order buttons appear in; lower weights come first (drag the rows
  to reorder).
- **Markup** — the raw HTML for that button, containing `[sharerich:*]` tokens (and
  usually an SVG icon). This is where the button's appearance and link are defined.
  A **Reset** link next to each restores that service's shipped default markup.

Default service markups ship with the module (as `.inc` files under its `services/`
directory) and are scanned in automatically, so you start with a familiar set of
services — email, Facebook, Twitter/X, Tumblr, and so on (fifteen in all). Only
email, Facebook, Tumblr and Twitter/X are enabled to begin with; enable, reorder and
edit the rest as you like, or add your own service by dropping a new `.inc` file in
the `services/` directory. You can also duplicate a set to build variants for
different content types.

### Available tokens

Inside a service's markup you can use tokens that are replaced at render time using
the current page's node, term, or user:

- `[sharerich:url]` — the URL of the current page.
- `[sharerich:title]` — the page title.
- `[sharerich:summary]` and `[sharerich:description]` — a short summary of the page.
- `[sharerich:twitter_user]` — the Twitter/X *via* username from global settings.
- `[sharerich:fb_app_id]` — the Facebook App ID from global settings.
- `[sharerich:fb_site_url]` — the Facebook site URL from global settings.
- `[sharerich:youtube_username]`, `[sharerich:github_username]`,
  `[sharerich:instagram_username]` — additional social usernames from global settings.

The page tokens fall back sensibly: a node's own URL/title first, then the term, then
the current page, then the site — so a set works on any page it lands on.

## Global settings

Go to **Configuration → Sharerich → settings** (`/admin/config/sharerich/settings`).
These values feed the tokens above and cap what button markup may contain:

- **Allowed HTML** (`allowed_html`) — the set of HTML tags permitted in button
  markup. When a button renders, its markup is filtered against this list, so it acts
  as a safety limit on what the markup can output. The default list covers the tags
  the shipped buttons need, including `<svg>` and `<path>` for the icons.
- **Facebook App ID** (`facebook_app_id`) — used by the Facebook share dialog widget
  and available as `[sharerich:fb_app_id]`.
- **Facebook site URL** (`facebook_site_url`) — the site URL for the Facebook dialog,
  available as `[sharerich:fb_site_url]`.
- **Twitter user** (`twitter_user`) — the Twitter/X *via* username, available as
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

## The Print and WhatsApp buttons

These two buttons use link schemes (`javascript:` and `whatsapp:`) that Drupal
removes from saved markup as a matter of course. Sharerich re-adds them in the
browser, only on those specific links, so they work without loosening how the rest
of your site handles links. Because of that, the Print and WhatsApp buttons need
JavaScript to function; if a visitor has JavaScript disabled, those two buttons do
nothing while the others continue to work.

# Configuration

Social media share stores everything in one settings object
(`social_media.settings`), edited from a single admin form, and then you display
the links by placing a block or adding a field.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Social media share**, or navigate
   directly to `/admin/config/services/social-media`.

The form lists each supported network with its own set of fields.

## Per-network settings

For every network (Facebook share, Facebook Messenger, LinkedIn, Twitter/X,
Pinterest, WhatsApp, Email, Print) you can set:

- **Enable** — include this network in the output. A network is only rendered when
  it is enabled *and* its share URL is non-empty. (Facebook share, Facebook
  Messenger, LinkedIn, Twitter/X, Pinterest, and Email are enabled by default;
  WhatsApp and Print ship disabled.)
- **Text** — the link's visible label, for example changing "Twitter" to "X".
- **API URL** — the share endpoint the link points at, written with Token
  placeholders so it always shares the current page — for example
  `https://www.facebook.com/share.php?u=[current-page:url]&title=[current-page:title]`.
  Because these run through Token replacement at render time, each link
  automatically targets the page the block appears on. You can also point a link at
  a fixed profile URL instead to build a "follow us" bar.
- **API event** — how the URL is attached to the markup: **href** produces a normal
  `<a href>` link, while **onclick** places JavaScript in an `onclick` attribute
  (used by *Print* to call `window.print()`, and by Facebook Messenger).
- **Default image** — use the bundled SVG icon for the network. Turn it off to
  provide your own icon path in the **img** field instead.
- **Weight** — the sort order; networks are shown in ascending weight.
- **Attributes** — extra HTML attributes, one `key|value` pair per line. Common
  examples: `target|_blank`, `rel|noopener noreferrer`, or `class|my-share-class`.

Some networks also expose advanced fields: a **library** key to attach an extra
asset library (for example the Facebook SDK), and a **drupalSettings** field (again
`key|value` pairs per line) to pass values such as a Facebook application id to the
front end.

## The Email "forward this page" mode

The Email item has two extra options that turn its `mailto:` link into an in-site
forward form:

- **Enable forward** — replace the visitor's mail client with a built-in form at
  `/social-media-forward`, so visitors email the page to a friend without leaving
  the site.
- **Show forward (AJAX)** — open that forward form in a modal dialog rather than a
  full page.

## Display the links: place the block

The links only appear once you output them. The usual way is the block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want and choose **Social Sharing
   block**.
3. Optionally give it a title (for example "Share this"), set visibility
   conditions to restrict it to certain content types, pages, or roles, and save.

The block's output caches per URL path, so the links update as visitors move
between pages.

## Display the links: the field option

Alternatively, the module provides a `social_media` field type, so you can add the
share links as a field on a content type via **Manage fields** and control their
placement through the entity's display — useful when you want the buttons to sit
within the content rather than in a region.

## Editing from the command line

All settings live under a top-level `social_media` mapping inside
`social_media.settings`:

```bash
drush cget social_media.settings social_media            # read every network
drush cget social_media.settings social_media.whatsapp   # read one network
```

Because every network lives in one array, always read-modify-write the whole array
when scripting a change so you do not drop the other networks — see the
[agent configuration doc](../../agent/configure/settings.md) for ready-made
`drush php:eval` recipes (for example enabling WhatsApp, which ships disabled).
These settings export as normal config, so you can deploy your whole share setup
between environments with `drush config:export` / `drush config:import`.

## Extending with new networks

Other modules can register a brand-new network (such as Reddit or Telegram) or
alter the rendered links at runtime by subscribing to the module's three events —
`social_media.add_more_social_media`, `social_media.pre_execute`, and
`social_media.pre_render`. See the [agent events doc](../../agent/hooks/events.md)
for a worked subscriber example.

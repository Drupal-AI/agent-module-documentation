# Configuration

Configuration is in two parts: adding and tuning a Social Links field on a bundle,
and the one global setting for Font Awesome.

## Add a Social Links field

1. Go to the bundle you want to extend — for example **Structure → Content types →
   Article → Manage fields** — and click **Add field**.
2. Choose the **Social Links** field type (under the *Field types* category).
3. Set the **Allowed number of values** (cardinality). With a fixed number of
   values you can also provide default networks and links so new content starts
   pre‑populated.

## Choose the editor widget

On the bundle's **Manage form display** page, the **Social links** widget has two
options:

- **Possibility to select social network** (`select_social`) — when on, editors
  pick the platform themselves. When off (with a fixed cardinality) the networks
  are locked to your defaults and editors only fill in each link.
- **Disable order** (`disable_weight`) — removes the drag handles so editors
  cannot reorder the links.

## Choose the display formatter

On the bundle's **Manage display** page, pick one of the two formatters:

- **Font Awesome** — renders the links as icons. Its options are:
  - **Icon type** — *common* or *square* icons.
  - **Orientation** — lay the icons out *vertically* or *horizontally* (for
    example vertical in a sidebar, horizontal in a header).
  - **Open in new tab** — open each social link in a new browser tab.
- **Network name** — renders each platform's name as a plain text link, with the
  same **Open in new tab** option.

## The global Font Awesome setting

The module has one global setting:

1. Go to **Configuration → Web services → Social Link Field**
   (`/admin/config/services/social-link-field`). This page needs the **Configure
   social link field** permission.
2. Toggle **Attach Font Awesome** (`attached_fa`, on by default) — when on, the
   module loads its own external Font Awesome library so the icons render. Turn it
   **off** if your theme already loads Font Awesome, to avoid loading it twice.

You can also set this from the command line:

```bash
drush cget social_link_field.settings attached_fa
drush cset social_link_field.settings attached_fa false -y
```

## Adding more platforms

The built‑in platforms cover Drupal, homepage, email, Facebook, X/Twitter,
Instagram, LinkedIn, YouTube, Vimeo, Pinterest, Flickr, GitHub, Bitbucket,
Behance, TikTok, and several Spotify link types, among others. To add a network
that isn't included — such as Mastodon or Bluesky — a developer drops a small
platform plugin class into a custom module (with the platform's id, name, Font
Awesome icon codes, and URL prefix). After a cache rebuild it appears as a
selectable network. See the sibling
[`agent/plugins/platform.md`](../agent/plugins/platform.md) for the plugin
details.

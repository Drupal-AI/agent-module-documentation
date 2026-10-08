# Configuration

Facebook social plugins is configured from **`/admin/fb-social-plugins`** (route
`fb_social_plugins.configurations`). Reaching these forms requires the *access fb
social plugins config* permission, so grant that to the roles that should manage the
plugins.

## The four plugin settings forms

There is a separate form for each plugin. In every form you choose **which entity
types the plugin is active on** and set that plugin's layout and display options:

- **Like** (`/admin/fb-social-plugins/fb-like-configurations`) — configure layout,
  width, button size, and the action type. The Like button uses the current page's
  absolute URL automatically.
- **Share** (`/admin/fb-social-plugins/fb-share-configurations`) — the Share button
  opens Facebook's sharer dialog for the current page URL.
- **Page** (`/admin/fb-social-plugins/fb-page-plugin-configurations`) — embed a
  public Facebook Page. Set the **Page URL**, which **tabs** to show (timeline,
  messages, events), the **height**, and header/cover options.
- **Comments** (`/admin/fb-social-plugins/fb-comments-plugin-configurations`) — a
  Facebook‑account comment thread tied to the current page URL. Set the **number of
  posts** shown and the **width**.

When you enable a plugin for an entity type in its form, the module stores that
choice (as `entities.<entity_type_id>`) and makes a pseudo‑field available on that
entity type. **Flush all caches** after saving.

## Showing a plugin — two ways

**As a block.** Go to **Structure → Block layout** (`/admin/structure/block`), place
the plugin's block (Like, Share, Page, or Comments) into a region, and set its
visibility as usual.

**As a field on an entity.** For a plugin you enabled on an entity type, go to that
bundle's **Manage display** (for example **Structure → Content types → *(type)* →
Manage display**). The plugin appears as an extra field there — move it out of
*Disabled*, position it, and configure its display. Repeat per view mode if you want
it on teasers as well as full pages.

## A note on privacy

All four plugins load Facebook's JavaScript SDK, which can set cookies and let
Facebook observe visitors before any interaction. Wire these plugins into your
cookie‑consent flow and disclose the third‑party tracking per your jurisdiction.

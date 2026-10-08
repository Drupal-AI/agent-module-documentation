# Configuration

Seeds Toolbar works out of the box with sensible defaults — everything here is
about tailoring its look and behavior.

## Open the settings form

1. Log in as a user with the **Administer seeds toolbar** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Seeds Toolbar**, or navigate directly
   to `/admin/config/user-interface/seeds-toolbar`.

## Settings, field by field

- **Style** — choose **light** or **dark** for the toolbar's color scheme. The
  default is *dark*. Your choice also determines which of the logo/icon images
  below are used.
- **Compact** *(checkbox, on by default)* — when ticked, the toolbar starts
  collapsed to a narrow icon‑only strip. Unticked, it starts fully open (wider) and
  offsets the page content to make room.
- **Show search input** *(checkbox, on by default)* — shows the admin‑menu search
  box, which lets editors type to jump to any admin page. This also requires the
  user to have the **Use admin search** permission (below).
- **Support URL** — the address for the **Support** tab in the toolbar (defaults to
  the maintainer's site). Point it at your own helpdesk, or leave it empty to hide
  the Support tab entirely. It opens in a new tab.
- **Custom Style** — a path or URL to an extra CSS file. When set, it is loaded
  only while the toolbar is active, so you can layer on your own styling.
- **Custom Dark Logo / Custom Light Logo** — image paths for the logo shown in the
  toolbar header, one per mode. The dark logo is used when *Style* is dark, the
  light logo when it's light. Leave empty to use the module's bundled logo.
- **Custom Dark Icon / Custom Light Icon** — image paths for the small collapsed
  icon, again one per mode. Empty falls back to the bundled icon.
- **Try to fix fixed elements (experimental)** — loads a small script that tries to
  stop other fixed‑position page elements from overlapping the toolbar. As the
  label says, it's experimental.

Click **Save**. If the styling doesn't update, clear caches (`drush cr`).

## Permissions

Set these at **People → Permissions** (`/admin/people/permissions`):

- **Administer seeds toolbar** — access to the settings form above. This only
  exposes the module's own styling/configuration page; grant it to trusted admin
  roles.
- **Use admin search** — controls whether the admin‑menu search box is built and
  shown for a user (in combination with the *Show search input* setting above).

Two things are governed by **core** permissions, not by this module:

- **Who sees the toolbar at all** — that's core's *Access toolbar* permission.
- **The "Add" tray links** — each create link (content, taxonomy term, media,
  block) is additionally filtered by the relevant entity‑type permission, so users
  only ever see the create links they can actually use.

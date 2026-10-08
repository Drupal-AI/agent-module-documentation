# Configuration

International Phone has two levels of configuration: one **global setting** for how
the JavaScript library is loaded, and **per‑field widget settings** that control
the country selector.

## Global setting

Go to **Configuration → International Phone** (`/admin/config/phone_international`).
You need the **Administer site configuration** permission.

- **CDN** — when ticked, the intl‑tel‑input assets are loaded from a CDN. Untick it
  to serve a local copy from your `libraries/` directory (which you can download
  with the `drush phone_international:plugin` command described in
  [Installation](../installation/index.md)).

## Per‑field widget settings

The interesting configuration lives on the field itself. Add an *International
Phone* field to your entity, then open **Manage form display**, and click the cog
on the field's row. The *International Phone* widget offers:

- **Initial country** — the country preselected in the flag/dial‑code selector when
  a form first loads. Given as a two‑letter ISO country code (for example `GB`,
  `US`, `PT`). The default is `PT`.
- **Geolocation** — when on, the module tries to auto‑detect the visitor's country
  and preselects that instead of the initial country. Off by default.
- **Preferred countries** — a list of countries pinned to the top of the selector
  so common choices are easy to reach. Defaults to `PT`.
- **Countries** — how the list below is treated. Choose *all* (offer every
  country), *exclude* (offer every country except the listed ones), or *include*
  (offer only the listed ones). The default mode is *exclude*.
- **Exclude countries** — the list of countries used by the mode above: the ones to
  hide (in *exclude* mode) or the only ones allowed (in *include* mode).

Whatever the editor types, the field reformats the value to E.164 when the entity
is saved, so stored numbers are consistent.

## The display formatter

On **Manage display**, the field uses the *International Phone* formatter. It
renders each valid number as a clickable `tel:` link; numbers that fail validation
are shown as plain text rather than a broken link. There is nothing extra to
configure here for the default behaviour.

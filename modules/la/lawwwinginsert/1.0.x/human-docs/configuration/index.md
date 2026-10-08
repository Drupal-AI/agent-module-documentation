# Configuration

Everything this module does is driven from one small settings form. Until you
enter a Script ID it injects nothing at all.

## Open the settings form

1. Log in as a user with the **administer lawwwing settings** permission.
2. Go to **Configuration → Web services → Lawwwing Settings**, or navigate
   directly to `/admin/config/lawwwing`.

## The settings

- **Script ID** — your Lawwwing widget ID. When this is empty, the module injects
  nothing. When set, it attaches
  `https://cdn.lawwwing.com/widgets/current/{script_id}/cookie-widget.min.js` to
  the page `<head>`. Clearing the field is the quickest way to switch the widget
  off everywhere.
- **Active in admin** (checkbox) — whether to also include the script on admin
  routes. It is **off by default**, so the widget does not load on admin pages
  unless you tick this.
- **Permitted roles** (checkboxes) — inject the script only for users holding one
  of the selected roles. Leaving the filter so that no role a visitor has is
  selected means they get nothing. **To show the banner to anonymous visitors,
  you must explicitly select the *anonymous* role** — this is the most common
  point of confusion, since a consent banner usually needs to reach anonymous
  users.

Click **Save configuration** to apply. The attachment is cached with the
`config:lawwwing.settings` cache tag, so changes take effect after the normal
config‑based cache invalidation (clear caches with `drush cr` if you don't see the
change immediately).

## How it decides whether to inject

On each page the module: reads the Script ID and bails if it is empty; bails on
admin routes unless *Active in admin* is on; bails if the current user shares no
role with the *Permitted roles*; otherwise attaches the Lawwwing `<script>` tag to
the `<head>`.

## Third‑party script considerations

- **Content‑Security‑Policy.** If you run a CSP, add `cdn.lawwwing.com` to your
  `script-src` directive, otherwise the browser will block the widget.
- **Anonymous visitors.** Remember the role filter — a consent banner that needs
  to reach everyone requires the *anonymous* role to be selected.
- **No server‑side calls.** The module itself makes no outbound requests from your
  server; the widget is fetched client‑side by the visitor's browser from
  Lawwwing's CDN.

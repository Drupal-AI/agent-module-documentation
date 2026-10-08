# Configuration

TacJS is configured through **three forms** under **Configuration → System → TacJS**
(`/admin/config/system/tacjs`). All three require the restricted **Administer TacJS**
(`administer tacjs`) permission.

## Manage dialog

`/admin/config/system/tacjs/manage-dialog` — this is the default settings page. It
controls the banner's appearance and privacy behavior, plus the master switch:

- **Enabled** — the site‑wide on/off toggle for the whole consent banner. Turn it off
  to disable TacJS everywhere without uninstalling.
- **Privacy URL** — the link the banner points at for your privacy policy (a node or
  any URL).
- **Orientation / body position** — where the banner sits (middle, top, or bottom).
- **Show icon / icon position** — show a small persistent cookie icon so visitors can
  reopen their choices, and where it appears.
- **Deny all / Accept all** — show those call‑to‑action buttons in the dialog.
- **High privacy** — when on, no service loads until the visitor explicitly consents
  (the recommended, compliant setting).
- **Handle browser DNT request** — honor the browser's "Do Not Track" header
  automatically.
- **Group services** — group the services by category (analytics, video, ads, …) in
  the dialog.
- **Service default state** — the state services start in before the visitor chooses:
  **wait**, **true**, or **false**.
- **Cookie name, hashtag, expiry** — the consent cookie's name, the URL hashtag that
  opens the panel, and how long consent is remembered.
- **Generate active‑services file / suffix** — optionally generate a slimmed‑down
  JavaScript file containing only your enabled services (better performance), with a
  filename suffix that supports per‑domain files.

## Add services

`/admin/config/system/tacjs/add-services` — pick **which tarteaucitron services** are
enabled. The list is parsed from the library's own service catalogue, so you'll see
entries like Google Analytics, YouTube, Vimeo, Matomo, and many more. Only the
services you tick are sent to the browser and offered to visitors for consent —
enable just the ones your site actually uses.

## Edit texts

`/admin/config/system/tacjs/edit-texts` — override **every banner string**. Use this
to reword the default messages or translate them per language. The strings are run
through Drupal's token service, so tokens work in them.

## Permissions

- **Administer TacJS** (`administer tacjs`) — gates all three forms above. It is
  marked **restricted** because service and text definitions accept unfiltered text
  and JavaScript, meaning a user with this permission can inject arbitrary script into
  every front‑end page. Grant it only to fully trusted administrators.

The **TacJS Log** submodule reuses this same permission for its consent overview
report; its public consent‑logging endpoint is gated only by core's "Access content".

## For developers

You can inject a custom tarteaucitron service from your own module with
`hook_tacjs_services_alter()`, or add service content (such as a custom analytics
snippet) with `hook_tacjs_content_alter()`. See the sibling
[`agent/`](../agent/start.md) docs for details.

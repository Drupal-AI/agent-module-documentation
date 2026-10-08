# Configuration

QR Code Generator has three admin tools plus a block to place. All of the admin
tools require the core **Administer site configuration** permission.

## Global settings — the floating icon

Go to **`/admin/qr-page/config`**. This is the default appearance of the floating
QR icon that shows the current page's QR code:

- **Icon position** — where the floating QR icon sits on the page.
- **Colour** — the colour used for the icon/code.
- **Type** — how the QR is displayed (for example the QR shown as-is, or as a
  floating icon).

These settings are stored in `qrcode_generator.settings` and act as the default for
every page that does not have an override.

## Place the block

For the floating QR to appear on the front end, place the **All Pages QR Code
Block** from **Structure → Block layout** (`/admin/structure/block`) in a region.
The block encodes the current page's URL on each request (its cache max-age is 0 so
it is always current).

## Per-page overrides

If you want specific pages to use a different icon style than the global default:

- **Add an override:** `/admin/qr-page/override/add` — choose the page (matched by
  its request URI) and set the icon appearance for it.
- **Manage overrides:** `/admin/qr-page/override/list` — view and edit existing
  overrides.

When a page has a matching override, its settings are used; otherwise the global
configuration applies.

## Ad-hoc generator (QR from text or URL)

Go to **`/admin/generate-qr/from-text-url`** to generate a QR image from any text or
URL you type. The image is produced on the server (as a base64 data URI, via AJAX)
and can be downloaded for reuse — handy for print materials, campaign codes, or
sharing a specific link. The value encoded is whatever you enter (not untrusted
visitor input), and generation is fully local, so nothing is sent to a third-party
QR service.

## The scanner page

The module also provides a scanner page at **`/scanqrcode`**, available to any user
with the **Access content** permission. It renders a JavaScript-based QR scanner —
it is a template plus JavaScript, and is the only broadly accessible route the
module adds.

## Save

After adjusting the global settings or an override, save the form. Reload a
front-end page (with the block placed) to see the floating QR icon reflect your
changes.

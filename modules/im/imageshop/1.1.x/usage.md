<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imageshop connects Drupal's media/upload workflow to the Imageshop digital-asset-management service, letting editors choose images from an embedded Imageshop browser instead of (or alongside) the core media library.

---

The module authenticates to Imageshop with a permanent token plus private key that an administrator stores at `/admin/config/media/imageshop`. On demand (and via `hook_cron`) the `imageshop.token_service` exchanges those credentials for a short-lived temporary token by calling `https://webservices.imageshop.no/V4.asmx/GetTemporaryToken`; the temp token is cached in Drupal `state` for 24h. A permission-gated route `/imageshop/iframe` (`_permission: 'access imageshop'`) renders a bare page containing an iframe to `https://client.imageshop.no/InsertImage2.aspx` with the temp token and browser settings in the query string. A field widget (`ImageShopWidget`) and render element (`ImageShopElement`) hook into `media_library_add_form_upload` so selected assets flow back into Drupal. Note that the settings route requires the permission string `administer imageshop` while `imageshop.permissions.yml` only defines `administer imageshop configuration`, so the config route is effectively unreachable until that mismatch is reconciled (fails closed).

Typical setup: obtain Imageshop credentials, enter them on the settings form, grant `access imageshop` to editors, choose which media types use the Imageshop browser, then pick images through the iframe.
---
- Configure the Imageshop token and private key at `/admin/config/media/imageshop`.
- Grant the `access imageshop` permission to editorial roles.
- Choose which media types replace the core upload with the Imageshop browser.
- Optionally hide the Drupal media library for Imageshop-enabled media types.
- Open the image chooser iframe at `/imageshop/iframe`.
- Let editors select an image from the Imageshop DAM and insert it.
- Set the Imageshop interface name used in the browser.
- Choose the browser language/culture (Norwegian or US English).
- Toggle the size dialog shown in the Imageshop browser.
- Toggle the crop dialog shown in the Imageshop browser.
- Enable free-crop in the Imageshop browser.
- Enable insert-immediately behaviour.
- Rely on cron to keep the temporary Imageshop token fresh.
- Use the `imageshop.token_service` to fetch a valid temporary token programmatically.
- Alter the iframe render array via the `imageshop_iframe_render` alter hook.
- Add the Imageshop widget to an image/media field.
- Preview selected assets with a configured image style.
- Integrate Imageshop selection into the media library add form.
- Diagnose connection problems from the "settings seems to be not configured or faulty" message.
- Rotate credentials by re-entering the token/private key.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Swiss Post provides a Swiss Post shipping method, label generation and address verification.

---

Commerce Swiss Post integrates **Swiss Post** with **Drupal Commerce Shipping**. It adds a
`swiss_post` shipping method (a **flat rate** you configure — the checkout price is not quoted
from the API), generates Swiss Post **barcode/address-label PDFs** via the Swiss Post Barcode
API (storing them on the shipment and setting the tracking code), and **verifies CH/LI
addresses** against Swiss Post's Address Web Services through an address widget and a Webform
handler. It is in the Commerce (contrib) package.

Configure API credentials on the **Swiss Post Settings** page
(`/admin/config/services/swiss-post-settings`): OAuth Client ID/Secret, franking license and
label layout for labels, and host/username/password for the address service. Set up the flat
rate on the shipping method (**Commerce → Configuration → Shipping methods**). Label PDFs are
stored in the **private** file system. Label routes/actions require the
`administer commerce_shipment` permission; the settings page requires
`administer site configuration`. Customer and store **address data** is sent to Swiss Post; keep
the credentials as secrets and calls over HTTPS.

---

- Offer a Swiss Post shipping method (flat rate).
- Generate Swiss Post barcode/address labels (PDF).
- Set the shipment tracking code and link to Swiss Post tracking.
- Verify CH/LI addresses via Swiss Post Address Web Services.
- Validate addresses in an address widget or a Webform handler.
- Store label PDFs on the shipment (private files).
- Configure credentials on the Swiss Post Settings page.
- Configure the flat rate on the shipping method.
- Print a label from a shipment operation or a bulk order action.
- Send store/customer address data to the carrier.
- Keep API credentials as secrets over HTTPS.
- Merge multiple labels into one PDF.
- Delete stored labels after 180 days via cron.
- Alter the barcode payload via ShipmentToBarcodeEvent.

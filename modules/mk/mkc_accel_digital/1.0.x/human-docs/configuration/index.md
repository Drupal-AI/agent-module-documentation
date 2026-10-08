# Configuration

There is one central settings screen for the accelerator, plus two management
screens where you administer the downloads and licenses that customers accumulate.

## Open the settings

Go to **Commerce → Digital → Settings**
(`/admin/commerce/digital/settings`). Here you configure how digital delivery
behaves:

- **Download limits** — how many times a purchased file may be downloaded, and any
  expiration window on download links. These map onto each DigitalDownload's
  download-count and expiration tracking.
- **License key formats** — the pattern used when keys are generated automatically
  on purchase (for example a UUID, a serial, or a custom pattern).
- **Delivery options** — how links and keys are provisioned and presented to the
  customer on order completion.

Save the form to apply your choices.

## Manage downloads and licenses

- **Downloads** (`/admin/commerce/digital/downloads`) — review every digital
  download, its associated product variant, and its usage against the configured
  limits.
- **Licenses** (`/admin/commerce/digital/licenses`) — view and manage license keys,
  including their activation state (activated, deactivated, expired). You can assign
  keys manually here in addition to the automatic generation on purchase.

## How delivery works at checkout

Once configured, no per-order action is needed: a digital-only cart skips the
shipping step automatically, and download links plus license keys are provisioned
the moment the order completes. Mixed carts (digital + physical) still charge
shipping on the physical items only. Customers then find their purchases at
`/user/downloads` and `/user/licenses`, with actual file delivery served through the
signed, token-based `/digital/download/{token}` endpoint.

## Test it

Place a test order for a digital product and confirm the customer receives a working
download link and (if applicable) a license key, that the download count increments,
and that the configured limit/expiry is enforced.

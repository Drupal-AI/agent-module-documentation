# Configuration

## Open the settings form

1. Log in as a user with the **Administer commerce AvaTax** permission (a
   restricted, trusted‑admin permission).
2. Go to **Commerce → Configuration → AvaTax settings**, or navigate directly to
   `/admin/commerce/config/avatax`.

These settings are stored in the `commerce_avatax.settings` config object.

## The settings, field by field

| Field | Default | What it does |
|---|---|---|
| **API mode** | Development | Choose **Development** (uses Avalara's sandbox, `sandbox-rest.avatax.com`) or **Production** (uses `rest.avatax.com`). Start in Development, switch to Production when you go live. |
| **Account ID** | *(empty)* | Your Avalara account ID — the username half of the API credentials. |
| **License key** | *(empty)* | Your Avalara license key — the password half of the API credentials. Keep this secret. |
| **Company code** | `DEFAULT` | The default Avalara company code for transactions. A store can override this with its own company‑code field. |
| **Customer code field** | Order email (`mail`) | Which order value becomes the AvaTax `customerCode` for logged‑in customers when no explicit customer code is set — the order **email** or the **user ID**. |
| **Disable document committing** | Off | When on, tax is calculated but no sales‑invoice transaction is committed to AvaTax on placement (report/calculation only). |
| **Disable tax calculation** | Off | Turns AvaTax tax calculation off entirely without uninstalling the module. |
| **Shipping tax code** | `FR020100` | The Avalara tax code applied to shipment lines. Only shown when Commerce Shipping is installed. |
| **Logging** | Off | Logs full request and response details to the `commerce_avatax` log channel. Useful for debugging — see the security note below. |

### Address validation

A group of options controls whether AvaTax suggests corrected addresses:

- **Enable address validation** — validate the customer's shipping address on the
  checkout form and offer AvaTax's suggested correction.
- **Enable on the admin shipment form** — also validate addresses on the admin
  shipment form (requires Commerce Shipping).
- **Countries** — restrict validation to specific countries.
- **Require full postal‑code match** — when on, only a full postal‑code match is
  accepted; otherwise a 5‑digit prefix match is enough to suppress a suggestion.

## Saving also checks your credentials

When you save, the form calls Avalara's `ping` endpoint with the credentials you
entered. If they authenticate, it then fetches your list of companies and
verifies that the **Company code** you entered actually exists on the account.
So a successful save confirms both that your credentials work and that your
company code is valid.

## The fields the module adds

Beyond the settings form, the module adds fields you configure on individual
entities:

- **Store → AvaTax company code** — a per‑store override of the global company
  code.
- **Product variation → AvaTax tax code** — the Avalara tax code for that
  product (this drives the default per‑item tax‑code logic).
- **User → AvaTax customer code, tax‑exemption number, tax‑exemption type** —
  set a customer's AvaTax customer code and their exemption details (for B2B /
  wholesale customers). Editing these user fields requires the **Configure
  AvaTax exemptions** permission (see below).

## Permissions

| Permission | Restricted | Grants |
|---|---|---|
| **Administer commerce AvaTax** | Yes | Access to the settings form (account ID, license key, API mode, address validation, and so on). Trusted admins only. |
| **Configure AvaTax exemptions** | No | The ability to edit the three user fields — AvaTax customer code, tax‑exemption number, and tax‑exemption type — on a user profile. Scope this to staff who manage B2B/wholesale exemptions. It does **not** expose credentials or settings. |

## Security note on logging

If you turn **Logging** on, the logged request headers include the base64‑encoded
HTTP Basic authorization value (built from your account ID and license key).
Leave logging **off** in production, or restrict who can view the logs. It is an
admin‑only toggle and is off by default.

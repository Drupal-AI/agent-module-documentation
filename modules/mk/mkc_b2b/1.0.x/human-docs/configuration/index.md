# Configuration

Most B2B configuration happens on the settings screen plus the entities you create
(companies, price lists, approval policies). The one item you must not overlook is
the **PunchOut shared secret**, covered first because leaving it unset is a security
risk.

## Open the settings

Go to **Commerce → B2B → Settings**
(`/admin/commerce/b2b/settings`), with the B2B dashboard at
`/admin/commerce/b2b`.

## Set the PunchOut shared secret (do this before using PunchOut)

If you integrate with e-procurement systems over cXML/OCI PunchOut, the endpoints
`/mkc/punchout/cxml` and `/mkc/punchout/oci` authenticate inbound requests using a
**SharedSecret**. The check is only applied when a secret has been configured — so
until you set one, the endpoints accept **anonymous** PunchOut sessions. Configure
the shared secret in the module settings before enabling PunchOut in production.

Store that secret as a secret, not in committed configuration. With DDEV:

```bash
ddev dotenv set .ddev/.env --mkc-punchout-secret=<value>
ddev restart
```

Then reference the environment variable from the module's PunchOut settings (or a
Key entity where supported). Confirm it is present without printing it:

```bash
ddev exec 'test -n "$MKC_PUNCHOUT_SECRET"'   # exit status 0 means it is set
```

## Companies, users and roles

Create **Company** accounts (billing info, tax-exemption status, credit limits) and
map Drupal users to them as **CompanyUser** records with buyer, manager or admin
roles and configurable spending limits. This is the backbone the rest of the B2B
features hang off.

## Pricing

Set up **ContractPriceList** entities to give specific companies or customer tiers
their own prices; the contract-price resolver applies them automatically at cart
time for the logged-in company.

## Approval workflows

Define **ApprovalPolicy** rules with spending thresholds. Orders that exceed a
buyer's limit are routed to a manager for approval before they proceed.

## Purchase orders, quotes, quick order and reorder

- **Purchase orders** — allow vetted companies to check out with a PO number
  instead of a card.
- **Request for quote** — buyers submit carts as quotes; your sales team can
  counter-offer or accept from the admin. Buyers manage quotes at
  `/account/company/quotes`.
- **Quick order / reorder** — buyers can paste SKU lists for bulk ordering or
  re-order from history.

## PunchOut integration

Beyond the shared secret, connect your procurement platform (SAP Ariba, Coupa, SAP
SRM/OCI) to the PunchOut endpoints. Carts are transferred back to the procurement
system via `/mkc/punchout/complete`.

## Test it

Create a test company and buyer, confirm contract pricing resolves in their cart,
push an order over its approval threshold and confirm it routes for approval, and —
if using PunchOut — verify that a request without the correct shared secret is
rejected.

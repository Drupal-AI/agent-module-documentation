# Configuration

There are two things to set up: the **invoice types** (their numbering,
appearance, and email behavior) and **when invoices are generated** (per order
type). Both are done in the admin UI under Commerce.

## Invoice types

Go to **Commerce → Configuration → Invoice types**
(`/admin/commerce/config/invoice-types`). This requires the *Administer
commerce_invoice_type* permission. Two types are installed by default —
**Invoice** and **Credit memo** — and you can add your own (for example a
pro-forma invoice) with the *Add invoice type* button.

Each invoice type has these settings:

- **Number pattern** — which Commerce number pattern formats the sequential
  invoice number. The defaults are `invoice_default` and `invoice_credit_memo`.
  The pattern is what turns an internal ID into a human invoice number.
- **Workflow** — the state-machine workflow the invoice follows. The shipped
  `invoice_default` workflow has the states *draft*, *pending*, *paid*,
  *refund_pending*, *refunded*, and *canceled*, with transitions to confirm, pay,
  refund, and cancel.
- **Footer text** — text printed at the bottom of the invoice.
- **Payment terms** — free-text payment-terms wording shown on the invoice.
- **Due days** — the number of days until the invoice is due.
- **Logo** — a managed file (your company logo) shown on the generated invoice.
- **Send confirmation** — when on, the customer is emailed the invoice (with the
  PDF attached) as soon as it is generated.
- **Confirmation BCC** — an address that is blind-copied on every confirmation
  email, handy for an accounts-payable inbox.

**Invoice item types** (the line items) are managed separately at
`/admin/commerce/config/invoices/invoice-item-types`.

## Automatic generation — configured per order type

Invoice generation is not a single global switch; you turn it on for each order
type. Edit an order type at
`/admin/commerce/config/order-types/<type>/edit` and you will find two settings
added by this module:

- **Invoice type** — which invoice type to generate for orders of this type.
- **Generate invoice when order is placed** — when ticked, an invoice is created
  automatically the moment an order of this type is placed.

In addition, the module always generates an invoice when an order becomes **fully
paid**. Between the "order placed" toggle and the "order paid" behavior, most
stores get invoices created automatically without any code.

## Creating invoices manually

Staff can also create an invoice by hand. Open an order in the admin UI and use
its **Invoices** (or **Credit memos**) tab to generate one on demand. From there
you can also resend the confirmation email.

## Rendering and PDFs

Invoices are rendered to PDF through the Entity Print module, which Commerce
Invoice installs as a dependency. Generated PDFs can be stored in a private
subdirectory per invoice type. No extra configuration is required for basic PDF
output, though you may want to review Entity Print's own settings to choose a PDF
engine.

## Permissions

Under **People → Permissions**, the notable permissions are:

- **Administer commerce_invoice_type** — manage invoice types and their fields.
  Keep this to staff/administrator roles.
- **Administer commerce_invoice** — full control over invoice entities.
- **View any invoice** (`view commerce_invoice`) — see every invoice.
- **View own invoices** (`view own commerce_invoice`) — the key customer-facing
  permission: grant it to authenticated users so logged-in buyers can see their
  own invoices under their account.

There are also per-invoice-type view/create/update/delete permissions if you need
finer-grained, bundle-scoped access.

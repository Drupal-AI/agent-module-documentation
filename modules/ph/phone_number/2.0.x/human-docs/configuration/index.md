# Configuration

Phone Number has no central settings page — you configure it **per field**, across
the three standard field‑management screens (Manage fields, Manage form display,
and Manage display). This page walks through each setting.

## Add the field

1. Go to the bundle you want to add a phone number to, e.g. **Structure → Content
   types → [your type] → Manage fields**.
2. Click **Add field** (or **Create a new field**) and choose **Phone Number**.
3. Give it a label (e.g. "Phone") and save.

## Storage settings

These apply to the field across all bundles (set when the field is first created):

- **Unique** — when enabled, the same phone number cannot be stored on more than
  one entity. Use this if a phone number should identify a single account or
  record.

Behind the scenes each value is stored in four parts: the canonical **E.164**
number, the **country** (ISO code), the **local number**, and an optional
**extension**.

## Field settings (per bundle)

On the field's settings (the **Manage fields → [field] → Edit** screen):

- **Allowed countries** — restrict input to a chosen set of countries. Leave empty
  to allow numbers from any country.
- **Allowed types** — restrict to particular phone‑number types (for example
  mobile or fixed line). Leave empty to allow all types. Numbers that don't match
  the allowed countries/types are rejected on save.
- **Extension field** — turn this on to show an extra input for a phone extension
  alongside the number.

## Widget settings — the input (Manage form display)

On **Manage form display**, the **Phone Number** widget has these options:

- **Default country** — the country pre‑selected in the input (defaults to `US`).
- **Country selection** — how editors choose the country: a **flag** selector or a
  plain **dropdown**.
- **Placeholder** — placeholder text shown in the empty input (defaults to "Phone
  number").
- **Phone size** — the visible width of the input, in characters (defaults to 15).

## Formatter settings — the display (Manage display)

On **Manage display**, pick one of three formatters for the field:

- **International** (`phone_number_international`) — shows the number in E.164
  international format. Its **"as link"** option renders it as a clickable `tel:`
  link — ideal for a "call us" link that dials directly on mobile.
- **Local** (`phone_number_local`) — shows the number in local, national format.
  It also offers the "as link" option.
- **Country** (`phone_number_country`) — shows the number's country (name or code,
  per the formatter's display type).

## Verify it worked

Add or edit an entity with the field. Try entering an invalid number — it should
be rejected — then a valid one, and confirm it displays in your chosen format (and,
if you enabled the link option, that the `tel:` link works).

## For developers

If you need to validate or format numbers in custom code, use the
`phone_number.util` service (interface `PhoneNumberUtilInterface`), which wraps the
libphonenumber library — see the sibling [`agent/`](../agent/start.md) docs for its
methods.

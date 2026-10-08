# Configuration

All of the module's behavior is driven by a single settings form.

## Open the settings form

1. Log in as a user with the **Access Bring postal code settings** permission
   (`access bring postal code settings`) — grant it under **People → Permissions**.
2. Go to **Configuration → Bring postal code**, or navigate directly to
   `/admin/config/bring-postal-code`.

The settings are stored in the `bring_postal_code.settings` configuration object.

## The fields

- **Client URL** — the Bring postcode service URL that the visitor's browser
  calls. It should end with `?`; the lookup appends the country, postcode, and
  client‑URL parameters to it. Point this at the Bring endpoint (or environment)
  you want to use.
- **Attach to forms** — a newline‑separated list of form IDs. The module attaches
  the lookup only to forms whose ID matches one of these lines, so you can enable
  it on a Commerce checkout, a node add/edit form, a custom form, or a taxonomy
  term form just by listing the right ID(s).
- **Input / output selectors** — one entry per line, written as
  `input|output|country` jQuery selectors, for example `#code|#name|#country`.
  - `input` is the postcode field the visitor types into.
  - `output` is the place‑name field that gets filled in.
  - `country` is optional — a selector for a country field. Omit it
    (`#code|#name`) to use the default country below.
- **Default country** — used when a selector line has no country segment, or when
  the country field is empty.
- **Trigger length** — the minimum number of characters that must be typed before a
  lookup fires. This avoids sending a request on every keystroke.

## How it behaves

When a visitor types into a configured input and the value reaches the trigger
length, the module's JavaScript makes a JSONP request to the client URL with the
postcode and country. On a match it writes the returned place name into the output
field; on no match it shows an "Invalid postcode" message.

## Important: no server‑side validation

Everything happens in the browser — there is **no server‑side validation** of the
postcode or the resulting place name. Use it purely as an entry convenience. If the
correctness of an address matters (for example for shipping or billing), enforce
authoritative address validation server‑side as well; do not rely on this module's
output as a verified address.

## Save

Click **Save configuration**. Load one of the forms you listed and type a postcode
to confirm the place‑name field fills in.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webform_promotion_code` element

## Add it to a form

Admin: **Structure → Webforms → (your form) → Build → Add element → "Promotion code element"**
(category "Advanced elements"). It renders as a single-line text field (`<input type="text">`,
default `#size` 60).

## Configuration properties

Set on the element via the UI ("Promotion code settings" fieldset) or directly in the Webform's
element YAML:

| Property       | Type     | Purpose |
|----------------|----------|---------|
| `codes`        | textarea | The valid codes, **one per line**. This is the only property that affects validation. |
| `amount`       | number   | How many codes the "Auto generate" button creates (default 100). |
| `code_length`  | number   | Length of each auto-generated code (default 6). |
| `code_pattern` | textfield| Character set for auto-generation (default `ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789`). |

Example element in a Webform's `elements` YAML:

```yaml
promo:
  '#type': webform_promotion_code
  '#title': 'Promotion code'
  '#required': true
  '#codes': |
    SPEAKER2026
    PARTNER-10
    VIP-ACCESS
```

`amount` / `code_length` / `code_pattern` are **not required** for a working element — they only
feed the client-side generator. They have no config schema, so leaving stray values is harmless.

## Auto-generate helper

The element config form shows an **Auto generate** button (`span.wpc-auto-generate`). Clicking it
runs `js/webform_promotion_code.js`: it reads `amount`, `code_length`, and `code_pattern` from the
form, builds that many random strings with `Math.random()`, and **appends** them to the `codes`
textarea (existing lines are kept). This is a convenience for populating the list; it runs entirely
in the browser and writes nothing until you save the element. Note the generator uses
`Math.random()`, which is not cryptographically strong — for high-value codes, generate them with a
secure source instead and paste them in.

## Validation contract

On submit, `Drupal\webform_promotion_code\Element\WebformPromotionCode::validateWebformPromotionCode()`:

1. If the field value is empty (`''`), it returns without error — an empty promo field passes unless
   you also mark the element `#required`.
2. Otherwise it `trim()`s the submitted value, `explode()`s `#codes` on newlines, `trim()`s each
   line, and checks `in_array($submitted, $valid_codes)`.
3. Match → no error. No match → form error "*<element title>* must be a valid code." The error text
   does **not** reveal the valid codes, and the submitted value is not echoed back.

The comparison is **case-sensitive** and exact after trimming (surrounding whitespace on both the
input and each stored line is ignored; internal characters must match exactly).

## Making codes single-use

The element itself has **no redemption tracking** — the same valid code passes on every submission.
To enforce single use, enable Webform's built-in **Unique** constraint on the element (element
settings → "Validation" / "Unique"). That makes Webform reject a value that already exists in a
prior submission of the same form, effectively one-redemption-per-code **per form**. It does not
work across different forms and does not disable a code by a date or a global counter — for those
you would need custom code or a different module.

## Limitations to design around

- Codes are stored as plaintext in the Webform's configuration (and thus in config exports / git).
- No per-code expiry, no usage counter, no "amount remaining" — a code is simply valid or not.
- No built-in throttling; pair short codes with adequate length/entropy and rely on Webform/core
  flood protection to blunt brute-force guessing.

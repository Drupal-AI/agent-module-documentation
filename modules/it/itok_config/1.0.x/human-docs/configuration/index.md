# Configuration

Itok Config has no settings page of its own. Instead it adds a single option to
**each image style's edit form**, so you decide per style whether the `itok`
signature is applied to that style's derivative URLs.

## Disable itok on an image style

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. Click **Edit** on the image style you want to change.
3. Use the option this module adds to the form to **disable the `itok` token** for
   that style.
4. **Save** the image style.

From then on, URLs for that style's derivatives are generated **without** the
`?itok=…` signature — giving you clean, predictable, CDN-friendly paths.

## Understand the trade-off

The `itok` token is a deliberate **security feature** in core:

- **With `itok` (the default):** derivative URLs carry a signature, so requests for
  arbitrary, not-yet-generated variants are rejected. This blocks an attacker from
  forcing your server to generate endless image derivatives (a denial-of-service
  vector).
- **Without `itok` (what this module lets you do):** derivative URLs become
  **guessable**. That is convenient for caching and CDNs, but it removes the anti-DoS
  protection.

Only disable `itok` for styles where guessable URLs are acceptable — typically when
a CDN or another layer already controls how and how often derivatives can be
generated. If you are unsure, leave `itok` enabled.

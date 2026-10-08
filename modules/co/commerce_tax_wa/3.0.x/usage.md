<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Tax WA calculates tax for Washington State by looking up rates.

---

Commerce Tax Washington calculates **Washington State (US) sales tax** for Drupal Commerce — looking up the
destination-based rate (WA uses destination sourcing with many local rates) for an order's address. It depends
on Commerce Tax, in the Commerce package.

Use it to apply correct WA sales tax. It is an e-commerce/tax feature. It looks the rate up per order address
from the **Washington State Department of Revenue's public HTTPS web service** (a fixed host, no API key) and
falls back to an admin-configured default rate if that service errors. Tax is resolved and applied
server-side via Commerce Tax (authoritative), from the order's address — not a client-supplied rate. It has no
access-control role. Configure the WA tax type at Admin → Commerce → Configuration → Tax types.

---

- Calculate Washington State sales tax.
- Look up the destination rate.
- Handle WA destination sourcing.
- Depend on Commerce Tax.
- Apply tax per order address.
- Serve US WA commerce.
- Handle any rate-API credentials as secrets.
- Use HTTPS.
- Apply tax server-side via Commerce Tax.
- Have no access-control role.
- Configure the WA tax settings.
- Handle WA tax.
- Calculate tax.
- Configure taxation.
- Apply sales tax.
- Handle the lookup.
- Compute tax.
- Configure Commerce tax.
- Set the tax.
- Provide WA tax.

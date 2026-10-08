<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IDNA Convert exposes the `algo26-matthias/idna-convert` library as a Drupal service that converts domain names between Unicode and Punycode (IDNA / "xn--…").

---

Install with Composer (`composer require drupal/idna`, which pulls in the `algo26-matthias/idna-convert` library) and enable the module (`drush en idna`). There is nothing to configure — no settings page, no config schema, no permissions to tune beyond the single `access idna` permission that guards the built-in demo page at `/idna` (grant it to trusted roles if you want the demo). In code, call `\Drupal::service('idna')->encode($input)` to turn a Unicode domain into Punycode (e.g. `münchen.de` → `xn--mnchen-3ya.de`) and `\Drupal::service('idna')->decode($input)` to reverse it. Both methods inspect the input and treat it as a URL, an email address (only the host part is converted), or a bare domain; an input that already contains `xn--` is returned unchanged by `encode`. The service is also registered under the alias `idna.service`. Bear in mind IDN handling is relevant to phishing — homograph attacks use lookalike Unicode domains — so this module supplies the conversion primitive, not a phishing defence, and any code that displays or validates domains should account for that.

---

- Convert a Unicode domain to Punycode with `encode()`.
- Convert a Punycode domain back to Unicode with `decode()`.
- Encode an internationalized email address (host part only).
- Encode a full URL containing an internationalized host.
- Normalize domains to ASCII before a DNS lookup.
- Store domains in ASCII/Punycode form.
- Display Punycode domains in their readable Unicode form.
- Reuse the `algo26-matthias/idna-convert` library as a shared Drupal service.
- Call the service from a custom module, form, or controller.
- Reference the service via `idna` or the `idna.service` alias.
- Try conversions interactively on the `/idna` demo page.
- Grant `access idna` to let trusted roles use the demo page.
- Feed multiple domains at once (one per line) on the demo forms.
- Skip re-encoding values that already contain `xn--`.
- Validate that a submitted domain round-trips through encode/decode.
- Prepare internationalized domains for email or link generation.
- Keep the module enabled only where the conversion service is needed.
- Restrict the demo route to administrators or developers.
- Test conversions on your own domains before relying on them.
- Review behavior after upgrading the underlying library.

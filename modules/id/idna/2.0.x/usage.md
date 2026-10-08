<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IDNA Convert exposes the `algo26-matthias/idna-convert` library as a Drupal service that converts domain names, URLs and email hosts between Unicode and Punycode (IDNA / "xn--…").

---

Install with Composer (`composer require drupal/idna`, which pulls in `algo26-matthias/idna-convert` `^4.2`) and enable the module (`drush en idna`); the 2.x branch targets Drupal `^11 || ^12`. There is nothing to configure — no settings page and no config schema — beyond the single `access idna` permission that guards the built-in demo page at `/idna` (grant it to trusted roles if you want the interactive forms). In code, call `\Drupal::service('idna')->encode($input)` to turn a Unicode domain into Punycode (e.g. `münchen.de` → `xn--mnchen-3ya.de`) and `\Drupal::service('idna')->decode($input)` to reverse it. Both methods inspect the input and treat it as a URL, an email address (only the host after `@` is converted), or a bare domain; an input that already contains `xn--` is returned unchanged by `encode`. In 2.x the `IdnaConvertInterface` declares both methods, so you can type-hint against the interface as a stable contract, and the service is also registered under the alias `idna.service`. Bear in mind IDN handling is relevant to phishing — homograph attacks use lookalike Unicode domains — so this module supplies the conversion primitive, not a phishing defence, and any code that displays or validates domains should account for that.

---

- Convert a Unicode domain to Punycode with `encode()`.
- Convert a Punycode domain back to Unicode with `decode()`.
- Encode an internationalized email address (host part only, local part kept verbatim).
- Encode a full URL that contains an internationalized host.
- Normalize domains to ASCII/Punycode before a DNS lookup.
- Store domains in ASCII/Punycode form in your entities or config.
- Display stored Punycode domains in their readable Unicode form.
- Reuse the `algo26-matthias/idna-convert` library as a single shared Drupal service.
- Call the service from a custom module, form, controller, or plugin.
- Reference the service via `idna` or the `idna.service` alias.
- Type-hint dependencies on `Drupal\idna\Service\IdnaConvertInterface`.
- Try conversions interactively on the `/idna` demo page.
- Grant `access idna` to let trusted roles use the demo page.
- Feed multiple domains at once (one per line) on the demo forms.
- Skip re-encoding values that already contain `xn--`.
- Validate that a submitted domain round-trips through encode/decode.
- Prepare internationalized domains for email or link generation.
- Restrict the demo route to administrators or developers only.
- Keep the module enabled only where the conversion service is actually needed.
- Test conversions on your own domains before relying on them in production.
- Review behavior after upgrading the underlying `idna-convert` library.
- Upgrade from the 8.x-1.x branch to 2.x for Drupal 11/12 support.

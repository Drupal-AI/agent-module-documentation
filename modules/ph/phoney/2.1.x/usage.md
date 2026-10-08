<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Phoney provides a Twig template to obfuscate a field_phone value.

---

Phoney provides a Twig template that obfuscates a phone-number field (`field_phone`) when displayed — for
example scrambling/encoding the number so simple scrapers don't harvest it directly from the markup. It
depends on core Field, in the Fields package.

Use it to lightly deter phone-number scraping. **Understand its limits: this is a client-side/display
obfuscation, NOT real protection.** The phone number is still delivered to the browser (to be shown), so a
determined scraper or anyone viewing the rendered page can still obtain it (via the source, deobfuscation, or
simply reading it). It reduces casual harvesting but does not keep the number private — do **not** rely on it
to protect a number that must not be exposed (don't publish it at all in that case). It has no access-control
role. Apply the template to the phone field.

---

- Obfuscate a phone-number field's display.
- Deter casual phone scraping.
- Scramble the number in markup.
- Depend on core Field.
- KNOW it is display obfuscation, NOT protection.
- Understand the number is still delivered to the browser.
- Not rely on it to keep a number private.
- Not publish numbers that must stay private.
- Reduce casual harvesting only.
- Have no access-control role.
- Apply the template to the phone field.
- Handle phone obfuscation.
- Deter scrapers.
- Configure the display.
- Obfuscate phone numbers.
- Understand the bypasses.
- Apply the Twig template.
- Handle field_phone.
- Deter harvesting.
- Obfuscate display.

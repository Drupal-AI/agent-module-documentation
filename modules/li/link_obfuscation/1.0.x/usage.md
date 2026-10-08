<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link obfuscation helper module obfuscates links to make them harder for bots/scrapers to harvest, typically for email/mailto protection.

---

Link obfuscation is a helper module that obfuscates links — encoding/scrambling link markup (commonly
`mailto:` email links) so that automated scrapers/bots harvesting the page can't easily read the address,
while browsers still render a working link (usually via JavaScript decoding). This reduces email-address
harvesting and spam.

Use it to protect email addresses (or other links) in content from bots. Note the framing: obfuscation is a
**deterrent, not real protection** — it raises the bar for naive scrapers but determined harvesters (that
run JS or parse the encoding) can still recover the address, and JS-based decoding can affect no-JS/
accessibility. Use it as a light anti-harvesting measure, not as a guarantee that addresses stay private. It
is a content-display/filter feature with no access-control role.

---

- Obfuscate links to deter bots.
- Protect email/mailto links.
- Reduce address harvesting.
- Scramble link markup.
- Render working links in the browser.
- Decode via JavaScript.
- Reduce spam from harvested emails.
- Understand it is a deterrent, not protection.
- Know determined scrapers can recover addresses.
- Mind no-JS/accessibility impact.
- Use as a light anti-harvesting measure.
- Have no access-control role.
- Encode email addresses.
- Deter naive scrapers.
- Protect content links.
- Obfuscate mailto links.
- Raise the harvesting bar.
- Apply light protection.
- Hide emails from bots.
- Reduce email exposure.

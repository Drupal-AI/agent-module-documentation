<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform JavaScript Setting Element pulls a JavaScript settings property into a hidden webform field.

---

Webform JavaScript Setting Element **captures a JS settings value into a hidden field** — a webform element
that reads a property from a JavaScript settings object (client-side) and stores it in a hidden field submitted
with the form (e.g. capturing a client-computed value). It depends on the Webform module.

Use it to capture a client-side JS value in submissions. It is a webform/developer feature with an important
data-trust note: because the value is **populated client-side into a hidden field, it is fully attacker-
controllable** (a user can change any hidden field before submit) — so **never trust this value for security
decisions** server-side (authorization, pricing, identity); treat it as untrusted user input and validate/re-derive
anything security-relevant server-side. It has no access-control role. Configure the JS setting element.

---

- Capture a JS settings value.
- Store it in a hidden field.
- Submit a client-computed value.
- Depend on the Webform module.
- Serve webform/developers.
- Read a JS settings property.
- POPULATE the value client-side (fully attacker-controllable).
- NEVER trust the value for security decisions server-side.
- Treat it as untrusted input + re-derive anything security-relevant server-side.
- Have no access-control role.
- Configure the JS setting element.
- Handle JS settings.
- Capture values.
- Configure the element.
- Read settings.
- Handle the hidden field.
- Store values.
- Configure Webform.
- Handle the input.
- Not trust the value.
- Provide a JS setting element.

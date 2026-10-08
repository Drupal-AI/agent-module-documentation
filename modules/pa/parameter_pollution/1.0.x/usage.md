<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Parameter Pollution mitigates HPP attacks by removing duplicate query parameters and keeping only the last occurrence.

---

HTTP Parameter Pollution (parameter_pollution) is a security-hardening module that mitigates HTTP
Parameter Pollution (HPP) attacks — where an attacker supplies the same query parameter multiple times to
confuse or bypass server-side parsing. A `KernelEvents::REQUEST` subscriber cleans duplicate query
parameters, keeping only the last occurrence, so downstream code sees a single, predictable value per
parameter rather than an ambiguous set. Rather than rejecting the request, it normalizes it. It is in the
Security package.

Use it as a defense-in-depth control against HPP-based bypasses/confusion. This is a positive security
measure. Note the design choice: it keeps the **last** occurrence of a duplicated parameter — this matches
PHP's own default behaviour, but be aware that "last wins" normalization could, in unusual cases, differ
from what some framework/proxy layers expect; it is a sensible default for Drupal/PHP. It has no
content-access role; it hardens request parsing. Enable it to normalize incoming query parameters.

---

- Mitigate HTTP Parameter Pollution.
- De-duplicate query parameters.
- Keep only the last occurrence.
- Normalize ambiguous parameters.
- Clean duplicates in a request subscriber.
- Prevent HPP-based bypasses.
- Apply a defense-in-depth control.
- Give downstream code predictable values.
- Not reject, but normalize requests.
- Match PHP's last-wins default.
- Harden request parsing.
- Have no content-access role.
- Reduce parameter confusion.
- Enable HPP protection.
- Normalize incoming query params.
- Prevent parameter smuggling.
- Apply a positive security measure.
- Clean query strings.
- Handle duplicate params safely.
- Harden against HPP.

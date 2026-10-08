<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cryptolog enhances user privacy by replacing client IP addresses with ephemeral identifiers, so raw IPs are not stored in logs.

---

Cryptolog is a privacy-enhancing module that replaces client IP addresses with ephemeral,
non-reversible identifiers — so Drupal's logs and any code reading the client IP see a rotating
pseudonymous value instead of the visitor's real IP. This reduces the personal-data footprint (IP
addresses are personal data under GDPR) while still allowing per-visitor correlation within the
identifier's lifetime (e.g. for flood control or abuse detection). It is configured at
`cryptolog.settings`.

Use it to minimize retention of raw visitor IPs for privacy/GDPR reasons while keeping short-term
correlation. This is a positive privacy control. Be aware of the trade-off: because the real IP is
replaced early, features that genuinely need the true client IP (precise geolocation, IP allow-lists,
forensic investigation) won't see it — decide whether that is acceptable for your site, and configure
the identifier rotation accordingly. It has no negative access implications.

---

- Replace client IPs with ephemeral IDs.
- Keep raw IPs out of logs.
- Reduce personal-data footprint.
- Enhance visitor privacy.
- Support GDPR data minimization.
- Keep short-term visitor correlation.
- Configure at cryptolog.settings.
- Rotate the identifier over time.
- Pseudonymize IP addresses.
- Allow flood control on the pseudonym.
- Understand real IP is replaced early.
- Weigh loss of true-IP features.
- Configure identifier rotation.
- Minimize IP retention.
- Protect visitor IPs.
- Apply a positive privacy control.
- Anonymize logged IPs.
- Reduce IP exposure.
- Keep abuse detection working.
- Handle IPs privately.

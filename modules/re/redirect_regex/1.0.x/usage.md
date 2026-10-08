<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redirect Regex extends the Redirect module to support regex pattern matching using core redirect entities.

---

Redirect Regex extends the Redirect module with regex-pattern matching — so a redirect can match a
family of source paths via a regular expression (and substitute captured groups into the destination),
rather than only exact-path redirects. It uses core redirect entities and validates the configured regex. It
depends on Redirect (>=1.12) and provides its own permissions.

Use it for pattern-based redirects (e.g. redirect a whole old URL structure to a new one). Two
security-relevant considerations: (1) **regex against request paths can be a ReDoS risk** — a poorly-written
admin regex could cause catastrophic backtracking on crafted paths (self-inflicted DoS); the module validates
regex syntax, but write anchored, efficient patterns. (2) **capture-group destinations can risk open
redirects** — if the destination is built from parts of the matched path (captured groups) and those parts
are attacker-influenced, a crafted request could produce an unintended destination; because it uses
`TrustedRedirectResponse` (which permits external redirects), avoid destination templates where an attacker-
controlled capture group could form an external URL — anchor patterns and keep the host portion of
destinations fixed. It has no content-access role. Configure the regex redirects carefully.

---

- Add regex-pattern redirects.
- Match a family of source paths.
- Substitute captured groups into destinations.
- Extend the Redirect module.
- Use core redirect entities.
- Validate the configured regex.
- Write anchored, efficient patterns (ReDoS).
- Avoid attacker-influenced capture-group destinations.
- Keep destination hosts fixed (open-redirect).
- Mind TrustedRedirectResponse permits external redirects.
- Depend on Redirect (>=1.12).
- Provide its own permissions.
- Redirect old URL structures.
- Configure regex redirects carefully.
- Prevent catastrophic backtracking.
- Anchor patterns.
- Handle pattern redirects.
- Configure the regex.
- Avoid open redirects.
- Redirect by pattern.

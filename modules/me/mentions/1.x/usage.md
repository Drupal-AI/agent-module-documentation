<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mentions records, renders and reacts to @-mention patterns within content, linking a mention to the referenced user or entity.

---

@-mentioning a user in a comment or post — and notifying or linking them — is a community feature. Mentions detects mention patterns, renders them as links, and can react (e.g. notify). The security-relevant part of any mention system is the rendering: a mention pattern comes from user-authored content, so it must be resolved and rendered safely — the resolved link/label should be escaped, and a mention should not let a user inject markup or reveal a user who should not be discoverable. Confirm mentions render as safe, escaped links, and that mentioning respects user visibility (mentioning should not disclose accounts a user could not otherwise see). Used as a community feature it links people; the care is in safe rendering and not leaking user existence.

---

- Add @-mentions to content.
- Link a mention to a user.
- Notify a mentioned user.
- Render mention patterns.
- React to mentions.
- Ensure mentions render escaped.
- Respect user visibility on mention.
- Avoid markup injection via mentions.
- Build a community mention feature.
- Confirm safe rendering.
- Detect mention patterns.
- Link mentions safely.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.
<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevent absolute internal links adds validation to link fields to ensure internal links are specified properly (relative, not absolute).

---

Prevent absolute internal links adds validation to Link fields — ensuring that links to internal
content are entered as proper internal/relative references rather than hard-coded absolute URLs (e.g.
`https://example.com/page` instead of `/page` or an entity reference). This avoids hard-coded domains in
content, which break on domain changes and across environments. It is in the Newcity package.

Use it to enforce clean internal linking in content. It is a content-editing/validation feature that
validates link input on save; it does not change access. Note it improves link portability/correctness (a
maintenance benefit); it also incidentally reduces the chance of accidentally linking to the wrong
environment. Apply the validation to the relevant link fields.

---

- Validate internal links are relative.
- Prevent absolute internal URLs.
- Enforce proper internal linking.
- Avoid hard-coded domains in content.
- Improve link portability.
- Validate link fields on save.
- Not change access.
- Reduce wrong-environment links.
- Apply to link fields.
- Enforce internal-link format.
- Improve link correctness.
- Validate on input.
- Handle internal references.
- Configure link validation.
- Ensure relative internal links.
- Avoid environment-specific URLs.
- Validate links.
- Enforce clean linking.
- Prevent absolute links.
- Validate internal URLs.

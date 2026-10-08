<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search and Replace (snr) searches and replaces text content in fields, performing bulk find-and-replace across content.

---

Search and Replace (snr) performs find-and-replace across text field content — searching for a string
across content and replacing it in bulk, useful for correcting a repeated typo, updating a URL/brand name
site-wide, or similar mass edits. It ships an `snr_safe` submodule (a safer/preview mode). It is in the
Search and Replace package.

Use it for bulk content corrections. **Caution: this performs bulk, potentially irreversible content
modification** — a bad search/replace can corrupt many pieces of content at once. So: restrict it to
trusted administrators, always back up (or use the `snr_safe` preview) before running, and test the
replacement on a small scope first. It reads and writes content, so it acts with the operator's privileges
and has no access-control role of its own. Run replacements deliberately.

---

- Find and replace text across fields.
- Perform bulk content edits.
- Correct a repeated typo site-wide.
- Update a URL/brand name in bulk.
- Use the snr_safe preview mode.
- Restrict to trusted admins.
- Back up before running.
- Test on a small scope first.
- Understand it is bulk/irreversible.
- Act with the operator's privileges.
- Have no access-control role.
- Run replacements deliberately.
- Search content for a string.
- Replace across content.
- Avoid corrupting content.
- Preview before applying.
- Do mass edits carefully.
- Correct content in bulk.
- Replace field text.
- Handle bulk find-and-replace.

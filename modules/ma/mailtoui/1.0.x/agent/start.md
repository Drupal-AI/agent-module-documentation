<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mailtoui — agent start

JavaScript-only enhancement of `mailto:` links: a clicked mailto opens a small modal offering webmail
options (Gmail/Outlook/Yahoo) and copy-to-clipboard. Wraps the standalone MailtoUI JS library.

- `hook_page_attachments()` attaches `mailtoui/mailtoui` (`js/mailtoui.js`) on all pages; the library
  auto-inits against the page's mailto anchors.
- No server code, no config form, no routes, no permissions, no dependencies.
- Minor cosmetic bug: `hook_help` uses route `help.mailtoui` (should be `help.page.mailtoui`) so help
  text won't render — harmless.

Security: nothing server-side; no attack surface of note.

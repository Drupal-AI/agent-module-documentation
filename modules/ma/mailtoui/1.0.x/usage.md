<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailto UI is a lightweight front-end enhancement that upgrades ordinary `mailto:` links. Instead of
immediately handing off to the OS default mail client, a clicked mailto link opens a small modal offering
choices such as opening the message in a popular webmail service (Gmail, Outlook, Yahoo) or copying the
email address to the clipboard. It wraps the standalone [MailtoUI](https://mailtoui.com) JavaScript
library.

---

The module is JavaScript-only: `hook_page_attachments()` attaches the `mailtoui/mailtoui` library
(`js/mailtoui.js`) on every page, and the bundled script auto-initialises against the site's `mailto:`
anchors. There is no server-side code, no configuration form, no routes, no permissions, and no
dependencies. Behaviour and theming are driven entirely by the underlying MailtoUI library's conventions
(e.g. it targets standard mailto links and renders its own modal markup/styles). A minor cosmetic bug: the
`hook_help` switch uses route name `help.mailtoui` instead of `help.page.mailtoui`, so the help text does
not render — this has no functional or security impact.

---

- Give visitors a choice of webmail (Gmail/Outlook/Yahoo) when clicking an email link.
- Let users copy an email address to the clipboard from a modal.
- Improve the UX of mailto links for people without a desktop mail client.
- Avoid the "nothing happens" problem when no default mail app is configured.
- Enhance contact-page email links site-wide with zero configuration.
- Provide a consistent modal for all mailto links across a theme.
- Reduce friction for mobile users who prefer webmail.
- Drop-in mailto enhancement without editing templates or content.
- Keep email links accessible while adding extra options.
- Apply automatically to author/contact links in content.
- Offer a copy-address action for support or sales addresses.
- Deploy across the whole site via a single attached library.
- Enhance footer or header contact links.
- Add a modern UI layer over legacy mailto content.
- Use on marketing pages to smooth email call-to-actions.
- Require no PHP, config, or permissions to operate.

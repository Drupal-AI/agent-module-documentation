<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email Token provides three global `[etf:*]` tokens and a matching text-format filter that turn the current page title/URL into a share-by-email link.
---
The module registers a token type `etf` with three tokens (`[etf:gin-title]` = current page title, `[etf:gin-url]` = absolute current URL, `[etf:gin-email]` = a rendered "mail me" `<a href="mailto:...">` link wrapped in a `div.gin-email-token`). The same three placeholders are also handled by a filter plugin, `Email Token Filter` (`filter_glift`-style id `email_token`), so you can drop the placeholders straight into node/block body text once the filter is enabled on the text format. Both the token and the filter resolve the values at render time from the current request via the `title_resolver` service and `Url::fromRoute('<current>')`.

There is no configuration UI, no routes, and no permissions — behaviour is entirely driven by enabling the filter on a text format (`/admin/config/content/formats`) and by placing the tokens. The mailto link body is a fixed English string ("We appreciate your spreading the word.") plus the page URL; the subject is the page title. Because output is produced by a text filter, only users who can use the chosen text format can insert the placeholders.
---
- Enable the "Email Token Filter" on Basic/Full HTML at /admin/config/content/formats.
- Insert `[etf:gin-email]` in a block to render a "mail me" share link.
- Insert `[etf:gin-title]` to print the current page title inline.
- Insert `[etf:gin-url]` to print the absolute current URL.
- Style the share link via the `.gin-email-token` / `.mid-email-token` CSS class.
- Add an email-share icon by attaching a background image to that class.
- Use the tokens anywhere Drupal token replacement runs (where `etf` is available).
- Provide a "share this page" affordance without a contributed sharing module.
- Prefill an email subject with the browser/page title.
- Include the current node URL in the shared email body automatically.
- Combine with a custom block placed on article pages only.
- Localise the mailto by relying on the current language URL options.
- Add the placeholders to a view header/footer text area using the format.
- Keep share markup editorial (in body text) rather than in theme templates.
- Verify token output on the Help page (help.page.email_token).
- Restrict who can add the link by controlling text-format permissions.
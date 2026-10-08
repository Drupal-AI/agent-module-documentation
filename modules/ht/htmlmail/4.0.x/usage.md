HTML Mail replaces Drupal's default plain-text mail system with an HTML mailer so system emails can be themed with Twig templates just like the rest of your site.

---

HTML Mail provides a Drupal `@Mail` plugin (`htmlmail`) that formats and sends outgoing messages as HTML. It depends on the Mail System module, which routes which modules' mail goes through the HTML Mail formatter/sender. On install it registers itself in `system.mail` and sets the Mail System `defaults.sender`/`defaults.formatter` to `htmlmail`. Each message body is rendered through a Twig template using the theme hook `htmlmail`, with template suggestions of `htmlmail--{module}--{key}.html.twig`, `htmlmail--{module}.html.twig`, then `htmlmail.html.twig`, resolved first in a selected "Email theme" directory and then in the module. An optional post-filter (any text format, e.g. Emogrifier to inline CSS, Pathologic to absolutize URLs, Transliteration) can run after theming, and an optional PEAR `\Mail_mime` path builds multipart MIME with attachments. A plaintext alternative can be generated, and individual users can opt to receive plaintext-only mail. A settings form and a "Send test" form live under Admin → Configuration → System.

---

- Turn Drupal's transactional/system emails (user registration, password reset, contact form, commerce notifications) into styled HTML.
- Theme emails with your site's look by selecting an Email theme that holds the templates.
- Provide a custom default email layout by overriding `htmlmail.html.twig` in a theme.
- Customize a specific module's emails with `htmlmail--{module}.html.twig` (e.g. `htmlmail--user.html.twig`).
- Customize a single message with `htmlmail--{module}--{key}.html.twig` (e.g. `htmlmail--user--password_reset.html.twig`).
- Send a branded, HTML password-reset email (ships with `htmlmail--user--password_reset.html.twig`).
- Route only certain modules through HTML while leaving others plain, via the Mail System settings page.
- Inline CSS into style attributes for webmail/mobile compatibility using the Emogrifier post-filter.
- Rewrite relative image/link URLs to absolute URLs in emails using the Pathologic post-filter.
- Convert non-ASCII characters to ASCII equivalents with the Transliteration post-filter to avoid smart-quote artifacts.
- Attach a plain-text alternative part to HTML mail to improve spam-filter scores.
- Build multipart MIME messages (with attachments) using the optional PEAR `\Mail_mime` class.
- Let end users opt out of HTML and receive plaintext-only email via a checkbox on their account form.
- Grant a role the `choose htmlmail_plaintext` permission so those users can pick plaintext.
- Add debugging output to the bottom of test emails to see which template/theme resolved.
- Send a test email from the admin UI to verify templates and formatting before going live.
- Add or modify email template variables from another module via `hook_preprocess_htmlmail()`.
- Pair with the Echo module so the selected theme renders the body as a full themed webpage.
- Apply any of Drupal's 200+ filter modules as a post-theming step on outgoing mail.
- Force the site "From" header to include the site name when it matches the default sender.
- Prevent HTML mail to recipients who set the plaintext preference (respected automatically at format time).
- Migrate email presentation control out of code and into themeable Twig templates.

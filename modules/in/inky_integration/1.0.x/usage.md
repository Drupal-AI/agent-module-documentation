<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
inky_integration wires the Twig Inky and CSS-inliner extensions into Drupal so you can author responsive HTML emails using Foundation for Emails' Inky syntax with automatic CSS inlining.
---
The module registers two Twig extensions as services: `Twig\Extra\Inky\InkyExtension` (converts Inky's semantic email tags — `<row>`, `<columns>`, `<button>`, etc. — into email-safe table markup) and `Twig\Extra\CssInliner\CssInlinerExtension` (inlines CSS into style attributes for email-client compatibility). It ships the Foundation for Emails CSS (`css/foundation-for-emails.css`) and an `email-wrap.html.twig` template, plus `.module` hooks that make the `email_wrap` template available in the admin theme and expose the module path to it. Despite the README's phrasing, the module makes **no external network/service calls** — it is purely a Twig/templating helper.

Operationally it requires the PHP `xsl` extension (and the `twig/inky-extra`, `twig/cssinliner-extra`, `twig/extra-bundle` Composer packages); Composer will refuse to install without `ext-xsl` enabled. There are no routes, permissions, services beyond the Twig extensions, or configuration UI. Maintenance note: periodically refresh the bundled Foundation-for-Emails CSS from upstream.
---
- Author responsive HTML emails with Inky tags in Twig.
- Convert `<row>`/`<columns>` markup to email-safe tables.
- Inline CSS automatically for email-client compatibility.
- Use Foundation for Emails styles in Drupal email templates.
- Build newsletter templates with semantic Inky syntax.
- Apply the `inky` Twig filter/tag in a mail body template.
- Apply the `inline_css` (CssInliner) filter in templates.
- Wrap email content with the provided `email_wrap` template.
- Preview email templates in the admin theme.
- Keep email CSS maintainable via an external stylesheet.
- Standardize transactional email markup across a site.
- Pair with a mail module to render themed emails.
- Avoid hand-writing nested email tables.
- Ensure emails render across major email clients.
- Reuse Foundation email components in Twig.
- Update the bundled Foundation CSS from upstream periodically.
- Require `ext-xsl` in the PHP environment for Inky.
- Provide a component-style approach to email theming.
- Compose buttons, rows, and columns in email Twig.
- Inline styles at render time without a build step.

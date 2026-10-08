<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Postoffice is a small developer-facing API for sending themed emails with Symfony Mailer.

---

Rather than core's mail manager, code builds a Symfony `Email`/`RawMessage` and hands it to the `postoffice.mailer` service. A `StackedMailer` runs the message through a tagged middleware pipeline before the configured transport sends it: `CleanRenderContext`, `AnonymousUser` (switches to an anonymous account so mails don't leak the current user's access), `Theme` (renders the body in the configured mail theme) and `Language` (switches to the recipient's language). Bodies are rendered by a `ThemedBodyRenderer` via a Symfony message listener, and a default-address subscriber fills in From/sender defaults. The transport is created from a DSN, so any Symfony Mailer transport (smtp, sendmail, native, or a third-party bridge) works.

Configuration is a single form at `/admin/config/system/postoffice` behind the `administer postoffice configuration` permission (marked `restrict access`) storing the transport **DSN** and the **mail theme** in `postoffice.site`. The project ships optional extension submodules — Compat (core user/contact mail plugins), Compat Theme, Skel (HTML document wrapper), Html2Text, Inline Styles, Twig (`postoffice_subject`, `postoffice_text_body`), Image (`postoffice_image_embed`) and File (attach entities/URIs) — each enabling extra Twig helpers or integrations. There are no anonymous or mutating web endpoints; it is a code-first API.

---
- Set the Symfony Mailer transport DSN at `/admin/config/system/postoffice`.
- Choose the theme used to render HTML mail bodies.
- Send a themed email from custom code via the `postoffice.mailer` service.
- Implement `SiteEmailInterface`/`ThemedEmailInterface` on a message class.
- Attach templates/attachments using the provided traits.
- Render an email body from a Twig template through `ThemedBodyRenderer`.
- Send mail as an anonymous user to avoid leaking current-user access.
- Send localized mail rendered in the recipient's language.
- Add a custom mailer middleware via the `postoffice.mailer_middleware` tag.
- Point the DSN at an external SMTP relay.
- Route core user account emails through Postoffice (`postoffice_compat`).
- Route core contact form emails through Postoffice.
- Ensure core-manager mail uses the Postoffice theme (Compat Theme).
- Wrap HTML mails in a full HTML document (Skel).
- Auto-generate a plain-text part from HTML (Html2Text).
- Inline library CSS into the markup (Inline Styles).
- Set a subject from a Twig template with `postoffice_subject` (Twig ext).
- Attach a text body part from Twig with `postoffice_text_body`.
- Embed an image (optionally via an image style) with `postoffice_image_embed`.
- Attach a managed file entity or URI from Twig (File ext).
- Configure default From/sender addresses via the default-address subscriber.

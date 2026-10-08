<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Postoffice developer API

## Configure transport
`/admin/config/system/postoffice` (permission `administer postoffice configuration`) stores the
Symfony Mailer **DSN** and **mail theme** in `postoffice.site`. The DSN drives which transport is
built (`Mailer::__construct` → `Transport::fromDsn($dsn)`), e.g.
`smtp://user:pass@host:port`, `sendmail://default`, or `native://default`.

## Send an email
Build a Symfony Mime email and send it through the stacked mailer:
```php
use Symfony\Component\Mime\Email;

$email = (new Email())
  ->to('to@example.com')
  ->subject('Hello')
  ->html('<p>Themed body</p>');

\Drupal::service('postoffice.mailer')->send($email);
```

## Middleware pipeline
`StackedMailer` runs services tagged `postoffice.mailer_middleware` in priority order before the
transport sends:
- `CleanRenderContext` (1000) — isolates the render context.
- `AnonymousUser` (500) — switches to an anonymous account so mail rendering can't leak the
  current user's access-controlled content.
- `Theme` (300) — renders the body using the configured mail theme.
- `Language` (200) — switches to the recipient/site language.

Add your own by defining a service tagged `{ name: postoffice.mailer_middleware, priority: N }`.

## Themed message classes
Implement the interfaces/traits under `src/Email/` on a message value object:
- `SiteEmailInterface` + `SiteEmailTrait`, `ThemedEmailInterface`, `LocalizedEmailInterface`,
  `TemplateAttachmentsInterface` + `TemplateAttachmentsTrait`, `UrlOptionsTrait`.
Bodies are rendered from Twig by `ThemedBodyRenderer`.

## Extension modules
| Module | Adds |
|---|---|
| postoffice_compat | `postoffice_user_mail` / `postoffice_contact_mail` plugins: `drush config:set system.mail interface.user postoffice_user_mail` |
| postoffice_compat_theme | forces core-manager mail through the Postoffice theme |
| postoffice_skel | wraps HTML mail in a full HTML document |
| postoffice_html2text | auto plain-text part (needs soundasleep/html2text) |
| postoffice_inline_styles | inlines CSS (needs tijsverkoyen/css-to-inline-styles) |
| postoffice_twig | `postoffice_subject`, `postoffice_text_body` Twig helpers |
| postoffice_image | `postoffice_image_embed` Twig helper |
| postoffice_file | `postoffice_file_attach_entity` / `_attach_uri` Twig helpers |

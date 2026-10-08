<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Postoffice (postoffice) — agent index

**A developer API that sends themed emails through Symfony Mailer via a middleware pipeline.**

- **Version:** 1.2.x
- **Core:** ^10.3 || ^11
- **Configure route:** `postoffice.site_settings` → `/admin/config/system/postoffice`
- **Permission:** `administer postoffice configuration` (`restrict access: true`)
- **Config object:** `postoffice.site` (keys: `dsn`, mail theme)
- **Key services:** `postoffice.mailer` (`StackedMailer`), `postoffice.mailer.basic` (`Mailer`, builds transport from DSN), `postoffice.body_renderer`, middlewares tagged `postoffice.mailer_middleware` (`CleanRenderContext` 1000, `AnonymousUser` 500, `Theme` 300, `Language` 200)
- **Extensions:** postoffice_compat, postoffice_compat_theme, postoffice_skel, postoffice_html2text, postoffice_inline_styles, postoffice_twig, postoffice_image, postoffice_file
- **Security:** single admin config route, permission-gated and restrict-access; no anonymous/mutating web endpoints; code-first API. DSN may embed transport credentials — treat config as sensitive.

See [api/postoffice.md](api/postoffice.md)

# Email template & theme suggestions

Theme hook `symfony_mailer_lite_email` (registered in `hook_theme`, `mail theme => TRUE`).
Default template: `templates/symfony-mailer-lite-email.html.twig`.

Variables (see `template_preprocess_symfony_mailer_lite_email`): `message`, `is_html`,
`base_url`, `subject`, `body`, `attributes`.

## Per-module / per-key overrides
`hook_theme_suggestions_symfony_mailer_lite_email()` adds, in order:
- `symfony_mailer_lite_email__MODULE`
- `symfony_mailer_lite_email__MODULE__KEY` (key `-` → `_`)

So `symfony-mailer-lite-email--user--password-reset.html.twig` styles only that mail. Place
overrides in your (mail) theme.

Migrating from Swiftmailer: copy `swiftmailer.html.twig` → `symfony-mailer-lite-email.html.twig`,
and a theme `swiftmailer` library → `symfony_mailer_lite`.

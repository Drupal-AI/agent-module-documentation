# Tokens, Views tracking & CSP

Beyond the snippet, `matomo.module` and `src/` provide three integrations.

## Tokens
`matomo.tokens.inc` implements `hook_token_info()` / `hook_tokens()` to expose Matomo-related
tokens, usable in settings that accept tokens (and anywhere the Token API is available).

## Views event tracking
`src/Plugin/views/display_extender/Matomo.php` is a Views **display extender**. Enable
display extenders in Views settings, then on a view's display you can configure it to push a
Matomo event when the view renders (wired via `hook_views_post_render()` →
`ViewsPostRenderHookHandler`). Useful for tracking searches/listings as Matomo events.

## Content-Security-Policy
`src/EventSubscriber/CspSubscriber.php` cooperates with the `csp` module so Matomo's inline
tracking snippet is allowed under a strict CSP (hash/nonce). No config beyond installing the
CSP module; the composer.json marks `drupal/csp < 1.12` as a conflict.

## Migration
`src/Plugin/migrate/process/` ships process plugins (`MatomoVisibilityPages`,
`MatomoVisibilityRoles`, `MatomoCustomVars`) plus migrations under `migrations/` to import
legacy Piwik/analytics settings.

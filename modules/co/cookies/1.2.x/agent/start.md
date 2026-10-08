# cookies (COOKiES) — agent start

GDPR consent-management framework built on the `cookiesjsr` JS library. Shows a consent banner
(the **COOKiES UI** block, `cookies_ui_block`) and *knocks out* third-party scripts — rewriting them
to `type="text/plain"` — until the matching consent category is granted. Consent is modelled as
`cookies_service` entities grouped into `cookies_service_group`s. Depends on core `config_translation`
and `block`. Config UI: **Admin → Config → System → COOKiES** (`/admin/config/system/cookies/config`),
route `cookies.config`.

Each popular 3rd-party service is a **separate `cookies_*` submodule** (integration bridge) you enable —
`cookies_ga`, `cookies_matomo`, `cookies_gtag`, `cookies_facebook_pixel`, `cookies_instagram`,
`cookies_twitter_media`, `cookies_video`, `cookies_recaptcha`, `cookies_ivw`, `cookies_asset_injector`,
`cookies_filter`. They are thin, near-identical bridges and are **not documented individually here**;
copy one as the pattern for a new integration.

- Configure the banner, categories & `cookies_service` gate entities → [configure/cookies.md](configure/cookies.md)
- JS/PHP consent API + the knock-out (blocking scripts until consent) → [api/cookies.md](api/cookies.md)
- Permissions → [permissions/cookies.md](permissions/cookies.md)

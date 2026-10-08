# Global settings & text

Two forms, both under `/admin/config/user-interface/klaro`:

## Settings (`klaro.admin` → `SettingsForm`, config `klaro.settings`)
Global behavior of the consent widget: styling/theme, default toggled state, whether the
banner shows automatically, testing mode, cookie name/domain/expiry (days), and library
loading options. Stored in `klaro.settings` (see `config/schema/klaro.schema.yml`), so it is
exportable via `drush config:export`.

## Text settings (`klaro.admin.texts` → `TextSettingsForm`, config `klaro.texts`)
All user-facing copy: consent notice, accept/decline/OK labels, purpose/service headings,
"learn more" text, contextual-consent text. Kept separate so translators (and
`config_translation`, which the module supports) can localize the banner without touching
behavior.

## Bundled defaults & recipe
- `config/install/` ships many predefined services (`klaro.klaro_app.*`: matomo, ga, gtm,
  youtube, vimeo, google_maps, leaflet, facebook, x, linkedin, instagram, stripe, …) and
  purposes (`klaro.klaro_purpose.*`: analytics, advertising, external_content, security,
  styling, livechat). Enabled ones appear immediately in the banner.
- A **Google Consent Mode** recipe lives in `recipes/google_consent_mode/` — apply it to
  wire Klaro consent into Google's consent-mode signals.

Manage the individual service/purpose entities on the [services & purposes](services-purposes.md)
screens.

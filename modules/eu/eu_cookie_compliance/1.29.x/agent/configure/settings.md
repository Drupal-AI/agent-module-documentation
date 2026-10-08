# Configure the cookie banner

All settings live in the single config object `eu_cookie_compliance.settings` (schema:
`config/schema/eu_cookie_compliance.schema.yml`). Edit at
`/admin/config/system/eu-cookie-compliance/settings` (route `eu_cookie_compliance.settings`,
permission `administer eu cookie compliance popup`).

## Key settings keys
- `popup_enabled` (bool) — turn the banner on/off.
- `popup_clicking_confirmation` / `popup_scrolling_confirmation` (bool) — consent by click / scroll.
- `method` — consent model: `default` (info banner) or `categories` / consent‑default (category opt‑in).
- `eu_only` (bool, GeoIP) and `eu_only_js` (bool, JS country check) — limit banner to EU visitors.
- `popup_position` (bool) — top vs bottom; `fixed_top_position` — don't scroll with page.
- `popup_info` / `popup_agreed` — message + button markup for the two banner states (translatable).
- `exclude_paths` — paths where the banner is suppressed.
- `disabled_javascripts` — scripts blocked until consent (used with categories).
- `consent_storage_method` — id of the ConsentStorage plugin used to log consent.

## Cookie categories
Category‑based consent uses `cookie_category` config entities (own schema
`cookie_category.schema.yml`, list builder + forms under `src/`). Manage them under the
same admin section (permission `administer eu cookie compliance categories`). Each category
has a machine id, label, description and whether it is required/pre‑checked.

## Export / deploy
Because everything is config, export with the normal config workflow
(`drush config:export`) — `eu_cookie_compliance.settings.yml` plus any
`eu_cookie_compliance.cookie_category.*.yml`. Strings are translatable via
config translation (`eu_cookie_compliance.config_translation.yml`).

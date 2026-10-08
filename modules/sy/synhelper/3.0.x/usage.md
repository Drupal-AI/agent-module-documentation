<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Synapse Helper is a multi-purpose site-building helper for Synapse/Synatix Drupal sites: SEO no-index control, FZ-152/GDPR consent, cookie notice, Yandex Metrica/Ecommerce tracking, contact-form and Commerce helpers, plus Drush commands.

---

Synapse Helper (synhelper) bundles the conveniences the Synapse (Synatix) installation profile relies on into one module driven from a single settings form at `/admin/config/synapse/synhelper`. It can forbid search-engine indexing across the whole site and specifically for a `1c.*` subdomain, add a Russian FZ-152 personal-data consent checkbox to every contact form and to the user register form, render a cookie-consent banner, and inject a Yandex Metrica counter with optional Yandex Ecommerce dataLayer events and per-form conversion goals. It serves a shipped privacy policy at `/policy` (and `/policy/{lang}`) and a demo styles page at `/demo-page` from static `assets/` and `content/` files, both gated by config flags. On top of configuration it ships many `hook_*` implementations (organized as classes under `src/Hook/`) that normalize submitted `contact_message` entities, alter Commerce checkout/product output, transliterate uploaded filenames, embed CSS as `<link>` elements, and intentionally guide administrators (pre-filling checkboxes, warning on the module-update screen). Services under `src/Service/` export and import Commerce/content entities as YAML, and `src/Drush/Commands/` plus `src/Command/` add CLI tooling. It depends on the `idna` module. All mutating behavior is admin-configuration driven; the public routes are read-only.

---

- Forbid search-engine indexing of the whole site (adds a `robots: none` meta tag) via the "Search engines indexing is forbidden" toggle.
- Hide a `1c.YOUR-DOMAIN` subdomain from indexing when the host starts with `1c.`.
- Always no-index sensitive paths (`/user/login`, `/user/password`, `/policy`, `/policy/ru`, `/policy/en`).
- Show a runtime status-report warning/error reflecting the current indexing state (`src/Hook/Requirements.php`).
- Add an FZ-152 "I consent to the processing of personal data" checkbox to all `contact_message` forms.
- Add the same consent checkbox as a required field on the user register form.
- Serve a shipped privacy & cookie policy page at `/policy` and `/policy/{lang}` (en/ru), shown only when FZ-152 is enabled.
- Serve a demo "styles" page at `/demo-page`, shown only when the "Styles page" flag is on.
- Display a cookie-consent notice with a configurable text and link (defaults to `/policy`).
- Inject the Yandex Metrica counter snippet (skipping admin paths and user 1), optionally with an ecommerce `dataLayer`.
- Fire Yandex Metrica `reachGoal` conversions on contact-form AJAX submit, mapped by "goal|form_id" lines.
- Build Yandex Ecommerce product/purchase payloads from Commerce products, variations and orders (`YandexEcommerceBuilder`).
- Normalize submitted contact messages: fill empty name/mail/subject/message from known custom fields (`ContactMessageNormalizer`).
- Pre-fill the order contact form's hidden "zakaz" field with the current node's id and title.
- Transliterate and sanitize uploaded file destination names on validation (`src/Hook/FileValidate.php`).
- Embed module CSS as `<link>` elements via `hook_css_alter()`.
- Export content/Commerce entities of a type+bundle to YAML with `drush synhelper:export` (console command).
- Import config YAML files, adding missing UUIDs, with `drush synhelper:cim` (alias `syncim`).
- Generate a PhpStorm `.phpstorm.meta.php` metadata file with `drush synhelper:phpstorm`.
- `VACUUM` a SQLite database with `drush synhelper:sqlite-vacuum`.
- Alter Commerce checkout multistep and product templates for Synapse theming.
- Set the PHP mail "From" via `hook_phpmail_alter_from_alter()`.
- Guide administrators: pre-fill field/node-type/field-config form defaults and warn on the update-manager install screen.

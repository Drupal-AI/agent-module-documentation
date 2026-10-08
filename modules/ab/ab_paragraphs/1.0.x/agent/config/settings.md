<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object, analytics-provider wiring, editor helper

## Route + form

`ab_paragraphs.routing.yml` defines one route: **`ab_paragraphs.settings.form`** →
`/admin/config/content/ab-paragraphs`, `_form: AbParagraphsSettingsForm`, permission
**`administer site configuration`**. Registered as `configure:` in the info.yml and linked from
`system.admin_config_content` via `ab_paragraphs.links.menu.yml`.

`src/Form/AbParagraphsSettingsForm.php` (`extends ConfigFormBase`, id
`ab_paragraphs_settings_form`, editable config `ab_paragraphs.settings`). Injects
`config.factory`, `config.typed`, `module_handler`. It renders one `radios` element
`analytics_provider` with options built at runtime:
- `matomo` — labeled with the configured URL from `matomo.settings` (`url_https` ?: `url_http`) or
  "(not configured)".
- `piwik_pro` — labeled with `piwik_pro.settings` `piwik_domain` or "(not configured)".
- `google_analytics` — always available.
- `google_tag_manager` — offered only if the `google_tag` module exists (else "(module not
  installed)").
A collapsed `details` section shows links to the Matomo / Piwik Pro settings routes when those
modules are enabled. `submitForm()` saves `analytics_provider` to `ab_paragraphs.settings`.

## Config object + schema

- `config/install/` — the shipped default lives in `ab_paragraphs.settings.yml`:
  `analytics_provider: matomo`.
- `config/schema/ab_paragraphs.schema.yml` — `ab_paragraphs.settings` is a `config_object` with a
  single `string` key `analytics_provider`.

## How the provider is used

`ab_paragraphs_page_attachments()` runs on `entity.node.edit_form` and `node.add` only. It:
- attaches library `ab_paragraphs/trackingcode_suggestions`;
- reads `analytics_provider` (default `matomo`) and pushes it into
  `drupalSettings.abParagraphsSettings.analyticsProvider`;
- resolves a `trackingUrl` — for `matomo` from `matomo.settings` (`url_https` ?: `url_http`), for
  `piwik_pro` from `piwik_pro.settings` `piwik_domain` — and pushes it into
  `drupalSettings.abParagraphsSettings.trackingUrl`.

The provider value **only shapes the editor-side suggestions and the runtime dispatch**; it does
not itself load any analytics library. The actual event dispatch in `js/ab_test.js` auto-detects
whichever tracker global (`_paq` / `ppms` / `gtag` / `dataLayer`) is present regardless of this
setting.

## Editor helper (`js/trackingcode_suggestions.js`)

`Drupal.behaviors.trackingCodeSuggestions` runs on node add/edit forms. It scans each A/B test
subform for link fields / CKEditor content, extracts hrefs, and renders copy-to-clipboard
suggestion snippets into the tracking-code fields' description area — `_paq.push([...])` for
Matomo/Piwik or `gtag('event', …)` for GA/GTM, per the selected provider. Suggestion code is
escaped with `Drupal.checkPlain` before insertion and copied via `navigator.clipboard`; it is a
convenience only — editors paste/edit the snippet into the tracking-code field themselves.
`ab_paragraphs_form_alter()` supports this by tagging entity-autocomplete textfields with a
`data-resolved-path` attribute (the referenced entity's URL) so the helper can suggest a real path.

## Note on `AbLogController`

`src/Controller/AbLogController.php::log()` decodes a JSON POST body and writes a watchdog notice
(`\Drupal::logger('ab_paragraphs')->notice(...)`, placeholdered) when `variant`, `uuid`, and
`paragraph_id` are present. **No route maps to it** in this release, so it is not reachable; the
front-end JS does not call it either (it dispatches to the analytics library instead).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & runtime attachment (convivial_profiler)

## Install / enable

Depends on `convivial_core`. Enable, then visit **`/admin/config/convivial/profiler/settings`**
(`administer convivial profiler`). Nothing is attached to the front-end until both **Site ID** and
**License key** are set — `ConvivialProfilerHooks::pageAttachments()` returns early otherwise.

## Config object `convivial_profiler.settings`

Install defaults (`config/install/convivial_profiler.settings.yml`): `site_id: ''`,
`license_key: ''`, `client_cleanup: true`, `event_tracking: true`, `cookieconsent: true`,
`profilers: {}`, `visibility: {}`. Schema: `config/schema/convivial_profiler.schema.yml`
(a `config_object`; `profilers` is a sequence of mappings with `sources`/`processors`/
`destinations` sub-sequences; `visibility` is a sequence of `condition.plugin.[id]`).

`SettingsForm` (`src/Form/SettingsForm.php`, id `convivial_profiler_settings_form`,
`extends ConfigFormBase`) fields:

- **site_id** (textfield, required) — machine-readable site ID.
- **license_key** (textfield) — the purchased key, or the literal `community` for free/non-profit
  use. A warning is shown while empty. It is stored as a plain config string and, when set, is
  sent to the browser (below) as SDK configuration — it is a client-side identifier, not a
  server-side secret, so no Key entity or env var is used.
- **client_cleanup** (checkbox) — clear stored client values when the client ID changes.
- **event_tracking** (checkbox) — enable dataLayer click event tracking.
- **cookieconsent** (checkbox) — opt into Convivial cookie-consent gating (sets the
  `ConvivialProfilerCookieConsent` cookie so the SDK may set `ConvivialProfilerClientId`).
- **visibility** (vertical tabs) — build-config forms for exactly four core condition plugins:
  `entity_bundle:node`, `request_path`, `user_role`, `language`. Each condition's config is saved
  under `visibility.<condition_id>`. `submitForm()` `trim()`s site_id/license_key and re-saves each
  condition via `$condition->getConfiguration()`.

`convivial_profiler_update_10001()` (`.install`) back-fills `cookieconsent = TRUE`.

## Runtime attachment (what leaves the browser)

`ConvivialProfilerHooks::pageAttachments()` (service `Drupal\convivial_profiler\Hook\ConvivialProfilerHooks`,
args `@config.factory`, `@context.repository`, `@plugin.manager.condition`):

1. Return early unless `site_id` AND `license_key` are set.
2. Evaluate each `visibility` condition. For each, it only applies the condition if all its required
   contexts are available in `context.repository`; if an applicable condition fails, assets are not
   attached (`$attach_profilers = FALSE`).
3. If it passes, attach library `convivial_profiler/init` and set
   `drupalSettings.convivialProfiler` = `{ site, license_key, client_cleanup, event_tracking,
   cookieconsent, config: { profilers } }`.

So the **entire profiler pipeline definition plus the site ID and licence key are emitted into the
page HTML / drupalSettings** for any visitor who receives the assets — by design, because the SDK
runs in the browser. No profile data is posted back to Drupal.

## Libraries

`convivial_profiler.libraries.yml`:

- `library` → external, minified: `//cdn.jsdelivr.net/gh/morpht/convivial-profiler@v0.1.40/dist/bundle.js`
  (protocol-relative; resolves to https on an https page).
- `init` → `js/convivial_profiler.init.js`, deps `core/jquery`, `core/once`, `core/drupal`,
  `core/drupalSettings`, `convivial_profiler/library`. It instantiates `window.ConvivialProfiler`,
  calls `.collect()`, and (when `event_tracking`) pushes click events on `.cp_trackable a.btn` into
  `window.dataLayer`.

## Menu / links

Local tasks `Settings` and `Profilers` (`*.links.task.yml`) under base route
`convivial_profiler.settings`; the config-menu link parents under `convivial_core.admin_convivial`
(`*.links.menu.yml`); an "Add profiler" action link appears on the list (`*.links.action.yml`).

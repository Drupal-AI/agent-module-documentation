<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `eulerian-analytics` Tarte au citron service plugin

File: `src/Plugin/tarte_au_citron/Eulerian.php`
Class: `Drupal\eulerian_tarte_au_citron\Plugin\tarte_au_citron\Eulerian extends ServicePluginBase`
(base class from the `tarte_au_citron` module).

## Plugin definition

Annotation `@TarteAuCitronService(id = "eulerian-analytics", title = @Translation("Eulerian Analytics"))`.
This makes Eulerian one of the services listed and gated by the Tarte au citron consent manager. The plugin is
discovered by Tarte au citron's plugin manager; this module defines **no plugin type of its own**.

## Settings

- `defaultSettings()` returns `['need_consent' => TRUE]` — Eulerian requires consent by default.
- The single setting is **not** stored in a config object owned by this module. Tarte au citron persists it under
  `tarte_au_citron.settings` at `services_settings.eulerian-analytics.need_consent` (this is the key the hooks
  read; see [../behavior/consent-gating.md](../behavior/consent-gating.md)).

## Settings form

`settingsForm()` calls `parent::settingsForm()` then appends one element rendered inside Tarte au citron's own
service-settings admin form (so it is reached through, and access-controlled by, the Tarte au citron settings
page — not a route this module declares):

- `need_consent` — `#type => checkbox`, title *"Need consent"*, default = current `need_consent`.
  Description warns that if consent is not required the tagging is always active and you must use Eulerian's
  **TCFv2** feature to stay GDPR-compliant, linking to Eulerian's TarteAuCitron GDPR wiki page.

## Library selection

`getLibraryName()` returns:

- `eulerian_tarte_au_citron/service.tarte_au_citron` when `need_consent` is TRUE (consent-gated tag), or
- `eulerian_tarte_au_citron/service.eulerian` when `need_consent` is FALSE (consent-exempt / CMP-bridge tag).

Both libraries are declared in `eulerian_tarte_au_citron.libraries.yml` with `header: true` and are described in
[../behavior/consent-gating.md](../behavior/consent-gating.md).

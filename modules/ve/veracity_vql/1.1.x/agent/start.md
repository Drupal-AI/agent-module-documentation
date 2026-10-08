<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Veracity Integration (veracity_vql) — agent index
**Runs VQL queries against a Veracity xAPI/LRS and renders learning-analytics charts in blocks.**

- **Version:** 1.1.x
- **Core:** ^8 || ^9 || ^10
- **Configure:** `/admin/config/services/veracity` (perm `access administration pages`, admin route).
- **Permission:** `access veracity charts` (chart viewing).
- **Services:** `veracity_vql.api` (`VeracityApi`/`VeracityClient`, `@http_client`); pre/post-process plugin managers.
- **Plugins:** VqlPreProcess (UserTimezone, DateRange, ContextActivity), VqlPostProcess (AxisRange, ExportMenu); blocks `VeracityChartBlock`, `VeracityEmbeddableChartBlock`.

**Security:** Outbound POSTs to the configured LRS over Guzzle with basic auth; TLS defaults on (no `verify => false`). Observations (reported, not fixed): config route gated only by `access administration pages` (weaker than `administer site configuration`) while editing endpoint + credentials; `access_key_secret` stored in plain config and pre-filled into a plain textfield (`VeracityConfigForm.php:82-91`).

See [configure/connect.md](configure/connect.md).

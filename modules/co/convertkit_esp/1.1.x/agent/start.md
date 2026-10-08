<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ConvertKit ESP (convertkit_esp) — agent index

**Integrates the ConvertKit/Kit v3 email marketing API for subscriber, form, tag and sequence management.**

- **Version:** 1.1.x
- **Core:** ^8.9 || ^9 || ^10
- **Config route:** `convertkit_esp.config` → `/admin/config/services/convertkit` (`_permission: 'administer convertkit configuration'`, restrict access).
- **Service:** `convertkit_esp` (`Convertkit`) wrapping `ConvertKitAPI` (Guzzle client, base `https://api.convertkit.com/`).
- **Auth:** API key (public) / API secret (privileged) sent as request params; credentials preferably in `$settings['convertkit_esp']`.
- **Surface:** form blocks (single/multi), field type/widget/formatter, derivative block, Webform handler.

**Security:** single admin config route gated by `administer convertkit configuration` (restrict access); no anonymous or mutating public endpoints. External API calls use a default Guzzle client with TLS verification enabled and secrets sent over HTTPS. Notes: debug logging writes to a file inside the module dir and references an undefined `Logger` class (will fatal if enabled); two `*.php---` controller files are dead/unloaded (no active OAuth callback route); info.yml `depencencies` typo means `block` is not enforced.

See [configure/setup.md](configure/setup.md) and [api/client.md](api/client.md).

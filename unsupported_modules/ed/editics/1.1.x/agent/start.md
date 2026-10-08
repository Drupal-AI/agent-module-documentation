<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# editics (editics) — agent index

**Turns mapped Drupal field data into Word/PDF documents via a PhpWord template engine and a remote CRI "flux" conversion server.**

- **Version:** 1.1.x
- **Core:** `^8 || ^9 || ^10`
- **Package:** CRI. **Depends on** `cri_php_word` (bundled submodule; `cri_core_mapping`, `cri_demo` also bundled).
- **Configure:** `/admin/api/configuration` (`editics.configuration.api`, `administer site configuration`) → `editics.api.settings` (prod/recette URL + credential id/pass).
- **Services:** `default.validator.service` (`FluxValidateService`), `default.rest.editics.service`, `default.rest.convert.service`, `logger.channel.editics`.

**Security:** Config route is admin-gated. Two hazards to flag: `FluxValidateService::remote()` sets `'verify' => false` on the credentialed POST (TLS cert verification disabled while sending Basic-auth creds), and `cri_php_word/src/elements/Evaluate.php` runs template content through `eval()`. Details reported to the campaign, not recorded here.

See [api/conversion.md](api/conversion.md).
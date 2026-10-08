<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# canto_connector (machine: connector_canto) — agent orientation

- Canto DAM → CKEditor asset-insertion. Project dir `canto_connector`, internal module name `connector_canto`.
- Admin config `/admin/config/search/connector_canto` (`administer site configuration`); per-user OAuth tokens in `canto_oauth_domain` table.
- TLS: `src/OAuthConnector.php` cURL leaves SSL verify at defaults (disable lines commented) → NOT disabled.
- DB via query builders (no raw SQL).

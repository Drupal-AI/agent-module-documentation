<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# No Referrer — agent index

Adds `rel="noreferrer"`, `rel="noopener"` and `referrerpolicy="no-referrer"` to external
links/resources. Applies to code-generated links via `hook_link_alter`, and to user content
via an opt-in text-format **filter**. A domain allowlist exempts trusted hosts, and can be
published/subscribed across sites.

- **Settings, config keys, enabling the text-format filter, publish/subscribe/allowlist** →
  [configure/settings.md](configure/settings.md)
- **The `Allowlist\Validator` / `Publisher` / `Subscriber` services** →
  [api/services.md](api/services.md)

Key facts:
- Config: `noreferrer.settings` — booleans `noreferrer`, `noopener`, `referrerpolicy`
  (all default TRUE), `publish` (default FALSE), `subscribe_url` (nullable uri),
  `allowed_domains` (sequence of strings, default `[]`).
- Settings route `noreferrer.settings` → `/admin/config/content/noreferrer`,
  permission `administer site configuration` (no module-specific permission).
- Filter plugin id **`noreferrer`** (`TYPE_TRANSFORM_IRREVERSIBLE`) — must be enabled per
  text format to affect user-generated content. It also fixes faulty/chopped HTML.
- `hook_link_alter` (attribute `#[Hook('link_alter')]`) adds the rel attributes to
  code-generated links; `hook_cron` refreshes a subscribed allowlist.
- Services (autowired, keyed by FQCN): `Drupal\noreferrer\Allowlist\Validator`,
  `...\Publisher`, `...\Subscriber`. No Drush, no module permissions.

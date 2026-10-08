<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GDPR (base module) — agent index

Umbrella/toolkit module: a Checklist-API self-assessment checklist, a per-language
**content links** config, and a per-user "All your data" page. Real features live in five
submodules. Requires `checklistapi`.

- **The checklist (configure route) and Content links config (`gdpr.content_mapping`)** →
  [configure/checklist-and-links.md](configure/checklist-and-links.md)
- **The "data stored about you" user page and its access** →
  [api/user-data.md](api/user-data.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Submodules (documented separately under `modules/`):
- `anonymizer` — Anonymizer plugin type + built-in anonymizers.
- `gdpr_fields` — mark entity fields as personal data (RTA/RTF, anonymizer).
- `gdpr_consent` — versioned consent agreements + consent field/resolvers.
- `gdpr_tasks` — Subject Access Request / Right-to-be-Forgotten task workflow.
- `gdpr_dump` — Drush command for anonymized SQL dumps.

Key facts:
- `configure` route = `checklistapi.checklists.gdpr_checklist` at `/admin/config/gdpr/checklist`.
- Content links are stored in config `gdpr.content_mapping` → `links.<langcode>.<key>` where
  key ∈ `privacy_policy`, `terms_of_use`, `about_us`, `impressum`.
- User data page route `gdpr.collected_user_data` at `/user/{user}/gdpr`.
- No config schema of its own; no Drush (the Drush command is in `gdpr_dump`).

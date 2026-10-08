<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Personalization (Perz) — agent index

Integrates Drupal with Acquia Personalization / Content Index Engine (CIS). Depends on
`acquia_connector` for credentials. The **main module** renders/opts-in content and injects
personalization JS + context; the bundled **acquia_perz_push** submodule does the actual
content export (queue, tracking, Drush). Install both for a working setup.

- **Settings form, config objects (`acquia_perz.settings`), API region, identity, mappings** →
  [configure/settings.md](configure/settings.md)
- **Opt a bundle/view-mode into personalization (`acquia_perz.entity_config`)** →
  [configure/view-modes.md](configure/view-modes.md)
- **Services, PerzHelper API, decision webhook, hooks, JS attachment** →
  [api/services.md](api/services.md)
- **Permission (`administer acquia perz`)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Content export queue + Drush (in the submodule)** →
  [../../modules/acquia_perz_push/4.1.x/agent/start.md](../../modules/acquia_perz_push/4.1.x/agent/start.md)

Key facts:
- Configure route: `acquia_perz.admin_settings` → `/admin/config/services/acquia-perz/settings`.
- Two config objects: `acquia_perz.settings` (global) and `acquia_perz.entity_config`
  (`view_modes.<entity_type>.<bundle>.<view_mode>` opt-in map).
- Only entities implementing `EntityPublishedInterface` can be personalized.
- Without `acquia_perz_push` enabled, `hook_requirements` flags the config as incomplete and no
  content is exported.

# acsf — agent start

ACSF Connector is the site-side integration for **Acquia Cloud Site Factory (ACSF)**, Acquia's
managed multi-site hosting platform. It only does real work on Acquia-hosted ACSF environments
(gated on `is_acquia_host()` and the `acsf_site_id` in `sites.json`); on an ordinary Drupal site
it installs but stays inert. Ships several submodules from one shared `src/`; the main `acsf`
module requires `acsf_theme` + `acsf_variables`. No permissions, no config UI (`configure` = null);
`acsf.settings` config is written by the platform, not an admin form.

- Connect to the Factory: `acsf-init` (standalone), sync, settings → [configure/acsf.md](configure/acsf.md)
- Drush commands (acsf-init, scrub, sync, registry, offline/online) → [drush/acsf.md](drush/acsf.md)
- Programmatic API — `AcsfMessage`, `AcsfSite`, `AcsfEvent` → [api/acsf.md](api/acsf.md)
- Hooks — registry + duplication/scrub alters → [hooks/acsf.md](hooks/acsf.md)

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_enforce — agent start

Info.yml name **Config Enforce**; description *"Allows some configuration to be read-only."*
Version **2.0.0-beta0** (beta), core `^10.2 || ^11`, PHP `^8.1`. Package: Configuration.
Depends on core `config` + `toolbar`.

Treats chosen config files in code as **canonical** and the DB copy as a cache. For each enforced
config object it can, per level: disable its config form in the UI (no submit), and/or re-import the
config from the module's `config/install` or `config/optional` YAML on disk when the active value has
drifted. Enforcement metadata lives in a per-module registry config object
(`config_enforce.registry.<module>`), normally authored by the companion **Config Enforce Devel** UI
(separate project, dev-only) but plain YAML you can hand-write.

Three enforcement levels (`\Drupal\config_enforce\ConfigEnforcer`):
- `0` OFF — allow form & API updates (no enforcement).
- `10` NOSUBMIT — allow only API updates; the config form's fields are disabled and its `#submit`
  handlers stripped, so the UI cannot write, but programmatic/API config saves still work.
- `20` READONLY — as `10`, **plus** the value is re-imported from disk on the configured trigger, so
  DB drift is reverted.

How enforcement fires:
- **Config forms** — `hook_form_alter` (module weight 1000, runs last) routes every config form
  through `EnforceFormHandler`; if a related config is enforced at level ≥ 10 the form is disabled and
  a "changes may be lost" warning is shown. If `config_enforce_devel` is enabled, **all** config forms
  stay editable (so devs can author).
- **Re-import** — `hook_rebuild` (cache rebuild / `drush cr`) calls `ConfigEnforcer::enforceConfigs()`
  when the `cache_rebuild` trigger is on (default); or run `drush config-enforce:enforce`. Only level-20
  configs whose base64 hash differs from active config are re-imported, via core's config-import
  machinery (`StorageReplaceDataWrapper` + `StorageComparer` + core `ConfigImporter`). Skipped in
  maintenance mode.

The only route is the settings form — **Admin → Config → Development → Config enforcement**
(`/admin/config/development/config_enforce`, route `config_enforce.settings`, permission
`administer site configuration`). It only picks which events trigger re-import (currently just
"Cache rebuild"), stored in `config_enforce.settings:triggers`. No custom permissions.

- Enforcement levels, triggers, form behaviour, config resolution → [mechanism.md](mechanism.md)
- Hand-author an enforced-config registry in a module's `config/install` → [registry.md](registry.md)
- Drush `config-enforce:enforce` / `cee` (`--only-optional`) → [drush.md](drush.md)
- Alter which config forms are skipped: `hook_config_enforce_form_denylist` → [hooks.md](hooks.md)

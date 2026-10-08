<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Ignore Readonly is a zero-configuration bridge module: when Config Readonly locks the site's config forms, it automatically re-enables (whitelists) exactly the config forms whose configuration is listed as ignored in Config Ignore.

---

The module has no UI, no settings, no permissions, no services and no plugins — it is a single hook implementation (`config_ignore_readonly_config_readonly_whitelist_patterns()`). Config Readonly normally makes every config form read-only (submit buttons disabled with a warning). Config Ignore lets you list configuration that should be skipped during import/export so it can drift per-environment. This module joins the two: it reads Config Ignore's ignore list (the "simple"-mode `import`/`update` patterns), and hands those exact patterns to Config Readonly as its whitelist, so a form editing ignored config stays submittable even while the rest of the site is locked. It respects other modules' `hook_config_ignore_ignored` alters because it rebuilds the list through `ConfigIgnoreConfig::fromConfig()` then invokes that alter. Only Config Ignore's *simple* pattern form is supported: force-import (`~name`) patterns and sub-key (`config.name:key`) patterns are **not** honoured, and a form whose `getEditableConfigNames()` returns several config names needs *all* of them ignored before it becomes editable.

---

- Keep the *Basic site settings* form editable on a production site that is otherwise locked by Config Readonly, by ignoring `system.site`.
- Let editors change an API key or third-party credential stored in an ignored config while config is read-only.
- Allow per-environment config (e.g. `system.performance`, mail settings) to be tweaked in the UI without disabling Config Readonly globally.
- Bridge Config Ignore and Config Readonly with no configuration of its own after enabling the three modules.
- Whitelist a webform's config form for editing under readonly by adding its config name to Config Ignore.
- Reuse an existing Config Ignore ignore list to decide which forms stay editable, rather than maintaining a second list.
- Permit staging/hotfix edits to specific settings forms while protecting the rest of the site's config.
- Avoid accidental config drift by locking everything except the handful of settings you deliberately ignore.
- Combine with `hook_config_ignore_ignored` from another module to programmatically expand the editable-under-readonly set.
- Let a `key.key.*` credential entity form remain editable under readonly when that key is ignored.
- Support a workflow where config is exported from a "source of truth" environment but a few forms are intentionally left hand-editable in production.
- Diagnose why a form is still read-only by checking the ignored-config patterns the module forwards.
- Enable safe emergency edits to ignored settings during an incident without lifting the read-only guard.
- Keep contact-form recipient settings editable per site while config import stays authoritative for everything else.
- Provide site builders a "locked except these" configuration posture using only contrib modules.
- Standardise which settings drift between dev/stage/prod by centralising them in Config Ignore and letting this module make their forms editable.
- Allow a maintenance role to update ignored settings in the admin UI while deployments keep config read-only.
- Ensure that ignoring a config for import purposes also unlocks its admin form, without extra steps.
- Confirm at runtime which config names are whitelisted by inspecting Config Ignore's `ignored_config_entities`.
- Migrate an existing Config Ignore setup to also govern editability under Config Readonly by simply enabling this module.

# Depcalc UI — agent index

Trivial submodule of **depcalc**. Adds a **"Clear depcalc cache"** button to the core
Performance settings form (`/admin/config/development/performance`). Only a `.module` file; no
routes, permissions, config, services, or plugins.

Mechanism: `depcalc_ui_form_system_performance_settings_alter()` adds the submit button; its
handler `depcalc_ui_submit_depcalc_cache_clear()` calls
`\Drupal::service('cache.depcalc')->deleteAllPermanent()`. This is the UI equivalent of
`drush depcalc:clear-cache` (see the parent module docs: `../../../1.23.x/agent/drush/commands.md`).
Needed because the depcalc bin intentionally survives a normal cache rebuild.

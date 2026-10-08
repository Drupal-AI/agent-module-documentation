# purge — agent start

Generic external cache-invalidation framework: queuers capture invalidations → queue →
processors drain it → purgers flush the external cache (Varnish/CDN). Ships no purger itself;
install a purger module for your proxy/CDN. Config lives in `purge.plugins`; admin UI is the
`purge_ui` submodule. No permissions of its own (UI uses `administer site configuration`).

- Enable/configure plugins (config, capacity, diagnostics) → [configure/pipeline.md](configure/pipeline.md)
- The 7 plugin types & how to implement one → [plugins/plugin-types.md](plugins/plugin-types.md)
- Services & programmatic invalidation → [api/services.md](api/services.md)
- Drush `p:*` commands → [drush/commands.md](drush/commands.md)

Submodule docs: `purge_ui`, `purge_processor_cron`, `purge_processor_lateruntime`,
`purge_queuer_coretags`, `purge_tokens` (each under `modules/<sub>/3.6.x/`).

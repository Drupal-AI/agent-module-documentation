Convivial Profiler Sync adds admin-only JSON export and import of the profiler pipeline definitions stored by Convivial Profiler.

---

This submodule of `convivial_profiler` exposes two routes under `/admin/config/convivial/profiler`, each gated by its own `administer convivial profiler sync` permission. The Export form serialises the `profilers` array from `convivial_profiler.settings` to JSON in a read-only textarea for copy/paste; the Import form takes a pasted JSON blob and writes it back into config, replacing the stored profilers. It is meant for moving a set of profiler definitions between environments or into an externally hosted Convivial Profiler system. The submodule ships no config schema, no plugins and no services beyond a hook_help implementation. Note that the JSON handled here is the configuration of the profiling pipeline (which sources/processors/destinations run), not collected visitor data — the visitor profile itself never lives in Drupal.

---

- Copy a site's profiler definitions to clipboard as JSON for backup or review.
- Move profiler configuration from a staging site to production without a full config sync.
- Seed a new site's profilers by pasting a JSON definition exported elsewhere.
- Share a standard profiler pipeline across several sites in a platform.
- Hand a profiler configuration to an externally hosted Convivial Profiler instance.
- Bulk-replace all profilers at once instead of rebuilding them in the UI.
- Keep a versioned JSON snapshot of the profiler pipeline outside Drupal's config system.
- Restrict who may export/import profilers separately from who may edit them (dedicated permission).
- Review the full pipeline definition in one JSON view rather than clicking through the builder.
- Template a personalisation setup and distribute it to client sites.

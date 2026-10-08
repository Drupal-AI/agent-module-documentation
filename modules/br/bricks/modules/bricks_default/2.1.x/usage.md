Bricks Default is an empty backward-compatibility shim submodule of Bricks; it ships no code, config, or dependencies and exists only so sites that previously enabled `bricks_default` keep a satisfiable module name.

---

The submodule's `bricks_default.info.yml` describes it as a "Dummy module for backward-compatibility." It has no `src/`, no config, no dependencies (not even on `bricks`), and no functionality. Historically the default Bricks setup lived here; that has been split into `bricks_default_blocks` and `bricks_default_paragraphs`. Enabling it does nothing except keep older configuration/feature exports that referenced the module installable. There is nothing to configure and nothing an agent needs to call.

---

- Keep an existing site that had `bricks_default` enabled installable after upgrading Bricks.
- Satisfy a legacy dependency or config export that names `bricks_default`.
- No-op placeholder; enable only if something references it.
- Migrate away from it toward `bricks_default_blocks` / `bricks_default_paragraphs` for real demo setups.
- Avoid a "module not found" error when importing old configuration that lists `bricks_default`.
- Provide a stable module name across a Bricks 1.x -> 2.x upgrade.
- Keep a Features export that enumerated `bricks_default` deployable.
- Serve as documentation that the old bundled default setup was split out.
- Enable temporarily during an upgrade, then uninstall once references are removed.
- Confirm (by its emptiness) that no runtime behaviour depends on this name anymore.
- Act as a compatibility marker in a multi-site where some sites still reference it.
- Let automated site audits resolve the dependency without special-casing.
- Keep `drush pm:list` output consistent with pre-upgrade expectations.
- Do nothing on enable — safe to leave installed if already present.
- Remove it safely once you have moved to the split demo modules.
- Reference it only from other legacy Bricks configuration, never from new work.

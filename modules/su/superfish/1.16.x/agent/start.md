# superfish — agent start

Renders any menu as a multi-level jQuery-Superfish dropdown/flyout via a **Superfish block**
(block plugin `id: superfish`, derived per menu via core's `SystemMenuBlock` deriver). No global
config UI (`configure` null) — you configure each block when placing it at **Admin → Structure →
Block layout**. External assets come from the Composer library `lobsterr/drupal-superfish`.

- Place & configure a Superfish block (all settings keys) → [configure/block.md](configure/block.md)
- Templates / theme overrides → [theming/templates.md](theming/templates.md)
- Menu-tree manipulators applied at build, and the alter hook → [hooks/hooks.md](hooks/hooks.md)

No permissions, routes, drush, or plugin types of its own.

In 1.16.x hook implementations live in OOP `#[Hook]` classes under `src/Hook/`
(`CoreHooks`, `LibraryHooks`, `ThemeHooks`, all autowired services); `superfish.module`
and `superfish.install` keep thin `#[LegacyHook]` / `#[LegacyRequirementsHook]` shims. See
[Diff 1.15.x → 1.16.x](#diff-115x--116x) below.

## Diff 1.15.x → 1.16.x

Behaviour and the block form are unchanged; the changes are structural / dependency:

- **Hooks moved to OOP classes.** Procedural hooks that lived in `superfish.module` are now
  `#[Hook]`-attributed methods on `src/Hook/CoreHooks` (`help`), `src/Hook/LibraryHooks`
  (`libraries_info`, `library_info_build`, `runtime_requirements`), and `src/Hook/ThemeHooks`
  (`block_view_superfish_alter`, `theme`). Each is an autowired service in
  `superfish.services.yml`. `superfish.module` retains `#[LegacyHook]` wrappers that delegate to
  those services.
- **Library requirements check is now `hook_runtime_requirements()`** (`LibraryHooks::runtimeRequirements()`),
  using `RequirementSeverity` enum values via `DeprecationHelper::backwardsCompatibleCall()` for
  pre-11.2 back-compat. `superfish.install` keeps a `#[LegacyRequirementsHook]`
  `superfish_requirements()` shim delegating to it.
- **Bundled library bumped:** `lobsterr/drupal-superfish` `2.3.10` → `2.3.11` (composer.json).
- **New functional test:** `tests/src/Functional/ChildrenOfDisabledParentTest.php`
  (covers the `filterDisabledLinks` manipulator dropping descendants of disabled parents).
- The menu-tree manipulator chain, config schema, and Twig templates are unchanged.

Module Locator adds a "Location" line to each module on the /admin/modules page, showing where that module lives in the filesystem.

---

Module Locator is a tiny developer/administrator convenience module. Once enabled it alters Drupal's core "Extend" (module list) form and its theme output so every module's details block shows its filesystem path (for example `modules/contrib/pathauto` or `web/sites/all/modules/foo`). It has no configuration page, adds no routes, permissions, services, or config, and stores nothing — it purely re-renders information Drupal already knows via the `extension.list.module` service. It is most useful when a site has modules scattered across several possible directories (contrib, custom, sites/all, multisite subdirs, profile-provided, symlinked) and you need to know which copy is actually being loaded.

---

- See the exact filesystem path of every installed and uninstalled module directly on /admin/modules.
- Confirm which copy of a duplicated module Drupal actually loads when the same module exists in more than one directory.
- Diagnose "wrong version loading" issues by verifying the path matches the intended contrib/custom location.
- Audit legacy sites where modules were placed in non-standard directories over time.
- Verify module placement on multisite installations (site-specific `sites/<name>/modules` vs. shared `sites/all/modules`).
- Check that a module installed via Composer landed in the expected `modules/contrib` tree.
- Distinguish core, contrib, and custom modules at a glance by their path prefix.
- Spot modules provided by an installation profile or distribution versus those added afterwards.
- Detect symlinked module directories during local development.
- Onboard developers to an unfamiliar codebase by making the module layout visible without SSH access.
- Support code reviews and audits where knowing a module's on-disk location matters.
- Help migration/upgrade planning by inventorying where each module currently resides.
- Troubleshoot Drupal's extension discovery when a module is unexpectedly not found or is found twice.
- Confirm a module was removed from the intended directory after uninstalling it.
- Give site builders a quick, UI-only way to answer "where is this module?" without a terminal.
- Validate directory conventions across a team (e.g. everything under `modules/custom`).
- Cross-check module paths against a deployment manifest or `composer.lock`.
- Teach or demonstrate Drupal's module directory structure in a training context.
- Inspect module locations on shared/managed hosting where filesystem access is limited.
- Quickly identify vendored or patched module copies living outside the standard tree.

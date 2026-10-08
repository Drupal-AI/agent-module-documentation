Web Patches is a read-only admin report that shows which Composer patches — and which ignored patches — are declared for the site.

---

Web Patches (`webpatches`) adds an admin report at Reports → Web Patches that reads the same patch declarations Composer reads (root `composer.json`, a Composer Patches patches file, an optional custom file, and installed dependency packages) and applies the same allowlist and ignore rules used by cweagans/composer-patches and the webship/patches Composer plugin. It lists the patching sources, the state of `patches.lock.json` versus the declarations, every applied patch (linked to its drupal.org project, issue, patch file and merge request where derivable), and every declared-but-not-applied patch with the reason it was filtered out. The module never applies, downloads or fetches patches — it only reports what is already declared on disk. A settings form at Configuration → Development → Web Patches chooses which sources are read, points at a custom patches file, and toggles whether only patches for installed packages are shown. Both the report and the settings are gated behind restricted admin permissions.

---

- See at a glance every Composer patch declared for the site without opening a terminal or reading lock files.
- Audit which contrib modules ship their own `extra.patches` and whether those patches are allowed or filtered out.
- Confirm that a module's unwanted bundled patch (pointing at a stale or third-party URL) is flagged Not allowed and never applied.
- Verify `patches.lock.json` is in sync with the declarations before or after a deploy.
- Diagnose an out-of-sync lock: see exactly which patches are declared-but-not-locked and locked-but-no-longer-declared, with the `composer install` command that fixes it.
- Understand why a patch you expected is missing — allowlist, ignore rule, or `extra.patches-ignore`.
- Jump from a patched package straight to its drupal.org project (or Packagist) page.
- Open the drupal.org issue behind a patch from its `#1234567` reference in the description.
- Open the merge request on git.drupalcode.org for a patch whose file name carries `--mr-<id>`.
- Review the curated Webship patch sets (webship/patches, webship/drupal-patches) contributed as dependency patches.
- Restrict the report to only the patches that target packages actually installed on this site.
- Point the report at a custom patches file (bare `{"patches": {…}}` or a `composer.json`-shaped file) for a non-standard build layout.
- Check that a site deployed without its `composer.lock` still reports patches (falls back to `vendor/composer/installed.json`).
- Give administrators visibility into applied patches for security and compliance review.
- Document the site's patch surface for a handover or an upgrade audit.
- Confirm that the module's own leftover `extra.patches` metadata is never counted as a patching source.
- Choose which declaration files feed the report (root composer.json, patches file, custom file, dependency packages) per environment.
- Detect a project where the Composer project root cannot be located (report warns instead of guessing).
- Support both Composer Patches v1 and v2 declaration keys on the same report.

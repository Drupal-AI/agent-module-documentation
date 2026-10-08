<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preprocessor Files (ppf) — agent index

**Discovers per-template `*.preprocess.php` files in themes/modules and runs them like `hook_preprocess_HOOK()`.**

- **Version:** 1.2.x
- **Core:** ^8.8 || ^9 || ^10 || ^11 (PHP >=8.0; needs symfony/filesystem, uses symfony/finder)
- **Config route:** `ppf.settings` → `/admin/config/ppf` (`PPFConfigurationForm`, perm `administer site configuration`)
- **Service:** `ppf` (`PreprocessorFiles`)
- **Mechanism:** `hook_theme_registry_alter()` maps discovered files to theme hooks; default dir `preprocessors/`, default ext `.preprocess.php`
- **Config:** `ppf.settings` (`preprocessor_files_extension`)

**Security:** the discovered `*.preprocess.php` files are executable PHP loaded from theme/module directories — same trust level as `.theme`/template files; writing them requires filesystem access, not a web request, and there is no request-driven execution path. Admin form is permission-gated. No request input is read. No web-exposed security findings.

See [configure/files.md](configure/files.md)

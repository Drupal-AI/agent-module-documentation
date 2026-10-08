<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preprocessor Files lets front-end developers preprocess template variables in dedicated per-template PHP files (e.g. `node.preprocess.php`, `node--article.preprocess.php`) placed in a theme instead of piling `hook_preprocess_HOOK()` functions into `THEME.theme`.

The module implements `hook_theme_registry_alter()` and uses a Symfony `Finder` to discover files matching the configured extension (default `.preprocess.php`) under a configured directory (default `preprocessors/`) in the active theme, its base themes, and enabled modules. Each discovered file is mapped to its theme hook by filename (dashes normalised to underscores; base hooks sorted before sub-hooks) and is `include`d during rendering with `$variables`, `$hook` and `$info` in scope — so anything you do there is equivalent to a preprocess hook, running after traditional hooks. File discovery mirrors template discovery, so subfolders and theme-suggestion filenames work. Configure the directory name and extension, or generate a starter folder in the default theme, at `/admin/config/ppf` (`PPFConfigurationForm`, permission `administer site configuration`).

Operational/security notes: these files are executable PHP loaded from theme/module directories, so they carry the same trust level as `.theme` files or templates — anyone who can write them can run arbitrary PHP; there is no web-facing execution path and the admin form is permission-gated. Nothing here reads request input.
---
Define per-template *.preprocess.php files in a theme that run like hook_preprocess_HOOK().
---
- Create `THEME/preprocessors/node.preprocess.php` to preprocess node templates.
- Alter `$variables` in a dedicated file instead of `THEME.theme`.
- Target a suggestion with `node--article.preprocess.php`.
- Organise preprocessors into subfolders like template files.
- Generate a starter `preprocessors/` folder from `/admin/config/ppf`.
- Change the preprocessor directory name in configuration.
- Change the file extension (default `.preprocess.php`) in configuration.
- Grant `administer site configuration` to manage PPF settings.
- Access `$variables`, `$hook` and `$info` inside a preprocessor file.
- Run preprocessor logic after traditional preprocess hooks.
- Keep base-hook files running before sub-hook files (auto sorted).
- Inherit base-theme preprocessor files in a sub-theme.
- Provide preprocessor files from a module directory as well as a theme.
- Combine with Twig debugging to map templates to preprocessor files.
- Segment complex theme logic into one file per template.
- Use the bundled `.HOOK.preprocess.php` blueprint as a starting point.
- Avoid a monolithic `THEME.theme` on large projects.
- Keep preprocessing under version control per-template.

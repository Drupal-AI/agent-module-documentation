<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preprocessor Files — configure & use

## Create a preprocessor file
Default location `THEME/preprocessors/`, default extension `.preprocess.php`:
```php
// themes/custom/mytheme/preprocessors/node.preprocess.php
<?php
$variables['foo'] = 'bar';   // == body of hook_preprocess_node()
```
In `node.html.twig` you now have `{{ foo }}`. In scope: `$variables`, `$hook`, `$info`.
Runs after traditional preprocess hooks.

## Naming & discovery
- Filename before the first `.` is the theme hook; dashes → underscores.
  `node--article.preprocess.php` targets the `node__article` suggestion.
- Subfolders are allowed (discovery mirrors template discovery).
- Base-hook files sort before sub-hook files.
- Files are collected from the active theme, its base themes, and enabled modules
  (`getPreprocessorFilesForTheme` / `getPreprocessorFilesForActiveModules`).

## Settings — `/admin/config/ppf`
`PPFConfigurationForm` (perm `administer site configuration`), config `ppf.settings`:
- `preprocessor_files_extension` — change the extension (default `.preprocess.php`).
- Directory name constant is `preprocessors`.
- The form can generate a starter folder in the default theme.

Drush:
```bash
drush cset ppf.settings preprocessor_files_extension '.preprocess.php' -y
```

Note: these files execute arbitrary PHP; treat them with the same trust as `.theme`
files and keep them under version control.

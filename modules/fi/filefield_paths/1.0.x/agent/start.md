# filefield_paths — agent start

Adds token-based **File path** and **File name** patterns to core File/Image (file-based)
fields, so uploads are auto-sorted and renamed. Options: remove slashes, Pathauto cleanup,
transliterate. Uploads land in a temporary location, then move on entity save; can create a
redirect for moved files, retroactively reprocess existing files, or actively re-move on every
save. Depends on core `file`. Recommends Token, Pathauto, Redirect. Release candidate
(`8.x-1.0-rc1`), Drupal 10.3+/11.

- Per-field path/filename settings + cleanup + retroactive/active/redirect + global temp location → [configure/filefield_paths.md](configure/filefield_paths.md)
- Retroactive updates from the CLI (`drush ffpu`) → [drush/filefield_paths.md](drush/filefield_paths.md)
- Hooks to add settings fields / process uploaded files → [hooks/filefield_paths.md](hooks/filefield_paths.md)
- Services: process strings, create redirects, batch-update in code → [api/filefield_paths.md](api/filefield_paths.md)

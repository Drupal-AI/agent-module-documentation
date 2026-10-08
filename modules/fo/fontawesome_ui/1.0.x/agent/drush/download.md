<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: download the Font Awesome library

```
drush fa:download [path]     # aliases: fadl, fa-download
```

Behaviour (`src/Commands/FontAwesomeCommands.php::download`):
1. Resolves `path` — the supplied arg, else `fontawesome_ui_find_library()`, else
   `DRUPAL_ROOT/libraries/fontawesome`.
2. Creates the dir only if it ends in `fontawesome` (`substr($path,-11)=='fontawesome'` guard).
3. Skips if `path/css` already exists.
4. Reads the module's `fontawesome.svg` library definition and downloads its **`remote`** URL
   (`system_retrieve_file`) to a temp file, moves it to `path/fontawesome.zip`.
5. Extracts with the core Archiver: `$zipFile = archiverManager->getInstance(['filepath'=>...]); $zipFile->extract($path);`
6. Deletes the zip, relocates the extracted `fontawesome-free-<version>-web` folder into `path`.

## Security notes
- **Source is not attacker-controlled:** the download URL is the fixed `remote` in the module's
  `*.libraries.yml` (a FontAwesome release), not request/config input.
- **Path is effectively fixed** to `libraries/fontawesome` (the `substr` guard).
- The `extract()` call has **no explicit zip-slip guard**, but the input archive is a trusted fixed URL and
  the command is **CLI-only** (not reachable over the web), so it is not a web-exploitable traversal.
- To harden further, verify the download against a known checksum before extracting.

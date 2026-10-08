<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `pfdp_file_download()` — the access algorithm

`pfdp.module` implements `hook_file_download($uri)`. Drupal's contract: return an array of
headers to allow, `-1` to deny, `NULL` to stay neutral. The order of checks is exactly:

1. **Invalid URI** — `'://'` at the end of the string, or `is_dir($uri)` → log a warning, return `-1`.
2. **`public://` prefix** → return `NULL` (neutral, not this module's business).
3. Build the download headers (`pfdp_get_download_headers($uri)`): MIME type from
   `file.mime_type.guesser` + `Content-Disposition: attachment; filename=<basename>` when
   `attachment_mode` is on, otherwise `inline`.
4. **`bypass pfdp` permission** → allow.
5. **`bypass pfdp for temporary files`** *and* the URI starts with `temporary://` → allow.
6. Otherwise derive `$uri_path` from the URI: drop the scheme and the file name
   (`array_slice(explode('/', $uri), 2, -1)`), prefix with `/`. Then loop over
   `DirectoryEntity::loadMultiple()` and keep the **longest** `path` for which
   `stripos($uri_path, $directory_path) === 0` — i.e. **longest-prefix, case-insensitive** match.
   *(This is a plain prefix test, so `/docs` also matches `/docsecret`.)*
7. If a directory matched:
   - `bypass` is true → return `NULL` (module steps aside, other implementations decide);
   - `grant_file_owners` is true and a `file` entity with that `uri` is owned by the current user → allow;
   - `by_user_checks` setting is on and `current_user()->id()` is in `users` → allow;
   - any role of the current user is in `roles` → allow.
8. **Fall through → `-1` (deny)**, with a warning logged when `debug_mode` is on.

"Allow" means: `override_mode` off → return the header array; `override_mode` on →
`pfdp_force_download()` sends a `BinaryFileResponse` and calls `exit()`, so no other
`hook_file_download()` implementation runs and no further Drupal kernel processing happens.

**Important consequence:** a private file whose path matches **no** registered directory is
denied (step 8), not left neutral. Register `/` with the roles that should keep access if you
only mean to restrict one subdirectory.

## Helper functions in `pfdp.module`

| Function | Purpose |
|---|---|
| `pfdp_get_user_log_details($user)` | `uid (name, display name)` string for log messages. |
| `pfdp_get_proper_user_array($users)` | Strips `'0'` (unchecked checkbox) entries from a `users` list. |
| `pfdp_get_download_headers($uri)` | MIME type + `Content-Disposition` per `attachment_mode`. |
| `pfdp_force_download($uri, $headers)` | `BinaryFileResponse(...)->send(); exit();` — used by `override_mode`. |

There is **no service, no plugin type and no Drush command**; everything is procedural code in
`pfdp.module` plus the config entity.

## Reproducing a decision without an HTTP request

```bash
drush php:eval '
  $uri = "private://downloads/report.pdf";
  $path = "/" . implode("/", array_slice(explode("/", $uri), 2, -1));
  $best = NULL; $len = 0;
  foreach (\Drupal\pfdp\Entity\DirectoryEntity::loadMultiple() as $d) {
    if (stripos($path, $d->path) === 0 && strlen($d->path) > $len) { $len = strlen($d->path); $best = $d; }
  }
  print $path . " -> " . ($best ? $best->id() . " roles=" . implode(",", $best->roles) : "no directory (denied)") . "\n";'
```

Turn on `debug_mode` and read the decisions the module actually made:

```bash
drush watchdog:show --type=pfdp --count=20
```

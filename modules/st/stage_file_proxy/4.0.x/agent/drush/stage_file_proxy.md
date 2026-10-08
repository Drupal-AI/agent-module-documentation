# Drush — warm the local files directory

Class `Drupal\stage_file_proxy\Drush\Commands\StageFileProxyCommands`.

## `stage_file_proxy:dl`

Aliases: `stage-file-proxy-dl`, `sfdl`.

Downloads **all** managed files (from the `file_managed` table, `public://` URIs only) from
the configured origin into the local public files directory, skipping any that already exist
locally. Use it to pre-warm a dev site instead of waiting for on-demand fetches.

```bash
# Download every missing managed file from the origin.
drush stage_file_proxy:dl
drush sfdl

# Download only one file by its file id.
drush sfdl --fid=123

# Skip the progress bar (useful in CI / scripts).
drush sfdl --skip-progress-bar
```

| Option | Default | Effect |
|---|---|---|
| `--fid` | `0` | Only download the file with this file id (0 = all). |
| `--skip-progress-bar` | `FALSE` | Do not render the progress bar. |

Behavior / notes:

- Throws if `stage_file_proxy.settings.origin` is not configured.
- Uses `origin_dir` for the remote path (falls back to the local files path if unset) and the
  `verify` setting for SSL.
- Fetches via the `stage_file_proxy.download_manager` service (`DownloadManagerInterface::fetch()`).
- Files with non-`public://` URIs are skipped and counted as "not in public directory"; per-file
  HTTP errors are logged and counted, and totals (downloaded / errored / skipped) are reported.

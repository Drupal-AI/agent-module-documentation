# Imce programmatic API

Static façade `Drupal\imce\Imce` — the entry point for custom code. Key methods:

| Method | Purpose |
|---|---|
| `Imce::access($user = NULL, $scheme = NULL)` | Does the user have any Imce profile for the scheme? |
| `Imce::response(Request $r, $user, $scheme)` | Build the AJAX response for a file-manager request. |
| `Imce::userFM($user, $scheme, $request)` | Construct an `ImceFM` file-manager object for a user. |
| `Imce::userProfile($user, $scheme)` | Resolve the `ImceProfile` assigned to the user's roles. |
| `Imce::userConf($user, $scheme)` | Effective (token-processed) profile config array. |
| `Imce::scanDir($diruri, $options = [])` | List files/subfolders of a directory URI. |
| `Imce::getFileEntity($uri, $create = FALSE, $save = FALSE)` | Load (or create) the `file` entity for a URI. |
| `Imce::createFileEntity($uri, $save = FALSE)` | Create a managed file entity for an on-disk file. |
| `Imce::accessFileUri($uri, $user = NULL)` | May the user access this file URI? (used by `hook_file_download`). |
| `Imce::accessFilePaths(array $paths, $user, $scheme)` | Filter a list of paths to the accessible ones. |
| `Imce::validateFileName($filename, $filter = '')` | Reject invalid/blocked filename characters. |
| `Imce::runValidators(FileInterface $file, $validators = [])` | Run file validators. |
| `Imce::formatSize($size)` | Human-readable byte size. |
| `Imce::service($name)` / `Imce::entityStorage($name)` | Container helpers. |

The `ImceFM` object (returned by `userFM`) exposes the active folder, current selection,
request parameters and the response builder used by operation handlers. There is no
`imce.api.php`; the extension surface for plugins is the `ImcePluginInterface`
(see [../plugins/imce-plugin.md](../plugins/imce-plugin.md)).

# The four stream wrappers

Registered as tagged services (`stream_wrapper`) in `system_stream_wrapper.services.yml`. Once the
module is enabled, the schemes work with any stream-aware PHP/Drupal API.

| Scheme | Class | `owner` resolves to | Directory |
|---|---|---|---|
| `module://` | `StreamWrapper\ModuleStream` | an **installed** module machine name | that module's path (`ModuleHandler::getModule()->getPath()`) |
| `theme://` | `StreamWrapper\ThemeStream` | a theme machine name | that theme's path |
| `profile://` | `StreamWrapper\ProfileStream` | the install profile | the profile's path |
| `library://` | `StreamWrapper\LibraryStream` | a folder under `libraries/` | discovered via bundled `Extension\LibraryDiscovery` |

URI shape: `scheme://<owner>/<target/path/file.ext>`. `getOwnerName()` (in `ExtensionStreamBase`)
takes everything up to the first `/`; `getTarget()` is the remainder.

## Reading files

All four are ordinary read streams, so any of these work:

```php
$data = file_get_contents('module://mymodule/data/countries.json');
$fh   = fopen('theme://mytheme/logo.svg', 'rb');
$xml  = simplexml_load_file('profile://standard/config/example.xml');
$js   = file_get_contents('library://swiper/swiper.min.js');
```

## Turning a URI into a public URL

```php
/** @var \Drupal\Core\StreamWrapper\StreamWrapperManagerInterface $m */
$m = \Drupal::service('stream_wrapper_manager');
$url = $m->getViaUri('module://mymodule/images/logo.png')->getExternalUrl();
// => e.g. "/modules/contrib/mymodule/images/logo.png" made absolute for the current request
```

`getExternalUrl()` = `base_path()` + the extension/library directory + `getTarget()`, run through
`Request::getUriForPath()`. It throws `\InvalidArgumentException` if the directory can't be resolved.

## Read-only contract (LocalReadOnlyStream)

`getType()` returns `StreamWrapperInterface::LOCAL | READ`. Enforced:
- `stream_open()` returns FALSE unless mode is `r` / `rb` / `rt` (write modes warn).
- `stream_write`, `stream_truncate`, `stream_metadata`, `unlink`, `rename`, `mkdir`, `rmdir` all
  return FALSE (or, for `unlink`, TRUE without deleting) and emit `E_USER_WARNING`.
- `stream_lock()` refuses exclusive (`LOCK_EX`) locks; shared/unlock pass through to `flock()`.

## Errors to expect

- `module://foo/...` where `foo` is not installed → `\InvalidArgumentException("Module foo does not exist or is not installed")`.
- `library://bar/...` where `libraries/bar` doesn't exist → `\InvalidArgumentException("Library bar does not exist")`.
- Empty/unresolvable extension directory in `getExternalUrl()` → `\InvalidArgumentException`.

## Library discovery detail

`Extension\LibraryDiscovery` extends core `ExtensionDiscovery` and scans each site root's
`libraries/` directory (`scanDirectory()`), following symlinks, caching results in its own static
(so it does not disturb core's extension cache). `LibraryStream::getDirectoryPath()` looks the owner
up in that scan result.

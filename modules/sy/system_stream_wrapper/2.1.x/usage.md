System Stream Wrapper registers four read-only PHP stream wrappers — `module://`, `theme://`, `profile://`, and `library://` — so code can address files that ship inside extensions or the `libraries/` directory by a stable logical URI instead of a hardcoded filesystem path.

---

The module is pure infrastructure: it defines no UI, permissions, config, or hooks. Its `*.services.yml` tags four classes (`ModuleStream`, `ThemeStream`, `ProfileStream`, `LibraryStream`) as `stream_wrapper` services with the schemes `module`, `theme`, `profile`, and `library`. Each resolves the scheme's owner name (e.g. `module://token/img/x.png` → the enabled `token` module's path) via the module/theme/profile handler, and the `library` scheme scans `libraries/` directories with a bundled `LibraryDiscovery` (an `ExtensionDiscovery` subclass). All four extend `ExtensionStreamBase` → `LocalReadOnlyStream` → core `LocalStream`, so they are `LOCAL | READ` only: `stream_open()` rejects any non-read mode and every mutating operation (`stream_write`, `unlink`, `rename`, `mkdir`, `rmdir`, `stream_metadata`, `stream_truncate`, exclusive `flock`) returns FALSE with an `E_USER_WARNING`. `getExternalUrl()` builds a browser-facing URL from `base_path()` plus the extension/library directory and target, so referenced assets can be linked publicly. Owner resolution throws `\InvalidArgumentException` when the module/theme/profile is missing or not installed, or the library folder does not exist. It is a common low-level dependency of modules that need to reference their own or a library's shipped files portably (originally split out of Drupal core / libraries handling).

---

- Reference a file shipped inside a module by logical URI, e.g. `file_get_contents('module://mymodule/data/seed.json')`.
- Build a public URL to a module-shipped asset with `\Drupal::service('stream_wrapper_manager')->getViaUri('module://mymodule/images/logo.png')->getExternalUrl()`.
- Point a config value or field at a theme file using `theme://mytheme/screenshot.png` without knowing the theme's on-disk location.
- Address the installed install-profile's files via `profile://standard/...`.
- Reference a front-end library placed under `libraries/` with `library://swiper/swiper.min.js`, resolved by the bundled library discovery.
- Load a module's bundled CSV/JSON/XML fixture in an import routine without composing `\Drupal::service('extension.list.module')->getPath()` by hand.
- Pass a `module://`/`theme://` URI to any API that accepts a stream URI (image toolkit, file API reads, `fopen` in read mode).
- Keep asset references stable across environments where the Drupal root or contrib path differs.
- Resolve an extension's directory at runtime by letting the wrapper call the module/theme handler for you.
- Get a hard failure (`\InvalidArgumentException`) early when referencing a disabled or nonexistent module, theme, profile, or library.
- Serve a library file's external URL for `<script>`/`<img>` links via `getExternalUrl()`.
- Read a profile-provided default file during site setup.
- Depend on it as a base so your own module can reference its shipped templates/data portably.
- Guarantee callers cannot write through these schemes — every write/delete/rename op is a no-op that warns.
- Migrate legacy hardcoded `sites/all/libraries` paths to a portable `library://` scheme.
- Use `dirname()` on an extension URI to walk to a parent logical directory within the same scheme.
- Enumerate discoverable libraries via the internal `LibraryDiscovery::scan('library')` result (the mechanism behind `library://`).
- Provide a stable URI for documentation or help links that point at files bundled with an extension.
- Reference a shared image/icon that lives in one module from another module's render array.
- Avoid coupling code to Composer's contrib install location by addressing modules by machine name.

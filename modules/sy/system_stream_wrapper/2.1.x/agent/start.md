# System Stream Wrapper — agent index

Registers four **read-only** stream wrappers so you can address files inside extensions and
the `libraries/` folder by logical URI: `module://`, `theme://`, `profile://`, `library://`.
No UI, no config (`configure` null), no permissions, no hooks, no Drush. Pure infrastructure
consumed programmatically. Requires Drupal core 10/11 only.

- **The four schemes, how URIs resolve, external URLs, read-only guarantees, errors** →
  [api/wrappers.md](api/wrappers.md)
- **Adding your own scheme by subclassing `ExtensionStreamBase` / `LocalReadOnlyStream`** →
  [extend/custom-wrapper.md](extend/custom-wrapper.md)

Key facts:
- Services in `system_stream_wrapper.services.yml` tag `ModuleStream`/`ThemeStream`/`ProfileStream`/`LibraryStream`
  with `{ name: stream_wrapper, scheme: module|theme|profile|library }`.
- Type is `StreamWrapperInterface::LOCAL | READ`; every write/delete/rename/mkdir op returns FALSE + `E_USER_WARNING`.
- `getExternalUrl()` yields a public URL (`base_path()` + extension/library dir + target).
- Unknown/disabled owner (module/theme/profile) or missing library dir → `\InvalidArgumentException`.

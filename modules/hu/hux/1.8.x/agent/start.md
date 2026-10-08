# Hux — agent index

Developer API: implement Drupal hooks/alters as attributed methods on a DI-enabled class, no
`.module` file. Works by decorating the `module_handler` service. No routes, permissions, config,
or Drush. Requires PHP 8.3 + core ^11.1.

- **The attributes (`#[Hook]`, `#[Alter]`, `#[ReplaceOriginalHook]`, `#[OriginalInvoker]`), how to
  register a hook class, discovery, and the `optimize` flag** → [api/hooks.md](api/hooks.md)

Key facts:
- Auto-discovery namespace: `Drupal\<module>\Hooks\` (e.g. `src/Hooks/MyModuleHooks.php`).
- Manual registration: public service tagged `{ name: hooks }`.
- Cache rebuild needed only when adding the first hook to a new class.
- Attributes live in `src/Attribute/`; the handler is `src/HuxModuleHandler.php`.

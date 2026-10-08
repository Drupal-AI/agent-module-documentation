Translate Tool is a small developer helper for programmatically adding and deleting locale (interface) translation strings — typically from update or install hooks — without touching the translation UI.

---

The module exposes a single service, `translate_tool` (class `\Drupal\translate_tool\TranslateTool`), wrapping core's `locale.storage` (`StringStorageInterface`). `add($source, $langcode, $translation, $context = '')` looks up the source string via `findString()`, creates a `SourceString` if it doesn't exist yet, then creates/replaces the translation for the given language and (optional) context. `delete($source, $context = '')` removes the string's translations via `deleteStrings()`. Two procedural wrappers, `translate_tool_add()` and `translate_tool_delete()`, call the service so they read naturally inside procedural update/install hooks. There is no admin UI (`configure` is null), no config, no permissions, no Drush commands, and no plugins — it is purely an API. It depends on core `locale`, and is aimed at developers who want their `.po`-independent string translations created in code as part of a deployment/update. Note the source string must already be a translatable (`t()`/locale-collected) string for translations to surface in the UI as normal.

---

- Add a single interface-translation string for a language from a `hook_update_N()` on deploy.
- Seed default translations for a custom module's strings during `hook_install()`.
- Programmatically replace an existing translation with a new value in an update hook.
- Delete a translation string (and its translations) from code during cleanup.
- Add a translation scoped to a specific translation context (e.g. `my-context`).
- Delete a context-scoped translation string.
- Use the procedural `translate_tool_add()` inside a procedural update hook without fetching the service.
- Use the procedural `translate_tool_delete()` to remove a string procedurally.
- Ship language-specific label/message translations as part of a feature's install profile logic.
- Bulk-create translations for many strings by looping over the `add()` service call.
- Keep translation edits in version control (code) instead of exporting/importing `.po` files by hand.
- Correct a mistranslation across an environment fleet by running an update hook that calls `add()`.
- Add translations for a language that has no imported `.po` file yet.
- Inject the `translate_tool` service into a custom service that manages localized content.
- Create a source string on the fly (if missing) and translate it in one `add()` call.
- Remove obsolete strings introduced by a previous release during an upgrade path.
- Populate translations in a test/setup fixture programmatically.
- Provide a default translation for a config or content string during module setup.
- Standardize deployment-time translation changes through a single helper API.

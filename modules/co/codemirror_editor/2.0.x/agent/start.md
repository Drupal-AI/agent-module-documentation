# The CodeMirror Editor — agent index

Integrates the CodeMirror library into Drupal: a text-format **editor**, a **filter**, a
**field widget** + **formatter** (all plugin id `codemirror_editor`), a `#type => 'codemirror'`
render element, and a **language-mode plugin type**. Depends on `editor`, `js_cookie`.
Configure route: `codemirror_editor.settings` (`/admin/config/content/codemirror`).

- **Global settings form & config keys (cdn, minified, theme, language_modes) + the permission** →
  [configure/settings.md](configure/settings.md)
- **The `codemirror_mode` plugin type: define a language mode; the two alter hooks** →
  [plugins/modes.md](plugins/modes.md)
- **Use CodeMirror in code/config: the `#codemirror` element and the editor/filter/widget/formatter plugin ids** →
  [api/usage.md](api/usage.md)
- **Download the CodeMirror library locally: `drush codemirror:download`** →
  [drush/download.md](drush/download.md)

Key facts:
- Config object `codemirror_editor.settings`: `cdn` (bool), `minified` (bool), `theme`
  (string), `language_modes` (sequence of mode plugin ids). Defaults: cdn true, minified
  true, theme `default`, language_modes `[xml]`.
- Permission: `administer codemirror editor` (restricted).
- Mode plugin manager: `plugin.manager.codemirror_mode`, YAML discovery from
  `MODULE.codemirror_modes.yml`. 12 modes ship: clike, css, htmlmixed, javascript, markdown,
  php, python, ruby, sql, twig, xml, yaml.
- Provided plugins (each id `codemirror_editor`): `@Editor`, `#[Filter]`
  (TYPE_TRANSFORM_IRREVERSIBLE), `@FieldWidget` + `@FieldFormatter` (field types
  `string_long`, `text_long`).
- With `cdn: false` the library must live in `libraries/codemirror`; `codemirror:download`
  fetches it and `hook_requirements` warns if absent.

# Language Neutral URL Aliases — agent index

Forces every path alias to be **language-neutral** (`langcode` = `und` /
`LANGCODE_NOT_SPECIFIED`) so one alias works in all languages. Zero config: no admin UI, no
`configure` route, no permissions, no config schema, no Drush. Just enabling it changes
behaviour. Depends only on `path_alias`.

- **How it works — the repository decorator, the storage/list-builder swap, the hook
  ordering, and the legacy-alias caveat** → [extend/mechanism.md](extend/mechanism.md)

Key facts:
- New aliases always save with `langcode = und` (via `NeutralPathAliasStorage::create/save`).
- Lookups are forced to `LANGCODE_NOT_SPECIFIED` by decorating `path_alias.repository`
  (service `language_neutral_aliases.repository_decorator`, priority 9).
- Pre-existing non-neutral aliases become hidden until uninstall; bulk-convert with
  `UPDATE path_alias SET langcode = 'und' WHERE langcode <> 'und';`.
- The translatable "URL alias" field must **not** be translated.

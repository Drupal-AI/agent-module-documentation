# tmgmt_file — agent start

TMGMT translator (provider) submodule for **offline file translation**. Registers the
**`file`** translator plugin (`Drupal\tmgmt_file\Plugin\tmgmt\Translator\FileTranslator`,
namespace `Plugin/tmgmt/Translator`): submitting a job exports its data to a file; uploading the
translated file back imports it for review. Part of the `tmgmt` project. Depends on `tmgmt` and
core `file`. Configured on the Providers page (`entity.tmgmt_translator.collection`).

Pluggable file **format** sub-type:
- Manager `plugin.manager.tmgmt_file.format` (`FormatManager`), namespace
  `Plugin/tmgmt_file/Format`, attribute `Drupal\tmgmt_file\Attribute\FormatPlugin`, interface
  `Drupal\tmgmt_file\Format\FormatInterface`.
- Shipped formats: **`xlf`** (`Xliff`) and **`html`** (`Html`). Add your own by implementing a
  `FormatPlugin`.

Provider settings (`tmgmt.translator.settings.file`), with defaults from `FileTranslator`:
- `export_format` (`xlf`), `allow_override` (`true`), `scheme` (`public`),
  `xliff_processing` (`false`), `xliff_cdata` (`false`), `format_configuration` (`{}`).

Also provides **Drush commands** (`tmgmt_file.commands` /
`Drupal\tmgmt_file\Commands\TmgmtFileCommands`) to script export/import.

For the Translator plugin type / building a provider in general, see the parent:
[../../../../1.18.x/agent/plugins/tmgmt.md](../../../../1.18.x/agent/plugins/tmgmt.md).

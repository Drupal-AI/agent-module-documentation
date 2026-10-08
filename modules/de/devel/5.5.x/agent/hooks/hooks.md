# Devel hooks

From `devel.api.php`:

- `hook_devel_dumper_info_alter(array &$info)` — alter the registered `DevelDumper` plugin
  definitions (e.g. change a label or swap the class used for a dumper id). Fired by
  `DevelDumperPluginManager` via `alterInfo('devel_dumper_info')`.

```php
function my_module_devel_dumper_info_alter(array &$info) {
  $info['default']['label'] = 'Altered label';
}
```

To register a new dumper backend, implement a `DevelDumper` plugin instead — see
[../plugins/dumper.md](../plugins/dumper.md).

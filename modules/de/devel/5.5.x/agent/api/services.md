# Devel API — dump helpers & services

## Global helper functions (devel.module)
Convenience wrappers, safe to call in dev code:
- `dpm($input, $name = NULL)` — dump to the page as a Drupal message.
- `dvm($input, $name = NULL)` — dump to a message via VarDumper.
- `dpr($input, $return, $name)` — print_r-style dump.
- `kint($input)` — Kint dump (when the Kint dumper is available).
- `dd($data, $label)` — write a dump to the debug log file (`debug_logfile`).
- `ddm()/dsm()` — variants for message output.

## Service: `devel.dumper` (DevelDumperManager)
`Drupal\devel\DevelDumperManagerInterface`. Central entry point used by the helpers.
- `dump($input, $name = NULL, $plugin_id = NULL)` — dump using the configured (or given) dumper.
- `message($input, $name = NULL, $type = ..., $plugin_id = NULL)` — dump as a status message.
- `export($input, $name = NULL, $plugin_id = NULL)` — return the dump as a string.
- `debug($input, $name = NULL, $plugin_id = NULL)` — write to the debug log file.
- `dumpOrExport(...)`, `exportAsRenderable(...)` — render-array friendly variants.

## Service: `plugin.manager.devel_dumper` (DevelDumperPluginManager)
Discovers `DevelDumper` plugins; `createInstance()` falls back to `var_dumper` when a
plugin's `checkRequirements()` fails. `isPluginSupported($id)` reports availability. To add a
backend see [../plugins/dumper.md](../plugins/dumper.md).

## Other services
- `devel.twig.debug_extension` — adds a Twig `devel`/dump extension for templates.
- `devel.switch_user_list_helper` — builds the switch-user list (block/permission `switch users`).

# Drush commands — export content to YAML

Provided by `Drupal\default_content\Commands\DefaultContentCommands` (via `drush.services.yml`).
There is no import command — import happens automatically when a module is enabled. These
commands only export.

## Commands

| Command | Alias | Args | Purpose |
|---|---|---|---|
| `default-content:export` | `dce` | `entity_type_id` `entity_id` | Export one entity. |
| `default-content:export-references` | `dcer` | `entity_type_id` `[entity_id]` | Export an entity **and all entities it references**. |
| `default-content:export-module` | `dcem` | `module` | Export every UUID listed in the module's `default_content:` info key. |
| `default-content:export-module-with-references` | `dcemr` | `module` | Same as `dcem` plus all referenced entities. |

### Options
- `dce` — `--file`: write the export to a file (must end in `.yml`) instead of stdout. A File
  entity also copies its physical file into the same folder.
- `dcer` — `--folder`: folder to export into; entities are grouped into subdirectories by
  entity type. If `entity_id` is omitted, every entity of that type is exported.
- `dcem` / `dcemr` — no options; content is written to the module's own `content/` directory
  (`{module path}/content`).

## Examples

```bash
# Single node to stdout
drush dce node 123

# Single node into a module
drush dce node 123 --file=modules/custom/my_module/content/node/123.yml

# A node and everything it references, grouped by type under a folder
drush dcer node 123 --folder=modules/custom/my_module/content

# Everything listed in my_module.info.yml (writes into my_module/content)
drush dcem my_module
drush dcemr my_module
```

## The `content/` file layout (what import reads)

Exported files live inside the providing module:

```
my_module/
  content/
    node/{uuid}.yml
    taxonomy_term/{uuid}.yml
    file/{uuid}.yml   (+ the physical file next to it)
    media/{uuid}.yml
    menu_link_content/{uuid}.yml
    block_content/{uuid}.yml
```

Filename is the entity **UUID** (or entity ID) `.yml`. Only **content** entities are imported;
config entities are skipped. On import the folder is scanned per entity type and files are saved
in dependency order.

## Declaring content in a module's info file (for `dcem`/`dcemr`)

`dcem`/`dcemr` export the UUIDs you list under `default_content:` in `{module}.info.yml`:

```yaml
default_content:
  node:
    - c9a89616-7057-4971-8337-555e425ed782
    - b6d6d9fd-4f28-4918-b100-ffcfb15c9374
  taxonomy_term:
    - 550f86ad-aa11-4047-953f-636d42889f85
  file:
    - 59674274-f1f5-4d6a-be00-fecedfde6534
  media:
    - ee63912a-6276-4081-93af-63ca66285594
  menu_link_content:
    - 9fbb684c-156d-49d6-b24b-755501b434e6
  block_content:
    - af171e09-fcb2-4d93-a94d-77dc61aab213
```

Automatic import does **not** require this list — the importer scans `content/` regardless. The
info-file list only tells the `dcem`/`dcemr` export commands which entities to write out.

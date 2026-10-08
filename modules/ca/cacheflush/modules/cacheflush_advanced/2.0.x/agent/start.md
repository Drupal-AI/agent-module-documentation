# CacheFlush Advanced — agent index

Adds a **"Custom (advanced)"** vertical tab to the CacheFlush preset form for **targeted** cache
clears: delete specific cache ids (`$cid`) from a chosen bin, and invalidate specific cache tags.
Depends on `cacheflush_ui`. No permissions, config, Drush, or plugins.

Core facts:
- `hook_cacheflush_ui_tabs()` → tab id **`vertical_tabs_advance`** ("Custom (advanced)").
- Alters `cacheflush_add_form` / `cacheflush_edit_form`: an AJAX table of **Cache ID + Service (bin)**
  rows, plus a **Cache tags** textfield.
- Stored in the preset's `data`:
  - `data['advanced']['functions'][]` = `['#name' => '…CacheflushApi::clearBinCache',
    '#params' => [<bin_service_id>, 'delete', <cid>]]` (delete one cid from a bin).
  - `data['cache_tags']['functions'][0]` = `['#name' => '…CacheflushApi::clearCacheTags',
    '#params' => [<comma_separated_tags>]]`.

Docs:
- **The advanced tab, how cid/tag selections are stored & run** →
  [configure/advanced.md](configure/advanced.md)

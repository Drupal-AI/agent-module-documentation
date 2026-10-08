# Configure — settings form & block

## Site settings form — `last_visited_pages.settings`

- Route `last_visited_pages.settings` → path `/admin/config/last-visited-pages-settings`,
  `_permission: administer site configuration`.
- Form `Drupal\last_visited_pages\Form\LastVisitedPagesSettingsForm` (extends `ConfigFormBase`,
  form id `last_visited_pages_settings`), editable config `last_visited_pages.settings`.
- One field: `max_places` — a `select` of `1..20`, stored to config key
  `last_visited_pages.settings:max_places` (install default `10`, from
  `config/install/last_visited_pages.settings.yml`).
- This value is only a **ceiling for the block's "number of items" select** — it does not itself
  limit what is stored or displayed unless a block chooses a number. It is read in
  `LastVisitedPagesBlock::buildConfigurationForm()` to build `range(1, $max_places)`.

Set it from the CLI:

```bash
ddev drush cset last_visited_pages.settings max_places 15 -y
```

Reachable in the admin UI from two menu links (both route to the same form):
`last_visited_pages.settings` (under Configuration, parent `system.admin_config`) and
`last_visited_pages.settings_block` (under Configuration » User interface, parent
`system.admin_config_ui`).

## The block — `last_visited_pages_block`

Place the block "Last Visited Pages" (plugin id `last_visited_pages_block`) via Block layout or
`block.block.*` config. Its configuration form (`buildConfigurationForm`) exposes:

| Setting (config key) | Element | Default | Notes |
|---|---|---|---|
| `num_places` (form field `block_num_places_form`) | `select` `1..max_places` | 5 | How many recent links to render. Capped by `max_places` above. |
| `date_format` | `select` of all `date_format` entities + `custom` | `medium` | Format for the visit time shown after each link. |
| `custom_date_format` | `textfield` (PHP date pattern) | '' | Used only when `date_format` == `custom`; visible via `#states` on that choice. |
| `label_display` | core block label toggle | (form sets default TRUE) | When on, `build()` prepends `<h2>` of the block label. |

Notes for agents:
- `defaultConfiguration()` sets `num_places = 5` and returns `['label_display' => FALSE]`.
- The block is per-viewer: `build()` queries rows for `currentUser()->id()` only, newest-first,
  `range(0, num_places)`.
- `getCacheMaxAge()` returns `0`, so the block is never cached — expect it rendered on every request.
- Empty history renders `<p>No recently visited pages.</p>`; a stored empty title is shown as `Home`.
- There is **no** module permission gating who sees the block — control visibility with the normal
  block visibility conditions / region placement.

Example: render the block programmatically is unusual; normally you just place it. To change how
many links show without touching the UI, set the block's `settings.num_places` in its
`block.block.<id>` config export.

# Settings page & asset loading

Route `menu_bootstrap_icon.settings` → `/admin/config/content/menu_bootstrap_icon`
(`SettingsForm`, requires `administer site configuration`). Menu link under
*Configuration → User interface* ("Bootstrap icons update").

## Fields

| Field | Config key | Meaning |
|---|---|---|
| Icon define (textarea, YAML) | `search_list` | The picker search index in YAML. Editable via an ACE YAML editor (`menu_bootstrap_icon/yaml_editor`, loaded from cdnjs). |
| **Generate** (button, AJAX) | — | Scans `icons/*.md` and rebuilds the search index (`BootstrapIconSearch::loadIcons()`), writing `js/iconSearch.json`. |
| Use CDN (checkbox) | `use_cdn` | If set, attach the Bootstrap CDN library where icons are shown (for admin themes that don't already provide Bootstrap 5). |

On submit, if the YAML textarea is non-empty it is decoded and written to
`js/iconSearch.json` (inside the module directory) via `file_put_contents` — so the module
directory must be writable for regeneration to persist. Config schema only declares `use_cdn`
(`menu_bootstrap_icon.settings` → `use_cdn: boolean`); `search_list` and `menu_link_icons` are
written at runtime.

Default install config (`config/install/menu_bootstrap_icon.settings.yml`): `tag: 'i'`,
`use_cdn: true`.

## Icon definition files

Each `icons/<name>.md` has a front-matter block (`--- … ---`) with `tags:`.
`BootstrapIconSearch::loadIcons()` parses each, merges the tags with the hyphen-split filename
(minus `-fill`), and produces `{ title: "bi bi-<name>", searchTerms: [...] }`. To add custom
icons: drop a new `icons/<name>.md`, click Generate.

## Asset libraries (`menu_bootstrap_icon.libraries.yml`)

- `cdn` — Bootstrap 5 bundle JS from jsDelivr (+ depends on `icons`).
- `icons` — Bootstrap Icons font CSS from jsDelivr.
- `iconspicker` — the popover icon-picker JS/CSS (local).
- `bootstrapIcons.plugin` / `.plugin.admin` — CKEditor 5 plugin assets.
- `yaml_editor` — ACE editor from cdnjs (settings form only).
- `viewer-modal` — dialog JS for the file formatter modal.

## Front-end menu caveat

The icon assets are auto-attached on **admin forms and field displays**, but **not** for
rendered front-end menus. Add to your theme's `.info.yml`:

```yaml
libraries:
  - menu_bootstrap_icon/cdn
```

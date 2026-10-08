# AOS JS UI — configuration

## Routes / admin UI (all require permission `administer aos js`)

Base path `/admin/config/user-interface/aosjs`:

| Route | Path suffix | Form/controller |
|---|---|---|
| `aosjs.admin` | (list) | `AosJsAdmin` — selector list + sample preview |
| `aosjs.add` | `/add` | `Form\AosJsForm` |
| `aosjs.edit` | `/edit/{aos_id}` | `Form\AosJsForm` |
| `aosjs.delete` | `/delete/{aos_id}` | `Form\AosJsDelete` |
| `aosjs.duplicate` | `/duplicate/{aos_id}` | `Form\AosJsDuplicate` |
| `aosjs.settings` | `/settings` | `Form\AosJsSettings` |

`configure` route = `aosjs.admin`. Menu link under *Configuration → User interface*.

## Config object `aosjs.settings` (schema `aosjs_ui.schema.yml`, defaults `config/install/aosjs.settings.yml`)

| Key | Default | Meaning |
|---|---|---|
| `load` | `true` | Whether the module attaches AOS at all |
| `version` | `v2` | AOS library version → attaches `aosjs/aos-<version>.js` or `.cdn` |
| `method` | `local` | `local` (bundled lib) or `cdn` |
| `url.visibility` | `'0'` | `0` = show on all EXCEPT listed pages; `1` = show ONLY on listed |
| `url.pages` | admin/edit path list | one glob path per line |
| `options.library` | `aos` | animation library id (`aos`, or `animate` via aosjs_animatecss) |
| `options.animation` | `fade-up` | default animation name |
| `options.offset` | `120` | trigger offset px |
| `options.delay` | `0` | ms |
| `options.duration` | `400` | ms |
| `options.easing` | `ease` | easing function |
| `options.once` | `false` | animate only once |
| `options.mirror` | `false` | animate out on scroll past |
| `options.anchorPlacement` | `top-bottom` | anchor placement |
| `advanced.*` | see file | `disable`, `startEvent`, `initClassName`, `animatedClassName`, `useClassNames`, `disableMutationObserver`, `debounceDelay`, `throttleDelay` |

Drush read: `ddev drush config:get aosjs.settings`.

## Page-visibility logic (`_aosjs_ui_check_url()`)

- `?animate=no` in the query disables AOS for that request.
- Matches current path (and its path alias) against `url.pages` globs; `url.visibility` inverts include/exclude. Empty page list ⇒ everywhere.

## `aos` database table (`hook_schema` in `aosjs_ui.install`)

Stores animation targets (NOT config): columns `aid` (serial PK), `selector` (varchar 255), `label`, `comment` (text), `changed` (int), `status` (tiny int), `options` (big blob, serialized). Indexes on `label`, `selector`, `changed`. Read/write only via the `aosjs.animate_manager` service (see api/manager.md).

## Runtime export (`aosjs_ui_page_attachments()`)

For non-admin matching pages it loads enabled rows, unserializes each `options` blob with `allowed_classes => FALSE`, and sets:
`drupalSettings.aosjs = { version, library, elements: { <aid>: {selector, ...options} }, additional: <advanced> }`, then attaches `aosjs_ui/aos-init`. On the admin `aosjs.admin/*` pages it instead attaches a sample preview (`selector: .aos__sample`).

## Permission

`administer aos js` (title "Administer aos js") — gates every route above. Not `restrict access: true`; grant only to trusted roles (holders can inject arbitrary CSS selectors + AOS options that run site-wide).

## Uninstall note

`aosjs_ui_uninstall()` deletes the `aosjs.settings` row directly from the `config` table (works around the config being co-owned by the base module).

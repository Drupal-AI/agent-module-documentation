# Hooks implemented (`gsap.module`)

The module ships no services or plugins; its runtime wiring is three procedural hooks.

## `hook_page_attachments()`

Runs on every page. Adds cache tag `config:gsap.settings`, then, only when
`gsap.settings:include_gsap` is true:
- attaches `gsap/gsap`;
- if `include_libs` is also true, attaches `gsap/<name>` for each machine name in the `libs`
  config sequence;
- loads all **enabled** `gsap` config entities (entity query on `status = 1`,
  `accessCheck(TRUE)`); if any exist it attaches `gsap/animations` and appends each entity's
  `id, event, scrolltrigger, selector, direction, json` to
  `drupalSettings.gsap.global` (the `json` string is decoded with `Yaml::decode()`, falling back
  to `[]` on error).

Net effect: enabling GSAP globally is what activates the config-entity animations.

## `hook_library_info_build()`

Reads `gsap.settings:custom_libs` and returns one dynamic library per entry, keyed by the
entry's `key`, whose single JS asset is the entry's `path` (with `process => FALSE`) and which
depends on `gsap/gsap`. This is how admin-defined custom libraries become attachable as
`gsap/<key>`. See [../configure/settings.md](../configure/settings.md).

## `hook_help()`

Provides the `help.page.gsap` help text only. No behavior.

## No hooks *for* integrators

The module does not define or invoke any alter/event hooks of its own. To change where GSAP
JS is loaded from (CDN → local), implement core `hook_library_info_alter()` in your own
module/theme against the `gsap` libraries — see [../theme/libraries.md](../theme/libraries.md).

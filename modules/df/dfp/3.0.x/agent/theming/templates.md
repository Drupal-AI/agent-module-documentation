# DFP — theme hooks & templates

Declared in `dfp_theme()` (`dfp.module`); templates in `templates/`. Override in your theme to change
the emitted markup/JS. The three `dfp_js_*` / `dfp_slot_definition_js` hooks are rendered into
`<head>` by the attachments-processor decorator; the `dfp_tag` / `dfp_short_tag` hooks render the
in-page ad element.

| Theme hook | Template | Variables | Purpose |
|---|---|---|---|
| `dfp_tag` | `dfp-tag.html.twig` | `tag` (`TagView`) | The visible ad `<div id="{{ tag.placeholderId }}">` + inline `googletag.display(...)` (wrapped in `googletag.cmd.push` when async). Also renders the slug div when not hidden. |
| `dfp_short_tag` | `dfp-short-tag.html.twig` | `tag`, `url_jump`, `url_ad` | JavaScript-free ad: `<a href="{{ url_jump }}"><img src="{{ url_ad }}"></a>` (email use). |
| `dfp_js_head_top` | `dfp-js-head-top.html.twig` | `google_tag_services_url`, `async_rendering` | Loads the GPT library and initialises `googletag`. |
| `dfp_js_head_bottom` | `dfp-js-head-bottom.html.twig` | `async_rendering`, `single_request`, `collapse_empty_divs`, `disable_init_load`, `targeting` | Enables async/sync, single-request, collapse-divs, disable-init-load, and emits `setTargeting()` calls, then `enableServices()`. |
| `dfp_slot_definition_js` | `dfp-slot-definition-js.html.twig` | `tag` (`TagView`), `async_rendering` | The per-slot `googletag.defineSlot(...)` definition. |

Notes:
- In `dfp-js-head-bottom.html.twig`, targeting keys/values are printed inside an inline `<script>` as
  `'{{ target.target }}'` / `'{{ value }}'` with Twig's default (HTML) autoescaping — `'`, `<`, `>`
  are escaped, so an admin-entered targeting value cannot break out of the script string or element.
- These are only emitted when the page actually carries a `dfp_slot` attachment (i.e. a DFP block or
  tag is on the page).

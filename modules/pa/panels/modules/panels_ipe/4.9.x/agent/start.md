# panels_ipe — agent start

Panels **In-Place Editor**: a Backbone/jQuery UI app that lets editors build a Panels
display on the rendered front end (drag blocks between regions, swap layout, add custom
block content, save). Submodule of `panels`; also depends on core `block_content` and
`jquery_ui_droppable`. It swaps in the `ipe` DisplayBuilder so displays render with the
editor. No config form (`configure: null`). Needs a storage-backed display (e.g. Page
Manager).

- Enable it, permissions, how it renders → [configure/panels_ipe.md](configure/panels_ipe.md)
- `IPEAccess` plugin type (custom access rules) → [plugins/panels_ipe.md](plugins/panels_ipe.md)
- Hooks: alter block/layout lists, presave → [hooks/panels_ipe.md](hooks/panels_ipe.md)
- Parent module → [../../../../4.9.x/agent/start.md](../../../../4.9.x/agent/start.md)

# ECA UI admin

- **Models list / editor:** `/admin/config/workflow/eca` — route and tabs provided via the
  `modeler_api` ModelOwner plugin (`modules/ui/src/Plugin/ModelerApiModelOwner/Eca.php`).
  List, add, edit, clone, enable/disable, import, export, delete `eca` config entities.
- **Settings form:** `Settings.php` writes config `eca.settings` (logging level, documentation
  domain, etc.).
- **Log view:** optional `views.view.eca_log` (installed as optional config) at
  `/admin/config/workflow/eca/log` for reviewing ECA execution log entries.
- **Modeler:** ECA UI only hosts models; install a modeler like `bpmn_io` for the visual
  drag-and-drop canvas.
- **Assets:** `css/eca_ui_inspector.css` (library in `eca_ui.libraries.yml`).

No permissions or plugins of its own; access is governed by ECA/modeler_api model permissions.

# Managing optionsets via the UI

Slick UI attaches the list builder and entity forms to the parent module's `slick` config
entity through `hook_entity_type_build()` (`slick_ui.module`) and defines the routes below
(`slick_ui.routing.yml`). All require permission `administer slick`.

| Route | Path | Purpose |
|---|---|---|
| `entity.slick.collection` | `/admin/config/media/slick` | Optionset list (the **configure** route) |
| `slick.optionset_page_add` | `/admin/config/media/slick/add` | Add optionset |
| `entity.slick.edit_form` | `/admin/config/media/slick/{slick}` | Edit |
| `entity.slick.duplicate_form` | `/admin/config/media/slick/{slick}/duplicate` | Duplicate |
| `entity.slick.delete_form` | `/admin/config/media/slick/{slick}/delete` | Delete |
| `slick.settings` | `/admin/config/media/slick/ui` | Sitewide settings (`slick.settings`) |

Forms: `SlickForm` (add/edit/duplicate), `SlickDeleteForm`, `SlickSettingsForm`. The list
builder is `Drupal\slick_ui\Controller\SlickListBuilder`. Menu/task/action links are provided
by `slick_ui.links.menu.yml`, `.links.task.yml`, `.links.action.yml`.

The entities being edited are `slick.optionset.*` config entities owned by the parent module —
their fields and how they map to Slick JS options are documented in the parent module:
[../../../../slick/3.0.x/agent/configure/optionsets.md](../../../../slick/3.0.x/agent/configure/optionsets.md).
This submodule adds no config schema or plugins of its own; disable it in production and deploy
the exported optionset config.

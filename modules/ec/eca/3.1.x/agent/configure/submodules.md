# Submodules (capability map)

ECA Core is inert; enable submodules to get events/conditions/actions for each subsystem. All are
prefixed `eca_`:

| Submodule | Provides |
|---|---|
| `eca_ui` | The management UI at `/admin/config/workflow/eca` (needs a modeler, e.g. `bpmn_io`) |
| `eca_base` | Base events (cron/custom), conditions, generic actions (set token, etc.) |
| `eca_content` | Content-entity events (presave/insert/update/delete), conditions, actions |
| `eca_form` | Form API events, conditions, actions (alter/validate/submit) |
| `eca_user` | User events (login/logout/register), conditions, actions |
| `eca_workflow` | Content moderation state-transition events and actions |
| `eca_views` | Execute/iterate/export Views query results |
| `eca_access` | Access events, conditions, actions |
| `eca_node_access` | Node view/edit/delete access control (also affects Views listings) |
| `eca_queue` | Queue events, conditions, enqueue/process actions |
| `eca_cache` | Cache actions |
| `eca_config` | Config import/export events |
| `eca_file` | File and file-entity events, conditions, actions |
| `eca_language` | Advanced language handling |
| `eca_log` | Log-message events and actions |
| `eca_menu` | Menu-link options/actions |
| `eca_migrate` | Migrate events |
| `eca_misc` | Miscellaneous kernel/core events and conditions |
| `eca_render` | Rendering (blocks, links) |
| `eca_endpoint` | ECA-served URL endpoints |
| `eca_htmx` | HTMX polling regions, conditions/tokens, HX-* response headers |
| `eca_development` | Dev-only helpers — not for production |

Notable submodules are documented separately under `modules/<name>/`.

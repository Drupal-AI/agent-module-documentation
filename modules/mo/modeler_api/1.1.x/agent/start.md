# modeler_api — agent start

Framework that decouples *what is modeled* (**Model Owners** — config-entity-owning modules
like ECA and AI Agents) from *how it is modeled* (**Modelers** — visual editors like BPMN.iO).
The central `modeler_api.service` (`Api`) mediates every save via 7 generic component types.
Defines 5 plugin types (2 PHP-attribute, 3 YAML). Does nothing alone — needs ≥1 owner + ≥1 modeler.
Config UI: **Admin → Config → Workflow → Modeler API** (`/admin/config/workflow/modeler_api`),
route `modeler_api.settings`. Core `^11.3 || ^12`, PHP `>=8.3`.

- Implement a Modeler or Model Owner (the plugin types) → [plugins/modeler_api.md](plugins/modeler_api.md)
- Call the `Api` service + related services in code → [api/modeler_api.md](api/modeler_api.md)
- Settings form, storage modes, permissions, Drush → [configure/modeler_api.md](configure/modeler_api.md)

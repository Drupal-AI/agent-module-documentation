ECA UI provides the administrative interface for creating, editing, importing, exporting, and managing ECA models at `/admin/config/workflow/eca`.

---

ECA Core is a background engine with no interface of its own; ECA UI adds the management screens. It registers ECA as a model owner through `modeler_api` and surfaces a collection of your models, a global settings form (config `eca.settings`), and an optional log View (`views.view.eca_log`) for inspecting ECA execution. To actually draw and edit models graphically you additionally install a modeler module such as `bpmn_io`; ECA UI hosts it. From here you enable/disable models, clone and delete them, export a model to config or import one, and tune ECA settings such as logging level and documentation output. It also bundles an inspector CSS asset for the model editor. It is the module a site builder enables to work with ECA hands-on.

---

- Browse a list of all ECA models on the site.
- Create a new automation model from the UI.
- Edit an existing model's events, conditions, and actions.
- Enable or disable a model without deleting it.
- Clone a model as a starting point for a new one.
- Delete models that are no longer needed.
- Export a model to configuration YAML.
- Import a model from configuration or a modeler file.
- Adjust ECA settings (logging level, documentation) via the settings form.
- View ECA execution logs through the bundled Views listing.
- Host a visual BPMN modeler (with `bpmn_io`) for drag-and-drop editing.
- Inspect model structure with the inspector styling.
- Give non-developers a no-code place to build workflows.
- Access ECA administration at `/admin/config/workflow/eca`.
- Manage models as deployable configuration entities.
- Provide a single admin home for all ECA capabilities.
- Review which events a model subscribes to.
- Debug models by consulting the log view after runs.
- Standardize workflow authoring across a team.
- Enable/disable logging verbosity for troubleshooting.

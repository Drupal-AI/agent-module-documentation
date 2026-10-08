# bpmn_io — agent start

Integrates the bpmn-js (BPMN.io) graphical editor into Drupal's admin UI as a **Modeler
plugin** for `modeler_api`. Model-owner modules (ECA, AI Agents) render their config
entities as editable BPMN diagrams. Depends on `modeler_api`; no admin settings form,
permissions, or config schema of its own. Requires the **Claro or Gin** admin theme.

- Enable it and select it as a model owner's modeler → [configure/bpmn_io.md](configure/bpmn_io.md)
- The `bpmn_io` Modeler plugin it provides to modeler_api → [plugins/bpmn_io.md](plugins/bpmn_io.md)
- Parser service, convert flow, JS libraries & theme hook → [api/bpmn_io.md](api/bpmn_io.md)

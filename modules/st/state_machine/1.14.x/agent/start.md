# state_machine — agent start

Code-driven workflows. Workflows + workflow groups are **YAML plugins** (like menu links);
the current state lives in a `state` field you change only by applying transitions. No admin
UI, no permissions of its own. Depends on core `options`.

- Define workflows & groups in YAML → [plugins/workflow.md](plugins/workflow.md)
- Read/apply transitions on the state field (+ services) → [api/state-field.md](api/state-field.md)
- Restrict transitions with guards → [extend/guards.md](extend/guards.md)
- React to / modify entities on transition (events) → [extend/events.md](extend/events.md)
- Alter workflow / group definitions (hooks) → [hooks/hooks.md](hooks/hooks.md)

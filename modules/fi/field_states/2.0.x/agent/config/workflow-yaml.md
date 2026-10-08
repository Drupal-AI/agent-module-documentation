<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow YAML and editing surfaces

The whole machine for a field is one YAML string stored in the field's `settings.workflows`
(config schema `field.field_settings.list_states`, key `workflows: string`). Core `allowed_values`
is kept in sync as the flat state list.

## Shape
```yaml
states:
  new: { label: New }
  resolved: { label: Resolved }
  closed: { label: Closed }
transitions:
  new_resolved:
    label: 'New → Resolved'
    from: [new]          # list of source states ('' = initial/[*])
    to: resolved         # single destination state
    # optional keys:
    role: [editor]       # role id(s) allowed to see/use the button
    permission: 'do x'   # permission machine name(s), comma-separated
    group: 1             # Group entity id(s) whose members may use it (needs group module)
    guard: user_guard    # Guard plugin id — authoritative allow/deny
    workflow: [notification_workflow]  # Workflow plugin id(s), pre-save
    action: [email_action]             # core Action plugin id(s), post-save
    class: 'btn btn-danger'            # button CSS classes
    attached: your_module/library      # library to attach
    extra: false         # suppress the formatter's extra field for this transition
    redirect: some.route # route to redirect to after applying
```

## Two editing surfaces
1. **Field settings form** (Field UI → Manage fields → the field). Edit the YAML in an ace editor with a
   live mermaid diagram. Gated by core Field UI access (`administer <entity> fields`). This is the
   normal, config-export-friendly path.
2. **Visual state-machine builder** — route `field_states.state_machine`,
   `/field-states/state-machine/{field}`, `_permission: access states`. A Bootstrap-5-only React app
   (`state_machine/dist/*`) to draw states/transitions; `StateMachineForm::submitForm()` writes the
   drawn YAML straight into `field.field.<id>` config (`settings.workflows` + `allowed_values`) via the
   editable config factory and clears cached field definitions.
   - Bug: the builder's `#editState` flag uses `hasPermission('Administer transition states')` (the
     permission *title*, not machine name `admin states`), so it is false for all but user 1.

## Runtime application
`StatesTransitionService` (service `field_states.transitions`) reads `transitions` back from the field's
`workflows` YAML (`setTransitionByField()`), computes `getPossibleTransitions($state)`, and
`applyTransition()` runs the transition's `workflow` plugins (method `action()`, by reference) then its
`action` plugins (method `execute()`). The `state_default`/`state_transition` formatters and
`StateTransitionForm` drive this at display time.

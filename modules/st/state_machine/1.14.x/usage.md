State Machine provides code-driven workflows: sets of states and transitions that an entity moves through during its lifecycle, stored in a `state` field that exposes an API for getting and applying transitions.

---

Unlike Drupal core's Content Moderation (which is UI/config driven), State Machine defines workflows in YAML plugins shipped by a module, making it ideal for developers who need reliable, version-controlled state logic. A **workflow** declares its states and transitions (each transition has a label, one or more allowed `from` states, and a single `to` state). Workflows belong to a **workflow group**, which ties them to an entity type and lets several workflows share a purpose (e.g. all order workflows). The current state lives in a `state` field type; you never write the state directly — instead you call `applyTransitionById()` and save, so the module can validate the change and fire events. **Guards** (tagged services) can veto individual transitions based on permissions, sibling entities, or any custom logic. On save the field dispatches `pre_transition` and `post_transition` events at transition-specific, group-specific, and generic granularities, so other code can react or modify the entity. A validation constraint ensures a submitted state is reachable via an allowed transition, and a field formatter can render the allowed transitions as an inline action form. It is the workflow engine underpinning Drupal Commerce (order, payment, fulfillment, shipment states) and is widely reused for custom domain workflows.

---

- Model a Commerce order lifecycle (new → fulfillment → completed / canceled).
- Drive payment state machines (authorization → capture → refund).
- Track shipment states (ready → shipped → delivered).
- Add an editorial approval workflow to a custom content entity.
- Give a subscription entity active/paused/canceled states.
- Model a support ticket lifecycle (open → in progress → resolved → closed).
- Enforce that only valid transitions can change an entity's state.
- Restrict a transition to users with a specific permission via a guard.
- Block a transition unless a related entity meets a condition (guard on a parent order).
- React to a state change to send a notification email (post_transition event).
- Modify the entity just before a transition is saved (pre_transition event).
- Log every workflow transition across the whole site (generic events).
- Attach multiple independent workflows to one entity (e.g. legal + marketing states).
- Render allowed transitions as inline buttons outside the edit form (formatter).
- Provide a confirmation form for a state transition via an entity link template.
- Validate submitted states in a REST/JSON:API payload with the state constraint.
- Filter a View by a state field's value using the provided Views filter.
- Resolve which workflow a field uses at runtime via a value callback.
- Override the default Workflow plugin class for advanced group behavior.
- Alter another module's workflow definitions with `hook_workflows_alter()`.
- Add or relabel workflow groups with `hook_workflow_groups_alter()`.
- Query allowed transitions from code to build a custom UI.
- Programmatically apply a transition in a queue worker or cron job.
- Compare state field changes in revisions when the Diff module is present.
- Build a finite-state-machine for any domain object stored as an entity.

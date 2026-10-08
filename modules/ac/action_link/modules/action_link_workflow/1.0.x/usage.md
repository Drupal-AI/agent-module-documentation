Action link workflow provides an experimental action-link type that exposes a content-moderation workflow's transitions as clickable links.

---

This experimental Action Link submodule (requiring core Workflows) adds a `workflow` State Action plugin. Instead of declaring fixed directions, the plugin derives one plugin per workflow entity and reads the workflow's transitions to build its directions, so each transition becomes a direction the user can trigger from a link. The next state for a direction is computed from the entity's current `moderation_state` and the requested transition's target state. The submodule is a work in progress: several plugin methods are stubbed and the target entity type is currently hardcoded, so it is best treated as a starting point for building workflow action links rather than a finished feature.

---

- Offer clickable links to move a moderated node between workflow states (e.g. Draft → Published).
- Derive a set of transition links automatically from an editorial workflow's defined transitions.
- Prototype one-click content-moderation transitions in a listing or teaser.
- Use as a reference/starting point for a custom workflow-driven State Action plugin.
- Present each workflow transition as its own labelled action link direction.
- Combine with the AJAX link style to trigger a transition without a full page reload (once completed).

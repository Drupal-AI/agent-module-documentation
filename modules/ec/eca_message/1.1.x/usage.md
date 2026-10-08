ECA Message is a tiny "plug & play" bridge that lets ECA models create Message module entities as part of automated workflows.

---

The Message module defines a `message` content entity but, on its own, does not let ECA's generic entity-creation actions create those entities. ECA Message closes that gap: on install it re-points the `message` entity type's access handler (via `hook_entity_type_alter()`) to its own `MessageAccessControlHandler`, so that ECA models — using ECA's standard "Create/save entity" actions from the ECA Content submodule — can build and save Message entities (activity-stream records, notifications, log-style events) when an ECA event fires. The module ships no ECA plugins, forms, routes, permissions, config or Drush commands of its own; it is a single hook plus one access-handler class. It is described by its maintainers as a temporary solution until the equivalent capability lands in ECA core (drupal.org issue 3375899). Requires the ECA and Message modules; core `^9 || ^10 || ^11`.

---

- Create a Message entity from an ECA model when a node is published, to seed an activity stream.
- Log a "user registered" activity Message whenever a new account is created via ECA.
- Record a Message when a comment is posted, for a per-user notifications feed.
- Emit a Message entity on entity update to drive Message Notify email/SMS delivery.
- Write an audit-style Message record each time an editor changes a workflow/moderation state.
- Generate a "content flagged" Message when the Flag module marks an entity, all inside one ECA model.
- Produce onboarding-step Messages as a user completes profile fields, sequenced by ECA conditions.
- Create Messages for e-commerce events (order placed, order shipped) from Commerce ECA events.
- Populate a social "who did what" feed by creating a Message per follow/like action.
- Turn incoming webform submissions into Message entities for a moderation queue.
- Fan out a single ECA event into multiple Message templates (e.g. author + subscribers) with several create actions.
- Set Message fields (arguments/token values, referenced entities) in the same ECA model that creates the Message.
- Schedule delayed activity Messages by combining ECA with cron-driven or queued events.
- Build a digest source by creating Messages that a later ECA model or Views query aggregates.
- Replace bespoke custom code that previously created Message entities in a hook_ENTITY_insert().
- Prototype notification flows in the ECA UI without writing PHP.
- Bridge third-party events (via ECA custom events) into the site's Message-based activity log.
- Create Messages tied to group/organic-group membership changes for group activity feeds.
- Record content-import or migration milestones as Message entities through ECA.
- Attach a Message entity to media publishing events for an editorial activity trail.

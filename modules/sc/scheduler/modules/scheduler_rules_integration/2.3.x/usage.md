Scheduler Rules Integration is a Scheduler sub-module that exposes Scheduler's publishing and unpublishing to the Rules module as reaction events, conditions and actions.

---

This sub-module bridges Scheduler and the contrib Rules module so site builders can automate behaviour around scheduled publishing without writing code. It provides Rules **events** that fire when Scheduler publishes or unpublishes an entity (derived per supported entity type — node, media, taxonomy term, commerce product), Rules **conditions** to test whether an entity is enabled for scheduling or currently scheduled for publishing/unpublishing, and Rules **actions** to set or remove the publish/unpublish dates or to publish/unpublish an entity immediately. Each plugin is derived per entity type, and legacy variants are kept for backwards compatibility with older configurations. It requires both Scheduler and Rules to be installed. With it you can, for example, send a notification when content is scheduled, or set an automatic unpublish date whenever a particular type of node is created. It adds no configuration UI of its own; everything is done through the Rules reaction-rule interface.

---

- Send an email to an editor when content is scheduled for publishing.
- Notify a team when Scheduler unpublishes an entity.
- Automatically set an unpublish date when a node of a given type is created.
- Set a publish date based on another field's value using a Rules action.
- Clear an entity's publish date when some condition is met.
- Remove an unpublish date automatically under a Rules condition.
- Publish an entity immediately from a reaction rule.
- Unpublish an entity immediately from a reaction rule.
- Branch a rule on whether scheduled publishing is enabled for an entity.
- Branch a rule on whether an entity is currently scheduled for publishing.
- Branch a rule on whether an entity is scheduled for unpublishing.
- Log a custom message whenever Scheduler publishes a node.
- Trigger integration with an external system when content goes live.
- Apply different automation per entity type (node vs media vs product).
- Keep legacy Rules configurations working after upgrading Scheduler.
- Add a moderation or approval step by reacting to scheduled events.
- Update a related entity when a product is scheduled to publish.
- Post to social media when a scheduled article is published.
- Enforce business rules around embargo dates via conditions and actions.
- Combine Scheduler events with other Rules conditions for complex workflows.

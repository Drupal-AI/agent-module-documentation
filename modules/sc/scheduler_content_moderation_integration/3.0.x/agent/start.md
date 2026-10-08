# scheduler_content_moderation_integration — agent start

Makes Scheduler transition entities to a chosen Content Moderation state at the scheduled time.
Adds `publish_state`/`unpublish_state` fields to the Scheduling Options. No admin page, no
permissions. Requires `scheduler` (^2), `content_moderation`, `options`.

- Enable it on a workflow + entity type → [configure/setup.md](configure/setup.md)
- How it hooks Scheduler (hooks, event, constraints, tokens) → [api/integration.md](api/integration.md)

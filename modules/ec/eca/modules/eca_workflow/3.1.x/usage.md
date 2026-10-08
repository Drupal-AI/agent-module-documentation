ECA Workflow integrates core Content Moderation with ECA, firing events on moderation state transitions and providing an action to programmatically transition content between workflow states.

---

This submodule bridges ECA and core's Content Moderation (its dependency). Its events fire when moderated content changes state — for example draft → review → published — letting models react to editorial transitions. Its action set can execute a workflow transition on an entity, derived per available transition, so a model can move content to a target state as part of an automation (e.g. auto-publish after approval, or send content back to draft on validation failure). Combined with eca_content and eca_user you can build full editorial workflows: notify reviewers on submission, enforce approval rules, auto-publish on schedule, or escalate stale content. It registers into ECA Core's managers and defines no new plugin types.

---

- React when content moves to a new moderation state.
- Notify reviewers when content is submitted for review.
- Auto-publish content once it reaches an approved state.
- Send content back to draft when validation fails.
- Programmatically transition an entity to a target state.
- Escalate content that stays in review too long (with cron).
- Log editorial state changes for auditing.
- Trigger downstream actions on publish/unpublish transitions.
- Enforce approval rules before allowing publication.
- Assign follow-up tasks when content changes state.
- Email authors when their content is approved or rejected.
- Move content through a multi-step editorial pipeline automatically.
- Branch model logic on the moderation transition that occurred.
- Combine moderation transitions with role checks (eca_user).
- Auto-archive content after a period in the published state.
- Kick off integrations (webhooks) on state change.
- Update related entities when a parent's workflow state changes.
- Require specific fields before a transition is allowed.
- Schedule state transitions via ECA cron events.
- Standardize editorial workflows as deployable models.

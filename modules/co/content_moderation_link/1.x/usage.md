<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Moderation Link lets editors move a moderated entity into a different workflow state by visiting a specially crafted URL, so moderation actions can be triggered from outside the site (email, chat, dashboards).

---

Built on core Content Moderation, the module exposes a route `/content-moderation-link/process/{state}/{type}/{id}` whose controller loads the entity, checks that the current user is authenticated and that the requested transition is one core's state-transition validator says they may perform, then sets the entity's `moderation_state` and saves it. Anonymous visitors are redirected to log in first. A settings form lets you allowlist which entity types and which workflow states links may target (leaving a list empty permits any value), toggle processing of multiple comma-separated IDs, choose whether to skip un-loadable IDs, and set the route the user is redirected to afterward. A `[node:moderation-link:<state>]` token produces the ready-made absolute URL for embedding in outbound messages, and two alter hooks let other modules adjust the entity or account before save.

---

- Give editors one-click "Publish" links inside notification emails.
- Add a moderation transition link to a dashboard or listing.
- Move a node from draft to in-review from a Slack or Teams message.
- Publish content directly from an editorial reminder email.
- Archive or unpublish content via a link.
- Advance content through a custom editorial workflow by URL.
- Process several pieces of content at once with comma-separated IDs.
- Embed a `[node:moderation-link:published]` token in a message template.
- Generate absolute moderation URLs for outbound integrations.
- Redirect editors to a specific route after they moderate.
- Restrict which entity types moderation links may target.
- Restrict which workflow states links may move content to.
- Keep the link permission-aware so it only surfaces allowed transitions.
- Require login before any transition happens.
- Skip un-loadable IDs when batch-processing, or halt on the first error.
- Let editors moderate without opening the full edit form.
- Streamline approvals for high-volume editorial teams.
- Integrate moderation actions into a CRM or ticketing follow-up.
- Alter the entity before save via `hook_content_moderation_link_alter_entity()`.
- Alter the acting account before save via `hook_content_moderation_link_alter_account()`.
- Add a revision log entry noting the state change for revisionable entities.
- Pair with core Workflows to define the states and transitions used.
- Confirm the configured allowlists match your workflow before production.
- Test the generated links against your transition permissions.

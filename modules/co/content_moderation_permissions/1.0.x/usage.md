<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content moderation permissions dynamically generates a permission for each workflow transition per content type, letting you grant moderation transitions with content-type granularity that core cannot.
---
Core Content Moderation grants a transition (e.g. Draft → Published) with a single "use <workflow> transition <transition>" permission that applies to every content type using that workflow. This module adds finer control: a dynamic permission callback (`Permissions::transitionPermissions`) loops over every `content_moderation` workflow, its transitions and every node type the workflow applies to, generating permissions named `use <workflow_id> transition <transition_id> for <content_type_id>`. These appear on the standard permissions page and can be assigned per role.

Enforcement comes from a service decorator: `content_moderation_permissions.state_transition_validation` decorates core's `content_moderation.state_transition_validation`. Its `getValidTransitions()` merges the inner (core) valid transitions with any transitions the user is granted through this module's per-type permissions, and `isTransitionValid()` returns TRUE if either the core global permission or the per-content-type permission is held. Because it only ever *adds* granted transitions on top of core's result, it broadens access strictly by explicit permission grant — it never removes core-granted access, and users without the new permissions are unaffected. The module also defines an `administer content_moderation_permissions configuration` permission (marked `restrict access: true`). Only node entities are handled by the per-type logic; other entity types fall through to core behavior.
---
- Allow a role to publish Articles but not Pages via the same workflow.
- Grant a transition for one content type only.
- Add per-content-type granularity to a shared moderation workflow.
- Let junior editors move Blog posts to review but not other types.
- Restrict an "Archive" transition to a specific content type.
- Assign moderation transitions per role and per bundle.
- Keep core global transition permissions working alongside new ones.
- Combine core and per-type permissions (either grants access).
- Audit which roles can perform a transition on a given content type.
- Configure permissions on the standard People > Permissions page.
- Limit who can publish sensitive content types.
- Delegate moderation of one section without site-wide rights.
- Give a translator role transitions on a single content type.
- Prevent a role from using a transition on content types it shouldn't touch.
- Expand editorial workflows without custom code.
- Model complex editorial teams with bundle-scoped moderation rights.
- Grant "send to review" for News but "publish" for nothing.
- Review generated permission names for a workflow/transition/type combo.
- Ensure users without new permissions retain exactly core behavior.
- Layer per-type transitions onto an existing content moderation setup.

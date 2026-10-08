Paragraphs Role Visibility adds a Paragraphs behavior plugin that restricts viewing of an individual paragraph item to selected user roles, enforced through real entity access (`hook_paragraph_access`), not just CSS hiding.

---

The module ships one Paragraphs behavior plugin, `paragraphs_role_visibility` ("Paragraph visibility"). Enable the behavior on a paragraph type (*Structure → Paragraphs types → edit → Behaviors*), then on each paragraph's *Behavior* tab pick the roles that may view it and an operand — **Any** (`or`) or **All** (`and`). The selection is stored in the paragraph's behavior settings under `wrapper.roles` and `wrapper.operand`. Access is enforced by `hook_ENTITY_TYPE_access` (`paragraph_access`): for the `view` operation, if allowed roles are configured, the module compares them to the current user's roles — with `or`, the user needs any one of the roles; with `and`, the user needs all of them — and returns `AccessResult::forbidden()` when the requirement is not met (otherwise neutral). Because this is entity-level access (with a `user.roles` cache context and the paragraph as a cacheable dependency), a forbidden paragraph is genuinely withheld from rendering, not merely hidden client-side. A small JS adds a "Select all" checkbox convenience in the behavior form. An update hook (`_update_9201`) migrates pre-2.x settings (a flat role list) into the new `wrapper.roles`/`operand` structure across all paragraph revisions. Requires the Paragraphs module; no settings page, no permissions of its own, no Drush.

---

- Show a paragraph only to authenticated users and hide it from anonymous visitors.
- Show a paragraph only to anonymous users (e.g. a "please log in" call-to-action).
- Restrict a promotional or pricing paragraph to a "member" role.
- Reveal internal notes paragraphs only to editors/administrators on an otherwise public page.
- Require a user to hold ANY of several roles to see a paragraph (`or` operand).
- Require a user to hold ALL of several roles to see a paragraph (`and` operand).
- Mix public and role-gated paragraphs within the same node/layout.
- Gate a downloadable-resource paragraph behind a subscriber role.
- Hide a beta/preview paragraph from everyone except a QA role.
- Enforce visibility at the access layer so the content is not merely visually hidden.
- Keep role-restricted paragraphs out of rendered/cached output for unauthorized users (correct cache contexts).
- Apply per-item control without creating separate paragraph types per audience.
- Use the "Select all" helper to quickly grant every role.
- Configure visibility per individual paragraph rather than per type.
- Combine with Paragraphs' existing behavior UI without extra fields.
- Migrate legacy role-visibility settings automatically on update.
- Build audience-specific landing sections inside a single flexible content page.
- Restrict a survey/CTA paragraph to a specific customer segment role.
- Limit a partner-only announcement paragraph to a partner role.
- Provide role-tailored content blocks on a shared marketing page.

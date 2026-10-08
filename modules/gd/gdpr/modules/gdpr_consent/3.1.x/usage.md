<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GDPR Consent lets you define versioned consent agreements (e.g. "I agree to marketing emails") and collect and track users' consent to them, including which agreement revision they accepted and when.

---

The module defines a revisionable content entity **`gdpr_consent_agreement`** managed at `/admin/config/gdpr/agreements` (add/edit/delete/revisions UI) with base fields including `title`, `mode` (`implicit`/`explicit`, from `ConsentAgreement::getModes()`), `description`, long description and agreement text. It provides a **consent field type** `gdpr_user_consent` (with widget `gdpr_consent_widget` and formatter `gdpr_consent_formatter`) that you attach to an entity (e.g. a user or webform) so a form can show the agreement and record acceptance; accepted consents are logged as `message` entities via the shipped `consent_agreement_accepted` message template and surfaced through the `gdpr_log_messages` view. To know *whose* consent a given entity records, it defines a **ConsentUserResolver plugin type** (manager `plugin.manager.gdpr_consent_resolver`) with built-in resolvers `gdpr_consent_user_resolver` (user), `gdpr_consent_node_resolver` (node) and `gdpr_consent_profile_resolver` (profile) that map an entity to its owning user. A "My agreements" block (`GdprMyAgreementsBlock`) and a per-user page (`/user/{user}/gdpr/agreements`, route `gdpr_consent.agreements`) list a user's consents. Permissions: `manage gdpr agreements`, `grant gdpr any consent`, `grant gdpr own consent`. Requires `gdpr`, `token`, `message`, `entity_reference_revisions` and `views`. It has no single settings form (`configure: null`); you create agreements and place consent fields.

---

- Create a "Marketing emails" consent agreement users can accept.
- Track explicit vs implicit consent via the agreement `mode`.
- Version consent text so you know which revision a user agreed to.
- Attach a `gdpr_user_consent` field to the user registration form.
- Record consent acceptance as a logged `message` entity with a timestamp.
- Show a user their given consents on `/user/{user}/gdpr/agreements`.
- Place a "My agreements" block on a user dashboard.
- Require acceptance of Terms of Use before completing an action.
- Collect consent on a webform via the consent field.
- Map a node's consent record back to its author with the node resolver.
- Map a profile entity's consent to its user with the profile resolver.
- Add a custom consent resolver for a project-specific entity type.
- Audit who accepted which agreement and when via the gdpr_log_messages view.
- Manage all consent agreements from /admin/config/gdpr/agreements.
- Revert a consent agreement to a previous revision.
- Restrict who can manage agreements with the manage gdpr agreements permission.
- Let users grant their own consent (grant gdpr own consent) without staff.
- Let staff grant consent on behalf of a user (grant gdpr any consent).
- Present agreement long-description/HTML text alongside the checkbox.
- Integrate consent tracking into the wider GDPR "all your data" page.
- Keep a defensible record of consent for compliance evidence.
- Use tokens in agreement text via the token dependency.

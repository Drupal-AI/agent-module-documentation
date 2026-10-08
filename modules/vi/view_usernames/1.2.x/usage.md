<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View Usernames closes Drupal's username-disclosure gap: it introduces a *View usernames* permission and hardens `getDisplayName()`, `#theme => 'username'` and field access so a username is not exposed to users who lack it — including through JSON:API.

---

Drupal core treats usernames as effectively public, which the module's README frames as a privacy problem (drupal.org issues #3241232 and #3240913): with JSON:API enabled, a site's whole user base can be enumerated. This module changes the default. Out of the box a username is visible only when the account is Anonymous, when the viewer is the account owner, or when the viewer holds *Administer users* or the new **`view usernames`** permission. Enforcement is layered deliberately: `hook_user_access()` and `hook_entity_field_access()` (both delegating to an `EntityHooks` class) handle proper access checks, while `hook_preprocess_username()` adds a last-resort guard so any code path using `#theme => 'username'` inherits the check even when it forgot to ask — the source is candid that this "is not supposed to be here but currently this is the safest way". Extensibility comes from a **decider** pattern: `ViewUsernameAccessDeciderCollector` is a `service_id_collector` over services tagged `view_username_access_decider`, so a site can add business logic (colleagues in the same group may see each other, say) by registering another decider; the shipped `DefaultViewUsernameAccessDecider` runs at priority 1024. There is also an internal event subscriber fixing JSON:API early-rendering interaction, and a temporary bypass service used internally. The permission's own description warns that granting it to anonymous or all authenticated users re-opens the exposure, particularly with JSON:API.

---

- Stop anonymous visitors from enumerating usernames.
- Prevent JSON:API from exposing the whole user base.
- Treat usernames as personal data for GDPR purposes.
- Hide the identity of staff accounts from competitors.
- Let users always see their own username.
- Grant username visibility only to trusted roles.
- Keep author names hidden on public content listings.
- Add custom rules for who may see whose username.
- Allow group members to see each other's usernames via a custom decider.
- Harden username exposure even where code skips access checks.
- Keep anonymous user labels visible while hiding real accounts.
- Audit which roles can see usernames.
- Reduce the attack surface for credential-stuffing reconnaissance.
- Comply with an internal privacy policy on staff identities.
- Prevent username leakage through rendered comments.
- Protect usernames in REST and JSON:API responses.
- Show display names to administrators only.
- Keep username access decisions cacheable and correct.
- Layer the module onto an existing site without content changes.
- Document and justify username exposure decisions to a DPO.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Profile Complete Percentage (pcp) shows the logged-in user a block with a progress bar reporting how much of their profile is filled in, based on the account fields an administrator marks as counting toward completion.

---

The mechanism is small and entirely display-side. At `/admin/config/people/pcp` (permission `pcp administer`) an admin ticks which user (account) fields count toward "complete" — the checkbox list is built from the `user` entity's configurable fields (`FieldConfigInterface`), so it covers custom account fields, not core name/email. Three global options sit alongside: hide the block once the user reaches 100%, show the "next" field in **random** or **fixed** order, and open the field deep-link in the **same** or a **new** window. The module then provides a **"Profile Complete Percentage"** block (in the *User* category, id `pcp_block`) whose `blockAccess` allows any **authenticated** user and whose `build()` always loads the **current** user — so every viewer sees only their **own** completion, never anyone else's. `PcpService::getCompletePercentageData()` intersects the configured field list with the user's real fields (dropping stale/deleted config), counts how many are empty via `$user->get($field)->isEmpty()`, and returns current percent, next percent, completed/incomplete counts, and a suggested "next" empty field. The block renders `pcp_template` (a CSS progress bar plus a *"Filling out X will bring your profile to N% complete"* line that deep-links to `/user/{uid}/edit#edit-{field}-wrapper`). Everything is computed live — the block sets `getCacheMaxAge(0)` — so toggling required fields updates displays immediately. Version **2.0.0**, core `^9 || ^10 || ^11`, no dependencies beyond core `field`/`user`. Two practical cautions: including **every** field makes 100% unreachable (configure only fields that genuinely matter), and a completion bar creates pressure to supply data, which is a nudge when the fields are needed and a dark pattern when they are not.

---

- Show a logged-in user a profile-completion progress bar.
- Nudge new members to finish onboarding after registration.
- Prompt users to upload a profile photograph.
- Encourage members to write a biography or "about" field.
- Suggest one concrete next field to fill in, with a deep link to it.
- Deep-link the user straight to the exact account-edit field to complete.
- Show what percentage the next field would bring the profile to.
- Hide the reminder block automatically once the profile hits 100%.
- Randomise which "next" field is suggested on each page load.
- Present suggested fields in a fixed order instead of random.
- Drive completion of custom account fields (interests, location, phone).
- Improve data quality for a member directory that reads those fields.
- Improve match/recommendation features that depend on profile data.
- Support a community site's engagement loop around richer profiles.
- Segment or measure membership by which fields members have filled.
- Place the completion block in a sidebar, dashboard, or user page.
- Open the field link in a new window to keep the current page.
- Update completion instantly when admins add or remove required fields.
- Keep completion display strictly per-viewer (each user sees only their own).
- Limit "complete" to a curated subset of fields so 100% is achievable.

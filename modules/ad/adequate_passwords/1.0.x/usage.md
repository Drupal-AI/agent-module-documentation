<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adequate Passwords requires a minimum password strength when validating password fields, using the same criteria as Drupal core's built-in strength indicator.

---
Core shows users a password strength meter (weak / fair / good / strong) but never enforces it — a user can ignore the advice and save a weak password. Adequate Passwords closes that gap by turning the meter's own scoring into a hard requirement, so the feedback users already see becomes the rule they must meet.

It works entirely additively. `hook_element_info_alter()` attaches an `#after_build` to core's `password_confirm` element, which unshifts a validator to the front of the element's validation chain. That validator recomputes a 0–100 score with logic functionally equivalent to core's `Drupal.evaluatePasswordStrength` (penalties for length under 12, and for missing lowercase, uppercase, numbers or punctuation, plus a hard drop when the password equals the username) and sets a form error listing the same improvement tips if the score is below the configured threshold. It only ever adds an error; it does not weaken, replace, or bypass core authentication or the core password constraints. The random password used during CLI site install is skipped so installs never break.

Configuration lives at `/admin/config/people/adequate_passwords` (`administer site configuration`): choose the threshold (Strong 80 / Good 70 / Fair 60 / off), the roles it applies to (empty = all), and whether to show a success message.
---
- Enforce a minimum password strength site-wide
- Require the "Strong" strength level for passwords
- Require the "Good" strength level for passwords
- Require the "Fair" strength level for passwords
- Turn strength checking off without uninstalling the module
- Apply the policy only to selected roles
- Apply the policy to every role by leaving the role list empty
- Exempt anonymous users automatically from the policy
- Match enforcement to the core strength meter users already see
- Reject passwords shorter than 12 characters
- Require a mix of upper- and lowercase letters
- Require numbers in passwords
- Require punctuation in passwords
- Reject a password equal to the username
- Show users the specific recommendations to strengthen a weak password
- Display a confirmation message when a password is adequate
- Keep registration and profile-edit forms consistent under one policy
- Avoid breaking CLI site installation (random install password is skipped)
- Strengthen password rules without replacing core authentication
- Combine with other password modules where a consistent UI is preferred
- Configure the threshold at `/admin/config/people/adequate_passwords`

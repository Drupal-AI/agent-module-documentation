<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Select Registration Roles adds a role chooser to the registration form, showing only the roles an administrator has approved for self-selection, with an optional approval step per role.

---

Sites with distinct audiences want to know at signup which one someone belongs to: student or staff, buyer or supplier, member or volunteer. Drupal's answer is that roles are granted by an administrator, which is correct as a security posture and awkward as a workflow — it means every registration waits for someone to look at it. This module supplies the middle ground: an administrator picks which roles appear as options, a registering visitor picks one or several, and roles flagged as needing approval leave the account **blocked** until an administrator acts, while unflagged ones activate immediately. Version **2.0.0** on `^10 || ^11`, configured at the module's own settings route. The obvious question is whether a visitor can submit a role that was never offered, and the answer here is no — verified by posting a forged role id to `/user/register` on a clean install, which Drupal's own Form API `#options` validation rejected with *"The submitted value srr_super in the Choose a role element is not allowed."* Note that the defence is **core's**, not the module's: the submit handler calls `addRole()` on whatever it is given without re-checking the allow-list, so it is correct today and rests on Form API behaviour rather than on its own validation. Two practical notes: the security of the whole arrangement is the administrator's choice of which roles to offer, so never expose a role carrying `administer permissions`, `administer users` or anything that can grant further permissions; and a warning is emitted from the form alter when a configured role has no matching entry in the approval settings, which on a site with error display enabled prints a PHP notice on the public registration page.

---

- Ask new users which audience they belong to.
- Offer a student or staff role at signup.
- Let volunteers self-identify.
- Require approval for a sensitive role.
- Reduce manual role assignment.
- Route signups to the right group.
- Offer a supplier role on registration.
- Block accounts pending role approval.
- Segment a membership site at signup.
- Let members choose an interest role.
- Support a multi-audience site.
- Reduce administrator workload.
- Offer several roles as checkboxes.
- Make a role choice required.
- Activate low-risk roles immediately.
- Notify administrators of role requests.
- Support a community with tiers.
- Collect audience data at registration.

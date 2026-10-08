<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevent User Delete Reassign removes the "Delete the account and make its content belong to the Anonymous user" option from Drupal's account-cancellation forms.

---

Install it like any module (`composer require drupal/prevent_user_delete_reassign` then enable **Prevent User Delete Reassign**, or drop it in and `drush en prevent_user_delete_reassign`); it depends only on core **User** and has **no settings page or configuration** — enabling it is the whole setup. Drupal offers four account-cancellation methods, and this removes the quietly destructive one: `user_cancel_reassign` keeps every node, comment and file the user created but sets the author to Anonymous, so the content survives while the record of who wrote it does not — irreversibly, with no warning, and it can trigger core bug [#2977362](https://www.drupal.org/project/drupal/issues/2977362) where old revisions by the cancelled author get republished as the default. With the module enabled, the option no longer appears on either the single-user cancel form at `/user/{user}/cancel` or the bulk **People → Cancel accounts** form at `/admin/people/cancel`, and a warning message explains that it was removed; the three safe methods remain — **disable the account**, **disable and unpublish its content**, or **delete the account and its content**. This forces a deliberate choice among alternatives such as reassigning authorship to a named archive account beforehand. One operational note: the change is at the **form layer only**, so it does not affect programmatic cancellations via `user_cancel()`, `drush user:cancel`, or custom scripts that pass a cancel method explicitly — review those separately if your site has them.

---

- Stop content being orphaned to Anonymous when accounts are cancelled.
- Preserve authorship when accounts are removed.
- Remove the `user_cancel_reassign` method from both cancel forms.
- Protect an audit or accountability trail.
- Force a deliberate cancellation choice among the safe methods.
- Avoid losing article attribution on an editorial site.
- Keep "own content" permissions meaningful after offboarding.
- Prevent an irreversible administrator mistake.
- Support an editorial accountability policy.
- Sidestep core bug #2977362's revision-republishing behavior.
- Protect a publication's byline data.
- Avoid unowned content after a user departure.
- Support a records-retention requirement.
- Reduce administrator error on the cancel form.
- Keep content attributable after departures.
- Guide administrators to reassign to an archive account instead.
- Protect a community's post history.
- Avoid breaking author-based views and reports.
- Support a compliance review.
- Apply the safeguard to bulk cancellations as well as single ones.

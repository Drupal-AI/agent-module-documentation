# Role-aware maxlength — manual setup guide

**Role-aware maxlength** (`role_aware_maxlength`) enforces **different character
limits on text fields depending on the current user's roles**. Core's built-in
`maxlength` property sets a single hard limit for everyone; this module extends that
idea so site builders can define different limits per role on any string or text
field. A common example is a microblogging platform where standard users can post up
to 500 characters while journalists can post up to 1,200.

Limits are configured **per field instance** on the field's form-display widget, and
they are enforced **server-side** via a typed-data constraint — so the limit is real,
not just a hint in the browser. When a user holds several roles, the **highest**
applicable limit is applied. An optional widget adds a live character counter and the
correct `maxlength` attribute in the form.

The module depends on core's Field and User modules and requires Drupal 11.3 or
newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** — you configure limits per field, on that
field's form-display widget, as described below.

## How to use it

Setup happens on a field's **Manage form display**:

1. Go to the **Manage form display** page for the entity type and bundle that
   contains the field you want to limit (for example
   `/admin/structure/comment/manage/chirp/form-display`).
2. Click the **gear icon** next to the field's widget and expand the **Role-aware
   character limits** section.
3. Set the limits:
   - **Default limit** — applies to any user who has no role-specific limit; leave
     it blank for no default limit.
   - **Limit per role** — one field per configured role; leave a role blank to fall
     back to the default limit for that role.
4. **Attach the constraint.** In this release the typed-data constraint must be
   attached to the field instance explicitly — the configured limits are enforced
   only once the `RoleAwareMaxlength` constraint is on the field. This is done in
   code (for example in a custom module's install/update hook):

   ```php
   $fieldConfig = FieldConfig::loadByName('comment', 'chirp', 'comment_body');
   $fieldConfig->addConstraint('RoleAwareMaxlength');
   $fieldConfig->save();
   ```

   A future version may attach the constraint automatically when limits are
   configured, but for now this step is required.
5. *(Optional)* Switch the field's widget to **Textarea (role-aware maxlength)** to
   get the live character counter and the correct `maxlength` attribute
   automatically. For CKEditor fields the counter is rendered through the module's
   widget integration — see the project's `README.md` for details.

The highest limit across all of a user's roles is the one that applies, and because
enforcement is a server-side constraint, over-length input is rejected on save even
if the front-end counter is bypassed.

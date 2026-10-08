# Enforce User Fields — manual setup guide

**Enforce User Fields** (`enforce_user_fields`) forces users to complete the
required fields on their account before they can carry on. When a user logs in,
the module checks whether any required fields on their account are still empty; if
so, it redirects them to their profile edit form and keeps them there until the
required fields are filled. It has no other module dependencies.

This solves a common gap: when you add a new required field to the user profile,
existing users are not asked to fill it — they just keep browsing with an
incomplete profile. The module is also handy when users register through
third-party services (Facebook, LinkedIn, and the like) where some required data
cannot be imported, or when required fields are hidden during registration but
you still want them completed before the user gets full access. It supports the
*Multiple Registration* module.

The one thing to weigh is scope. Because the redirect intercepts navigation,
confirm it does not trap users on pages they legitimately need (such as logout or
help), and make sure the required-field set is genuinely required — over-broad
enforcement frustrates users and can lock them into the edit form. The module
provides its own permission for controlling who is subject to (or exempt from)
enforcement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated configuration form** documented for this module. What
gets enforced is driven by which user account fields you mark **required**, and
by the module's own permission (see below).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Decide which account fields must be completed and mark them **required** at
   **Configuration → People → Account settings → Manage fields**
   (`/admin/config/people/accounts/fields`).
3. Review the module's **permission** at **People → Permissions**
   (`/admin/people/permissions`) to control who is subject to enforcement.
4. Test with a non-admin account that has an empty required field: on login the
   user should be redirected to their edit form and held there until the field is
   filled. Confirm essential routes (like logout) remain reachable.

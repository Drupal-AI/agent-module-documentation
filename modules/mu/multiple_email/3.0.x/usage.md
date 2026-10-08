<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multiple Email Addresses lets a user attach several email addresses to their account, each confirmed by an emailed code, and promote any confirmed address to be the account's primary email.

---


Emails are stored as `multiple_email` content entities owned by the user. A per-user management tab (`/user/{user}/edit/email-addresses`) lists addresses and offers add / confirm / resend / set-primary / remove flows, each on its own entity-access-gated route and confirm form. `EmailConfirmer` generates a random confirmation code with PHP's secure `Randomizer`, emails it via the mail manager + token replacement, and marks the address confirmed when the code matches. Registering an address also reserves it so nobody else can register a new account with it. Two permissions gate the feature: `administer multiple emails` (settings) and `use multiple emails` (personal tab). A custom access check (`_access_multiple_email_personal_tab`) governs the manage tab.

Setup: enable the module, grant `use multiple emails`, configure confirmation/expiry and the account-form email field behavior at `/admin/config/people/multiple-email`.
---
- Let users add extra email addresses to their account.
- Confirm a new address via an emailed code.
- Resend a confirmation email.
- Cancel a pending confirmation.
- Set a confirmed address as the primary email.
- Remove a secondary email address.
- Reserve registered addresses so they can't seed new accounts.
- Hide the core email field on the account edit form.
- Manage addresses from the per-user email tab.
- Restrict configuration with `administer multiple emails`.
- Grant end users the `use multiple emails` permission.
- Configure confirmation email subject/body with tokens.
- Set confirmation-code expiry.
- Localize confirmation emails per language.
- Act on registration via `hook_multiple_email_register`.
- Act on confirmation via `hook_multiple_email_confirm`.
- Act on deletion via `hook_multiple_email_delete`.
- Enforce entity access on each email operation route.
- Generate secure confirmation codes with the Randomizer.
- Audit email events through the module logger channel.
- Provide a Navigation menu link to the email management page.

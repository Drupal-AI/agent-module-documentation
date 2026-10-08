# Configuration

There is no global settings page. You configure the module on each webform by adding the
**User Registration** handler and filling in its form.

## Add the handler to a webform

1. Go to **Structure → Webforms** and edit the webform you want to turn into a
   registration form (it needs at least an email element).
2. Open **Settings → Emails/Handlers**.
3. Click **Add handler** and choose **User Registration**.

You can add more than one User Registration handler to a single webform if you need to.
Configuring handlers at all requires webform-admin rights, which is a trusted permission.

## The handler settings, group by group

### Create user

- **Enabled** — allow *anonymous* submitters to create a new account. Off by default.
- **Roles** — one or more roles to give the new account. This checklist only appears for
  admins who also hold the **Administer permissions** permission, so a lower-privileged
  webform editor cannot use this form to hand out roles. The Authenticated role is always
  included and cannot be unticked.
- **Require admin approval** — when on (the default), the new account is created *blocked*
  and an administrator must approve it before the person can log in. You can set the
  message shown to the submitter.
- **Require email verification** — when on (the default), the account gets a
  system-generated password and the standard verification email; the person sets their
  password via that email before first login. You can set the message shown.
- **Success message** — the confirmation shown after a successful registration (default:
  "Registration successful. You are now logged in.").
- **Keep email as username** — when on, the account's username is the full email address;
  when off (the default), the `@` in the email is replaced with a `.` to form the username.

### Update user

- **Enabled** — allow a *logged-in* submitter to update their own account from the form.
  Off by default. When on, the mapped fields are written back to the current user's
  account. (Changing the email without also providing a password is ignored, matching
  Drupal core's own rule.)

### User field mapping

This is where you connect the form to the account. Each row maps a **webform element** to
a **user field or property** (for example: an email element → `mail`, a "Full name"
element → a custom `field_full_name`). The destination list includes all user fields; the
source list is your webform's value elements.

A mapping to the email (`mail`) field is **required** when account creation is enabled — if
it is missing, the form shows the error "User creation requires at least a source for
email address."

## What happens on submission

- **Anonymous submitter + creation enabled** → a new account is built with the mapped
  values, a generated password, the current interface language, and the configured roles;
  it is then blocked (approval) or activated. Depending on your settings, Drupal sends the
  pending-approval email, sends the email-verification email, or logs the person straight
  in — showing the matching message you configured.
- **Logged-in submitter + update enabled** → the current account is loaded and the mapped
  values are written to it.
- If Drupal's own account validation fails (for example an invalid email, or a username
  already taken), the errors are shown *inline on the matching webform elements* rather
  than as a generic failure.

## Important limitation: no AJAX

The handler does **not** support AJAX-submitted webforms — logging a user in during an
AJAX submission trips Drupal's suspicious-form protection. If your webform uses AJAX, the
handler shows a warning linking to either disable AJAX for that form or set a confirmation
redirect instead.

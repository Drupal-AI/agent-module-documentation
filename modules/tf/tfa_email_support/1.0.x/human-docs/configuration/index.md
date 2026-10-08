# Configuration

There are two sides to configuring TFA Email Support: enabling and enrolling in
Email OTP (through the TFA module), and customising the emails that get sent
(through this module's own templates form).

## Turn on Email OTP

In **Configuration → People → TFA** (`/admin/config/people/tfa`), choose **Email
OTP** as the default validation plugin and save. This makes email available as a
second factor across the site's TFA flow.

## How a user enrols

Enrolment is a two-step process handled by the module's setup plugin:

1. The user chooses either their account email or a custom email address.
2. A verification code is emailed to that address; the user enters it to confirm.

On success, the chosen email is stored against that user's TFA settings and email
becomes their active second factor.

## How login works

When an enrolled user logs in, the module generates a 6-digit one-time passcode,
stores it briefly (with a short expiry), and emails it. The login form shows a
**masked** version of the recipient address and a **resend** control that becomes
available again after a 120-second cooldown. Entering the correct code completes
the login, and the stored code is then cleared. Expired codes that are never used
are cleaned up automatically on cron.

## Customise the emails — the templates form

Go to `/admin/config/people/tfa/email-templates`. Editing this form requires the
**Administer site configuration** permission. From here you control the messages
the module sends:

- **Subject and body templates** for each message type — the login OTP, the
  enrolment (setup) code, and backup codes.
- **Dynamic tokens** you can drop into any subject or body, including `@otp`,
  `@username`, `@user_email`, `@site_name`, `@site_url`, `@date`, `@time`,
  `@ip_address`, `@user_agent`, `@expiry_minutes`, `@support_email`, `@login_url`,
  and `@backup_codes`.
- **HTML templates** — switch on the HTML option to send styled HTML email, using
  the module's supplied templates or a generated layout instead of plain text.
- **Custom headers, reply-to address, and priority** — set a reply-to email,
  additional headers, and the message priority for outgoing TFA mail.

Save the form to apply your changes.

## How the codes are stored

Codes are short-lived and TFA's own flood control caps repeated guesses. Codes are
stored in Drupal's `state` store with short expiries and are deliberately kept out
of the logs.

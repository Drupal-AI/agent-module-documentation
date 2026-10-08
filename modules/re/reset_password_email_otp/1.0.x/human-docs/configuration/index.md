# Configuration

Setting up the OTP reset flow is two steps: configure the OTP options and labels on
the settings page, then place the reset-form block where users can reach it.

## Step 1 — Configure the OTP settings

1. Log in as a user with permission to administer the module's configuration.
2. Go to **Configuration → People → Reset Password Email OTP**
   (`/admin/config/people/reset-password-email-otp`).

On this form you can set:

- **The one-time passcode options** — including the OTP **length**. A longer code is
  harder to guess; the code is generated with a cryptographically secure random
  generator, and a wrong-attempt limit protects against brute force.
- **Email settings** — the message and details of the email that carries the OTP to
  the user.
- **Labels** used throughout the multi-step form (requesting the code, validating
  it, and setting the new password).
- **Delivery choice** — if you installed the optional SMS dependencies, users can
  choose email or SMS; the default choice is set here.

Save the form when you are done.

> Choosing a longer OTP length reduces guessing risk. Make sure the email path to
> your users is trustworthy.

## Step 2 — Place the reset-form block

The reset flow is rendered by a block, so you decide where it appears:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want, find the **Reset Password Email
   OTP Form** block, and place it (typically on or near your login page).

Alternatively, if you use the **Twig Tweak** module, you can render the block
anywhere in a template with:

```twig
{{ drupal_block('reset_password_email_otp_form') }}
```

## Verify

Visit the page where you placed the block, request a reset for a test account,
retrieve the OTP from the email, enter it, and set a new password to confirm the
whole flow works end to end.

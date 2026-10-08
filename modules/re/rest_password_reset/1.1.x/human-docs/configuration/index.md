# Configuration

After enabling the module and activating its REST endpoints, the remaining step is to
tell the module where your front end lives, so the reset email points users at your
page rather than Drupal's.

## Open the settings form

1. Log in as an administrator (a user with permission to administer the site's
   configuration).
2. Go to **Configuration → Web services → Rest Password Reset**.

The form is **multilingual**, so on a multilingual site you can provide the reset
message and link for each language.

## What you configure here

The core purpose of this form is the **front-end reset endpoint** — the page in your
decoupled application that a user lands on when they click the reset link in their
email. Drupal builds the link with the same hash-and-timestamp mechanism it uses for
its own reset flow, but instead of sending the user to Drupal's `/user/reset/...`
page, it sends them to the address you set here. Your front-end page reads the hash,
timestamp and user id from the link and posts them (with the new password) to the
`POST /user/password/reset` endpoint to complete the reset.

Because the email text is translatable, you can also tailor the wording of the
message that accompanies the link per language.

## Save

Fill in the endpoint (and message) for each language you support and save the form.
Then run through the flow end to end: request a reset for a test account, open the
email, confirm the link points at your front end, and complete a reset via the
`POST /user/password/reset` endpoint.

## Related settings elsewhere

Two things that affect this flow are **not** on this form:

- **Endpoint activation and anonymous access** live under **Configuration → Web
  services → REST** and **People → Permissions** — see
  [Installation](../installation/index.md).
- The **reset-link timeout** is Drupal's standard reset/one-time-login timeout; the
  module honours it, so adjust it in your normal account settings if needed.

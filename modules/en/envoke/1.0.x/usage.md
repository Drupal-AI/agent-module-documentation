Envoke routes Drupal's outgoing mail through the Envoke email-marketing platform and can create/update Envoke contacts and read their subscription interests.

---

Envoke provides a Drupal Mail plugin (`envoke_mail`) that hands site email to Envoke's send API instead of PHP `mail()` or SMTP, wrapping each message in an HTML email template and honouring per-message and site-wide sender defaults. Alongside the mailer it ships `EnvokeService`, a small Guzzle-based API client that talks to Envoke's contacts API: it can create a contact if one does not exist, patch an existing contact's subscription "interests" (subscribe/unsubscribe), and fetch the interests a given email is currently subscribed to. All of this is driven by one admin settings form under Configuration → Services → Envoke, where you enter your Envoke API ID/KEY (and an optional separate ID/KEY pair for subscription/newsletter operations), the campaign name, and the from/reply-to sender defaults. The module is a beta pre-release with deliberately basic functionality — it does not add subscribe blocks, forms, or webhooks; the contact/subscription methods are exposed as a service for other code to call.

---

- Send all Drupal site email through Envoke by selecting the "Envoke mailer" plugin as the mail backend.
- Deliver transactional mail (user registration, password reset, contact form) via the Envoke platform.
- Wrap outgoing messages in the bundled `envoke-mail.html.twig` HTML email template.
- Override the mail template by copying `envoke-mail.html.twig` into your theme.
- Apply a chosen Drupal text format to the message body before sending (via the "Input format" setting).
- Automatically convert plain-text message bodies to HTML (newlines to `<br>`) for the HTML part.
- Send both an HTML and a plain-text alternative for each message.
- Set a default From email address and From name for all Envoke mail.
- Set a default Reply-to address for all Envoke mail.
- Let individual messages override the From / Reply-to via the standard Drupal mail array.
- Tag outgoing mail with an Envoke campaign name (defaults to the site name).
- Deliver a single message to multiple comma-separated recipients, one Envoke send per address.
- Use a dedicated Envoke API ID/KEY pair for subscription/newsletter operations, separate from transactional send credentials.
- Create an Envoke contact from an email address if it does not already exist.
- Record express consent metadata when creating a contact.
- Programmatically subscribe a contact to Envoke "interests" (newsletters/lists) from custom code.
- Programmatically unsubscribe a contact from selected interests.
- Re-subscribe a previously unsubscribed contact by switching their consent status back to Express.
- Read the list of interests an email address is currently subscribed to (skipping revoked contacts).
- Build a custom newsletter signup flow in your own module on top of `EnvokeService`.
- Restrict who may configure the integration with the dedicated "Administer Envoke" permission.
- Keep mail delivery on a marketing platform so subscriber and campaign data live in Envoke.
- Run on Drupal 9, 10, or 11 with no additional Composer or contrib dependencies.

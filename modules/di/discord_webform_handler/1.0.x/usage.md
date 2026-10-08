Discord Webform Handler adds a single Webform handler plugin that POSTs each Webform submission to a Discord channel through an incoming webhook URL.

---

The module ships one class, `DiscordWebformHandler` (Webform handler plugin id `discord_webhook`, label "Discord Webhook"), and nothing else — no routes, permissions, services, config schema, or Drush commands. You add the handler to any individual Webform from its *Settings → Emails / Handlers* screen and paste a Discord incoming-webhook URL into the handler's single **Discord Webhook URL** setting. On each confirmed submission the handler collects `WebformSubmission::getData()`, `json_encode()`s that array, and sends it as the `content` field of a JSON body via Drupal's shared `\Drupal::httpClient()` (Guzzle) `POST` to the configured webhook. Discord then displays the raw JSON string as a message in the linked channel. The handler is single-cardinality (one per webform) and runs on processed results. Failures are caught and written to the `webform_discord_webhook` logger channel rather than surfaced to the submitter. Requires the contrib **Webform** module.

---

- Post every submission of a contact form to a Discord staff channel for real-time notifications.
- Route support-request forms to a dedicated Discord support channel.
- Send lead-capture / newsletter-signup submissions to a sales Discord channel.
- Notify a moderation channel whenever a user-generated content form is submitted.
- Mirror event-registration submissions into a Discord events channel.
- Give a small team submission alerts without configuring SMTP or email deliverability.
- Feed submissions into a Discord channel that a bot or automation further processes.
- Provide an at-a-glance activity feed of form activity for stakeholders in Discord.
- Alert an on-call channel when an incident-report webform is filled in.
- Send job-application form submissions to a hiring Discord server.
- Push RSVP form data to a community Discord.
- Notify a channel of bug-report webform submissions during QA.
- Deliver order/quote-request form data to a fulfillment Discord channel.
- Attach different webhook URLs to different webforms so each form notifies a different channel.
- Use per-webform handler enable/disable to pause Discord notifications without deleting config.
- Combine with Webform's other handlers (email, remote post) so Discord is one of several destinations.
- Get instant visibility of survey responses in a Discord channel.
- Notify a volunteer-coordination channel of sign-up submissions.
- Send feedback-form entries to a product Discord for triage.
- Forward donation-form submissions to a fundraising channel for acknowledgement.

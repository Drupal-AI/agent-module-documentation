Mailchimp integrates Drupal with the Mailchimp email marketing platform, providing the core API connection that its submodules build on to manage audiences, campaigns, and signup forms.

---

The base Mailchimp module is the connector: it wraps the `thinkshout/mailchimp-api-php` library in an `ApiService` and `ClientFactory`, handles authentication (API key or OAuth), caches audience and merge-variable data, and exposes a webhook endpoint so Mailchimp can notify the site of subscribe/unsubscribe/profile events. Configuration lives at `/admin/config/services/mailchimp` (API key, OAuth, timeout, batch limit, test mode, cron queueing). On its own the base module does little user-facing work — its value comes from the submodules it enables: **Mailchimp Audiences** (`mailchimp_lists`) adds a subscription field type so any entity (usually users) can be tied to Mailchimp audiences and merge fields; **Mailchimp Campaign** (`mailchimp_campaign`) lets you author, send, test, and pull stats for campaigns from within Drupal; **Mailchimp Signup** (`mailchimp_signup`) provides configurable signup blocks and pages; **Mailchimp Events** adds behavioral-targeting events; and **Mailchimp ECA** exposes events/actions to the ECA automation module. Subscription and batch operations can be queued and run on cron (`drush mailchimp:cron`) to respect API limits. Developers hook into the flow with alter hooks for merge vars, interest groups, campaign content, and webhook processing. It is the standard way to connect a Drupal site to Mailchimp for newsletters and transactional marketing.

---

- Connect a Drupal site to a Mailchimp account via API key or OAuth.
- Sync site users into a Mailchimp audience automatically.
- Add a newsletter signup block to any page (with the signup submodule).
- Build a standalone signup page with custom audience and merge fields.
- Let users manage their subscription preferences from their Drupal account.
- Author and send Mailchimp campaigns without leaving Drupal (campaign submodule).
- Send a test email of a campaign before the real send.
- Pull campaign open/click stats back into Drupal.
- Map Drupal fields to Mailchimp merge variables per audience.
- Batch-update merge variables for existing subscribers.
- Receive subscribe/unsubscribe/profile updates via the Mailchimp webhook endpoint.
- Queue subscription operations and process them on cron to respect API limits.
- Run Mailchimp cron jobs manually with `drush mailchimp:cron`.
- Cache audience and merge-var data to reduce API calls.
- Use double opt-in and show a configurable confirmation message.
- Segment subscribers using Mailchimp interest groups exposed as form options.
- Alter merge vars before they are sent with `hook_mailchimp_lists_mergevars_alter()`.
- Alter interest groups before submission with `hook_mailchimp_lists_interest_groups_alter()`.
- React to successful subscribes/unsubscribes via subscribe/unsubscribe hooks.
- Send behavioral-targeting events to Mailchimp (events submodule).
- Trigger Mailchimp actions from ECA workflows (ECA submodule).
- Run the integration in test mode so no live API calls are made during development.
- Authenticate via OAuth so no long-lived API key is stored.
- Provide newsletter opt-in on registration or webform submissions.
- Alter campaign recipients/template programmatically before saving.
- Support multiple audiences and let editors choose per signup form.

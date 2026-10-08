Integrates Drupal with the Campaign Monitor email-marketing API (via the `campaignmonitor/createsend-php` SDK), letting the site sync subscriber lists and expose subscribe forms/blocks to visitors and users.

---

The module stores a Campaign Monitor **API key** and optional **Client ID** in `campaignmonitor.settings` config and wraps the `createsend-php` SDK behind two services: `campaignmonitor.manager` (lists, subscribers, stats, custom fields, cached remote data) and `campaignmonitor.subscription_manager` (subscribe/unsubscribe, form building, queueing). Remote lists are fetched and cached; an admin **enables** individual lists and configures per-list display/custom-field settings at `admin/config/services/campaignmonitor/lists`. A `campaignmonitor_subscribe_block` block renders a `CampaignMonitorSubscribeForm` that collects an email (plus name/custom fields) and subscribes the visitor to one list ("single") or lets them pick from several ("user select"). Subscriptions run in real time or, if the **cron** option is on, are queued to `campaignmonitor_queue_cron` and processed on cron in batches (`batch_limit`). Deleting a user auto-unsubscribes their email from every list. Two submodules extend it: `campaignmonitor_registration` adds opt-in checkboxes to the user registration form, and `campaignmonitor_user` adds a subscription-management tab on the user profile. All admin operations are gated by `administer campaignmonitor`. The Campaign Monitor API host is fixed by the SDK, so there is no arbitrary-URL/SSRF surface; the subscribe block is intended for anonymous/visitor use by design.

---

- Connect a Drupal site to a Campaign Monitor account with an API key and Client ID.
- Fetch and cache the account's subscriber lists for use on the site.
- Enable/disable specific Campaign Monitor lists for site use.
- Place a "Subscribe" block that signs visitors up to a single named list.
- Place a subscribe block that lets the visitor choose which of several lists to join.
- Collect custom fields (text, select, multi-select, number, date) on the subscribe form.
- Pre-fill the subscriber's name/fields from user tokens when the Token module is present.
- Add newsletter opt-in checkboxes to the user registration form (registration submodule).
- Let logged-in users manage their newsletter subscriptions from their profile (user submodule).
- Queue subscribe/unsubscribe operations to cron instead of calling the API on each request.
- Batch-process queued subscription operations with a configurable batch limit.
- Automatically unsubscribe a user's email from all lists when their account is deleted.
- Show a newsletter archive to users holding "access archive".
- Cache list/subscriber/stats data with a configurable cache timeout to reduce API calls.
- Log Campaign Monitor API errors to the Drupal log when logging is enabled.
- Customise the subscription-confirmation message shown after a successful signup.
- Clear the cached Campaign Monitor list data on demand from the admin UI.
- Look up whether a given email is already subscribed to a list and retrieve their details.
- React to subscribe/unsubscribe events via `hook_campaignmonitor_subscribe` / `hook_campaignmonitor_unsubscribe`.
- Programmatically subscribe or unsubscribe an email from code via the subscription manager service.
- Present per-list instructions and explanatory text with the `@name` list-name token.
- Enable double opt-in / interests handling through the subscription manager API.
- Use segment-based list settings on a subscribe block.
- Provide a self-service unsubscribe path for site users through the user profile tab.

Submodule of Campaign Monitor that adds newsletter opt-in to the Drupal user **registration** form, so new users can subscribe to Campaign Monitor lists as they sign up.

---

The module implements `hook_form_user_register_form_alter()` to inject a `campaignmonitor_subscribe` opt-in checkbox plus, depending on `campaignmonitor_registration.settings`, either a single list's subscribe fields (name + custom fields, built by the parent's `singleSubscribeForm()`) or a checkbox list of all enabled lists flagged for registration display (per-list `display.registration`). On submit, if the opt-in box is checked, it reassembles the (Drupal-flattened) custom fields and hands off to the parent's `CampaignMonitorSubscriptionManager::subscribeSubmitHandler()`, which subscribes the new account's own email (`mail`) to the selected list(s). It also alters the per-list settings form (`hook_form_campaignmonitor_list_settings_form_alter`) to add a "Display list on registration page" checkbox so admins choose which lists appear at registration. An admin form lives at `admin/config/services/campaignmonitor/registration` (perm `administer campaignmonitor`), config object `campaignmonitor_registration.settings`. Requires the parent `campaignmonitor` module; delegates all API work to it.

---

- Let users subscribe to a newsletter while creating their account.
- Add a single-list opt-in (with name/custom fields) to the registration form.
- Add a multi-list checkbox selector to the registration form.
- Choose per list whether it appears on the registration page.
- Show list descriptions next to each registration opt-in checkbox.
- Conditionally show/require name and custom fields only when the opt-in box is checked.
- Customise the opt-in checkbox label text via the `checkbox_text` config.
- Reuse the parent module's list settings and custom-field configuration on the register form.
- Subscribe the new account's email to Campaign Monitor immediately on registration.
- Combine with the parent's cron queueing so signups queue rather than call the API inline.
- Present a "Would you like to subscribe to newsletters?" prompt at signup.
- Keep newsletter signup and account creation in a single step for the user.
- Drive marketing list growth from new user registrations.
- Support both name and Campaign Monitor custom fields at registration time.
- Set the opt-in defaults from the admin settings page without touching code.
- Pick single-list vs user-select subscription mode for the registration form.

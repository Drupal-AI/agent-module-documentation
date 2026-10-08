# Hooks — form alters (Campaign Monitor Registration)

All logic is procedural, in `campaignmonitor_registration.module`. This submodule has no services of its
own; it wires the core register form to the parent's subscription manager.

## `hook_form_user_register_form_alter()`
`campaignmonitor_registration_form_user_register_form_alter()` — adds to the core user registration form:

- `campaignmonitor_subscribe` — a checkbox (`#title` = config `checkbox_text`, class `campaignmonitor-subscribe`).
- When config `list` = `single`: appends the parent
  `CampaignMonitorSubscriptionManager::singleSubscribeForm($config)` (Name + custom fields for the nominated
  `list_id`). A hidden `custom_fields` element serialises the custom-field keys, because Drupal flattens the
  form tree on submit and they are restored in the submit handler. Name / custom-field elements get `#states`
  so they are only visible (and only required) when the opt-in box is checked.
- Otherwise (`user_select`): a `selection` checkboxes element listing every enabled list whose per-list setting
  `display.registration` is on; per-option descriptions are applied via the
  `_campaignmonitor_registration_option_descriptions()` `#after_build` callback.
- A hidden `config` element carries the serialised settings.
- Appends `campaignmonitor_registration_form_user_register_submit` to each non-preview submit button.

## Submit handler
`campaignmonitor_registration_form_user_register_submit()` — runs only if `campaignmonitor_subscribe` was
checked. Restores the flattened `CustomFields` from the serialised `custom_fields`, then calls the parent
`campaignmonitor.subscription_manager::subscribeSubmitHandler($form, $form_state)`. That handler subscribes the
email entered on the registration form (`$values['mail']`, i.e. the new account's own address) to the selected
list(s), running inline or queued to `campaignmonitor_queue_cron` when the parent's `cron` setting is on.

## `hook_form_campaignmonitor_list_settings_form_alter()`
`campaignmonitor_registration_form_campaignmonitor_list_settings_form_alter()` — adds a "Display list on
registration page" checkbox (`display.registration`) to each list's settings form
(`campaignmonitor_list_settings_form`). Its submit handler
`campaignmonitor_registration_form_campaignmonitor_list_settings_submit()` saves the values via
`CampaignMonitorManager::setListSettings($list_id, $values)` (dropping the remote-only `options` key).

Parent subscribe API used above: [api/services.md](../../../../../3.0.x/agent/api/services.md).

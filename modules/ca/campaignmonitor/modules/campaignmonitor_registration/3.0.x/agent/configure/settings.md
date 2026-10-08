# Configure — Campaign Monitor Registration

Admin form `CampaignMonitorRegistrationAdminForm`
(`\Drupal\campaignmonitor_registration\Form\CampaignMonitorRegistrationAdminForm`) at
`admin/config/services/campaignmonitor/registration` (route `campaignmonitor_registration.admin`,
perm `administer campaignmonitor`, form id `campaignmonitor_registration_admin_settings`). Editable
config: `campaignmonitor_registration.settings`. The module does **not** set a `configure:` link in its
`.info.yml`.

The form adds a `checkbox_text` textarea (the opt-in label) and embeds the parent's
`CampaignMonitorSubscriptionManager::subscribeSettingsForm()` (list mode, target list, accompanying text).

## `campaignmonitor_registration.settings` keys

| Key | Type | Set by | Meaning |
|---|---|---|---|
| `checkbox_text` | string (textarea) | this form | Label shown next to the `campaignmonitor_subscribe` opt-in checkbox on the register form. |
| `list` | string | parent `subscribeSettingsForm` | `single` (one nominated list, shows its fields) or `user_select` (checkbox list of enabled lists). |
| `list_id` | string | parent `subscribeSettingsForm` | Campaign Monitor list ID used when `list` = `single`. |
| `list_id_text` | string | parent `subscribeSettingsForm` | Text shown with the single-list block; `@name` token = list name. Default config ships `"Would you like to subscribe to newsletters?"`. |

No config schema is shipped for this object (only the default `config/campaignmonitor_registration.settings.yml`).

Set without the UI:
```bash
ddev drush cset campaignmonitor_registration.settings checkbox_text 'Subscribe to our newsletter' -y
ddev drush cset campaignmonitor_registration.settings list single -y
ddev drush cset campaignmonitor_registration.settings list_id 'CM_LIST_ID' -y
```

## Which lists appear at registration
When `list` = `user_select`, a list is offered on the register form only if it is (a) enabled in the parent
module (`CampaignMonitorManager::isListEnabled()`) and (b) has its per-list setting `display.registration`
turned on. That per-list "Display list on registration page" checkbox is added by this submodule to each
list's settings form — see [hooks/form-alters.md](hooks/form-alters.md). Parent list config is stored in
`campaignmonitor.settings.list`; see the parent's
[configure/settings.md](../../../../../3.0.x/agent/configure/settings.md).

# Configure — Campaign Monitor User

## Admin form
`CampaignMonitorUserAdminForm` (`\Drupal\campaignmonitor_user\Form\CampaignMonitorUserAdminForm`) at
`admin/config/services/campaignmonitor/user` (route `campaignmonitor_user.admin`, perm
`administer campaignmonitor`, form id `campaignmonitor_user_admin_settings`). Editable config:
`campaignmonitor_user.settings`. The form embeds the parent's
`CampaignMonitorSubscriptionManager::subscribeSettingsForm()` (list mode / target list / text). The module
does **not** set a `configure:` link in its `.info.yml`.

## `campaignmonitor_user.settings` keys

| Key | Type | Source | Meaning |
|---|---|---|---|
| `subscription_heading` | string | default config | Heading for the profile subscriptions section (default `"My Subscriptions"`). |
| `subscription_text` | string | default config | Intro text (default `"I'm interested in"`). |
| `list_heading` | string | default config | Heading above the list checkboxes (default `"I'm interested in"`). |
| `list` | string | admin form | `single` or `user_select` subscription mode. |
| `list_id` | string | admin form | Campaign Monitor list ID when `list` = `single`. |
| `list_id_text` | string | admin form | Accompanying text for the single-list form; `@name` token = list name. |

No config schema is shipped (only the default `config/campaignmonitor_user.settings.yml`).

Set without the UI:
```bash
ddev drush cset campaignmonitor_user.settings list user_select -y
ddev drush cset campaignmonitor_user.settings subscription_heading 'My newsletters' -y
```

## Profile subscription page
Route `campaignmonitor_user.page` → `/user/{user}/campaignmonitor` (perm `access campaign monitor user`),
rendered as a tab on the user profile (`campaignmonitor_user.links.task.yml`, base route
`entity.user.canonical`; `{user}` is an `entity:user` parameter). Controller
`CampaignMonitorUserController::subscriptionPage()`:

1. Reads `campaignmonitor_user.settings` (raw data).
2. Builds the parent form `\Drupal\campaignmonitor\Form\CampaignMonitorSubscribeForm` seeded with that config.

The subscribe form pre-fills the email from the **current** logged-in account and shows either the single
list's fields or a checkbox list of enabled lists (with the user's current subscriptions pre-checked, via
`CampaignMonitorManager::getUserSubscriptions()`). Submitting calls the parent `subscribeSubmitHandler()` →
`userSubscribe()`. The controller does not use the `{user}` path parameter — it always operates on the current
user. Parent form/service details: [api/services.md](../../../../../3.0.x/agent/api/services.md).

## Service
`campaignmonitor_user.manager` (`CampaignMonitorUserManager`, `campaignmonitor_user.services.yml`) extends the
parent `CampaignMonitorManager` with current-user and entity-type-manager dependencies. It defines no methods
beyond the parent manager's; the profile page uses the parent's subscribe form rather than this service.

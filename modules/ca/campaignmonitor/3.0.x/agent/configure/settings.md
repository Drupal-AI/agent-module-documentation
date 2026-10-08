# Configure Campaign Monitor

Admin form `CampaignMonitorAdminForm` at `admin/config/services/campaignmonitor`
(route `campaignmonitor.admin`, perm `administer campaignmonitor`). Config object: `campaignmonitor.settings`.

## Setup flow
1. Enter **API Key** and **Client ID** on the settings form and save. (Client ID unlocks the general settings.)
2. Go to **Lists** (`admin/config/services/campaignmonitor/lists`) — the module fetches lists from the account.
3. **Enable** the lists you want available on the site, then edit each list's display / custom-field settings.
4. Place the `campaignmonitor_subscribe_block` block and choose its list(s).

## `campaignmonitor.settings` keys (schema `campaignmonitor.schema.yml`)

| Key | Type | Meaning |
|---|---|---|
| `api_key` | string | Campaign Monitor API integration key. |
| `client_id` | string | Campaign Monitor Client ID (enables general settings + client SDK object). |
| `cache_timeout` | string | Seconds to cache stats/subscribers/archive/list data (default `360`). |
| `archive` | bool | Enable newsletter archive. |
| `logging` | bool | Log Campaign Monitor API errors. |
| `instructions` | string | Newsletter selection instructions text. |
| `subscription_confirmation_text` | string | Message after a successful subscribe (`@name` = list name, `@interests`). |
| `cron` | bool | Queue subscribe/unsubscribe ops for cron instead of running them immediately. |
| `batch_limit` | integer | Number of queued items to process per cron run. |
| `api_classname` | string | Overridable API class name (advanced). |
| `test_mode` | bool | Whether sends are in test mode. |

Set the API key without the UI:
```bash
ddev drush cset campaignmonitor.settings api_key 'YOUR_KEY' -y
ddev drush cset campaignmonitor.settings client_id 'YOUR_CLIENT_ID' -y
```

## Lists controller routes (`CampaignMonitorListsController`, perm `administer campaignmonitor`)

| Route | Path | Action |
|---|---|---|
| `campaignmonitor.lists` | `/admin/config/services/campaignmonitor/lists` | Overview of remote lists + enable state. |
| `campaignmonitor.list_enable` | `.../list/{list_id}/enable` | Enable a list for site use. |
| `campaignmonitor.list_disable` | `.../list/{list_id}/disable` | Disable a list. |
| `campaignmonitor.list_edit_form` | `.../list/{list_id}/edit` | Per-list display + custom-field settings. |
| `campaignmonitor.list_delete_form` | `.../list/{list_id}/delete` | Delete a list (remote). |
| `campaignmonitor.refresh_lists` | `.../list_cache_clear` | Clear cached list data. |

Per-list settings are stored/read via `CampaignMonitorManager::getListSettings()` / `setListSettings()`; they
include `display` flags (name field, first/last name source fields, registration/user visibility, description)
and `CustomFields` selection/required maps.

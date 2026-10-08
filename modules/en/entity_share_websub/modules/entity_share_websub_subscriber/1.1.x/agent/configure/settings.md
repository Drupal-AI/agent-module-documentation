<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Entity Share Websub Subscriber

Settings form: **`/admin/config/entity-share-websub-subscriber`** (route
`entity_share_websub_subscriber.settings`, permission
`administer entity share websub subscriber settings`). It edits one config object,
`entity_share_websub_subscriber.settings`.

## Config keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `import_config` | string | *(none — required in the form)* | Machine id of the Entity Share `import_config` entity used for the automated background sync. Options are the labels of all `import_config` entities. |
| `hide_default_button` | boolean | `false` | Hide Entity Share's built-in manual **Synchronize** button on the pull form (automation replaces it). |
| `break_subscription_on_edit` | boolean | `false` | When an editor opens an imported, still-verified entity's edit form, add a submit handler that redirects them to a "cancel subscription?" confirmation first. |
| `subscribe_hub_url` | string | `/subscribe` | Path appended to the remote's URL to reach the hub's subscribe endpoint. Empty is treated as `/subscribe`. |
| `cancel_title` | string | `Do you want to cancel subscription?` | Title of the cancel-subscription confirm form. |
| `cancel_description` | text_format | *(long default, `basic_html`)* | Body text of the cancel form (a `value`+`format` pair). |
| `cancel_text` | string | `Keep Subscription` | Label of the "keep" button. |
| `confirm_text` | string | `Cancel Subscription` | Label of the "confirm cancel" button. |

Note: `import_config` and `subscribe_hub_url` are marked `#required` in the form even though
they are absent from `config/install` defaults — set them before relying on automation.

## Read / write via drush

```bash
# read the whole config
drush cget entity_share_websub_subscriber.settings

# set individual keys
drush cset -y entity_share_websub_subscriber.settings hide_default_button true
drush cset -y entity_share_websub_subscriber.settings subscribe_hub_url '/subscribe'
drush cset -y entity_share_websub_subscriber.settings import_config my_import_config_id
```

## Schema

`config/schema/entity_share_websub_subscriber.schema.yml` defines the object as a
`config_object` with the keys above (`cancel_description` is a `text_format`). An update hook,
`entity_share_websub_subscriber_update_9100()`, renamed the misspelled
`break_subscribtion_on_edit` key to `break_subscription_on_edit` — use the corrected key.

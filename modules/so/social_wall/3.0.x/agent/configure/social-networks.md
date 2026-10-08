# Configure social networks

Each network shown on the wall is a `social_network_config` **config entity** (one per account/feed
you want to display). It is managed through the UI and stores the chosen connector plugin plus that
plugin's settings.

## Where / routes (`social_wall.routing.yml`)

All gated by `_permission: 'administer social networks'`.

| Route | Path | Purpose |
| --- | --- | --- |
| `entity.social_network_config.collection` | `/admin/config/services/social-wall` | List (the `configure` link; menu link under *Configuration › Web services*) |
| `entity.social_network_config.add_form` | `/admin/config/services/social-wall/add` | Add |
| `entity.social_network_config.edit_form` | `/admin/config/services/social-wall/{social_network_config}` | Edit |
| `entity.social_network_config.delete_form` | `/admin/config/services/social-wall/{social_network_config}/delete` | Delete |

List builder: `Drupal\social_wall\Controller\SocialNetworkConfigListBuilder` (columns Name, Machine
name). Add/edit form: `Drupal\social_wall\Form\SocialNetworkConfigForm`. Delete:
`SocialNetworkConfigDeleteForm`.

## The entity (`src/Entity/SocialNetworkConfig.php`)

`@ConfigEntityType(id = "social_network_config")`, `config_prefix = "social_network_config"`,
`admin_permission = "administer social networks"`. Exported keys (`config_export`): `id`, `label`,
`widget`. `getWidget()` returns the selected connector plugin id.

The connector's own settings are **not** top-level keys — the form saves them as third-party settings:

```php
$entity->setThirdPartySetting('social_wall', 'sn_config', [
  $entity->id() => $values_from_pluginsettingsForm,
]);
```

So a saved network is read back in the block and the edit form as:

```php
$settings = $entity->getThirdPartySetting('social_wall', 'sn_config', [])[$entity->id()] ?? [];
```

Config schema (`config/schema/social_wall.schema.yml`) types only `id`, `label`, `widget`; the
`sn_config` third-party settings values (credentials, counts…) have no declared schema.

## Add-form flow (`SocialNetworkConfigForm::form()`)

1. `label` (textfield, required) + `id` (`machine_name`).
2. `widget` (select) — options are every `social_network` plugin's `getLabel()`; changing it fires an
   AJAX callback (`ajaxUpdateForm`) that rebuilds the `#sn-config` fieldset.
3. `widget_config[config]` — the selected plugin's `settingsForm($existing_settings)` render array.
   On save, `$this->entity->widget_config['config']` is written into the `sn_config` third-party
   setting keyed by entity id.

## Built-in connector settings

### `twitter_social_network` (`TwitterSocialNetwork::settingsForm()`)

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `account_name` | textfield | yes | screen name to pull `statuses/user_timeline` for |
| `consumer_key` | textfield | yes | Twitter app key |
| `consumer_secret` | textfield | yes | Twitter app secret |
| `access_token` | textfield | yes | OAuth access token |
| `access_token_secret` | textfield | yes | OAuth access token secret |
| `nb_of_posts` | select 1–10 | yes | default 1 |
| `text_length` | number (min 0) | no | truncate chars; 0 = no limit |

### `instagram_social_network` (`InstagramSocialNetwork::settingsForm()`)

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `account_to_retrieve` | textfield | yes | Instagram account id |
| `nb_of_posts` | select 1–12 | yes | default 1 |
| `text_length` | number (min 0) | no | truncate chars; 0 = no limit |

Credentials/settings are stored as ordinary configuration (third-party settings on the config entity),
so they are written to exported config like any other config value. The forms use plain textfields.

## Set from code / drush

There is no Drush command; use `drush php:eval` or a deploy hook:

```php
$storage = \Drupal::entityTypeManager()->getStorage('social_network_config');
$entity = $storage->create([
  'id' => 'company_twitter',
  'label' => 'Company Twitter',
  'widget' => 'twitter_social_network',
]);
$entity->setThirdPartySetting('social_wall', 'sn_config', [
  'company_twitter' => [
    'account_name' => 'drupal',
    'consumer_key' => getenv('TW_CONSUMER_KEY'),
    'consumer_secret' => getenv('TW_CONSUMER_SECRET'),
    'access_token' => getenv('TW_ACCESS_TOKEN'),
    'access_token_secret' => getenv('TW_ACCESS_TOKEN_SECRET'),
    'nb_of_posts' => 5,
    'text_length' => 0,
  ],
]);
$entity->save();
```

After creating networks, place the **Social wall block** and tick which of them to display — see
[../blocks/social-wall-block.md](../blocks/social-wall-block.md).

# Configure purge_queuer_url

There is **no dedicated settings route**. The form (`ConfigurationForm`,
`getFormId()` = `purge_queuer_url.configuration_form`, extends
`purge_ui\Form\QueuerConfigFormBase`) is opened from **Purge UI's queuer
configuration dialog** for the `urlpath` queuer (Configuration → Development → Performance →
Purge, then configure the "URLs queuer"). That UI is provided by `purge_ui` and gated by its
`administer purge` permission. All state is stored in the config object
`purge_queuer_url.settings`.

## Config object `purge_queuer_url.settings`

| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `queue_paths` | boolean | `false` | Store/queue **paths** (`news/1?page=2`, leading `/` stripped) instead of fully-qualified URLs. When true the host/scheme options are ignored. |
| `host_override` | boolean | `false` | Replace the request host with a fixed one. Losing collected domains, but you control the queued host. Only applies when `queue_paths` is false. |
| `host` | string | `''` | The host used when `host_override` is true. |
| `scheme_override` | boolean | `false` | Force a single scheme for all queued URLs instead of the visitor's scheme. Only applies when `queue_paths` is false. |
| `scheme` | string | `'http'` | The scheme used when `scheme_override` is true. Form allows `http` or `https`. |
| `blacklist` | sequence of strings | see below | Substrings that, if found anywhere in the generated URL/path, prevent that response from being registered. |

Default `blacklist` (from `config/install/purge_queuer_url.settings.yml`):
`/admin/`, `/user/login?destination=`, `/user/register?destination=`, `/entity-browser`,
`txn=`, `gclid=`, `dclid=`, `utm_source=`, `utm_campaign=`, `utm_content=`, `utm_medium=`,
`/edit`, `/delete`, `translations`.

The blacklist is a plain substring match (`strpos`), applied to the generated URL/path — use it
to keep crawler-generated query parameters and non-cacheable admin paths out of the registry.
The form has an AJAX "Add" button to append blacklist rows; empty rows are dropped on validate.

## Clear traffic history

The form has a **"Clear traffic history"** danger button whose submit handler
(`submitFormClear`) calls `purge_queuer_url.registry`'s `clear()`, wiping both DB tables. After
that the site must receive fresh traffic before it queues anything again.

Saving the form (`submitFormSuccess`) writes all keys, then **deletes the `render` cache bin**
(`Cache::getBins()` → `render`) because already-cached page responses are never re-evaluated by
the middleware; wiping render cache lets blacklist changes take effect. It does **not** clear
Drupal's page cache — do that separately (`drush cr`) if you changed collection rules.

## Set via drush / PHP

```bash
# Queue bare paths instead of full URLs:
drush cset purge_queuer_url.settings queue_paths 1 -y

# Force a canonical host + https on all queued URLs:
drush cset purge_queuer_url.settings host_override 1 -y
drush cset purge_queuer_url.settings host 'www.example.com' -y
drush cset purge_queuer_url.settings scheme_override 1 -y
drush cset purge_queuer_url.settings scheme 'https' -y
```

```php
// Append a blacklist substring in code.
$config = \Drupal::configFactory()->getEditable('purge_queuer_url.settings');
$blacklist = $config->get('blacklist');
$blacklist[] = 'ref=';
$config->set('blacklist', $blacklist)->save();
```

`blacklist` is a config `sequence` of `string`; keep it a plain indexed list. Schema lives in
`config/schema/purge_queuer_url.schema.yml` (`purge_queuer_url.settings`, type `config_object`).

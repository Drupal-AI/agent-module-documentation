# Configure — `vwo.settings`

**Configure route** `vwo.settings` → `/admin/config/system/vwo` (permission `administer vwo`).
Three routed forms:

| Route | Path | Form | Purpose |
|---|---|---|---|
| `vwo.settings` | `/admin/config/system/vwo` | `Form\Settings` | Account ID + loading options. |
| `vwo.settings.visibility` | `/admin/config/system/vwo/visibility` | `Form\Visibility` | Page/role/content-type/user visibility rules. |
| `vwo.settings.vwoid` | `/admin/config/system/vwo/vwoid` | `Form\ExtractID` | Paste a Smart Code; regex-extracts the Account ID. |

## Config object `vwo.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `id` | integer (nullable) | `null` | **VWO Account ID.** When null, no snippet is added at all. |
| `is_wingify_account` | bool (nullable) | `null` | Set by `vwo.account_info` after querying the VWO API; picks VWO vs Wingify host. |
| `coll_url` | string (nullable) | `null` | Collection URL fetched from the API. |
| `filter.enabled` | string | `'on'` | Master visibility filter toggle (`'on'` = apply the rules below). |
| `filter.userconfig` | string | `'nocontrol'` | Per-user opt control: `nocontrol` / `optin` / `optout` (adds a checkbox to the user form, stored in `user.data`). |
| `filter.nodetypes` | sequence | `{}` | Content-type machine names the snippet is limited to (empty = no node-type restriction). |
| `filter.page.type` | string | `'listexclude'` | Path mode: `listinclude` (only these paths), `listexclude` (all except these), `usephp` (evaluate PHP — needs the php module). |
| `filter.page.list` | string (nullable) | `null` | Newline path list compared against path and alias. |
| `filter.roles` | sequence | `{}` | Role machine names the snippet is limited to (empty = all roles). |
| `loading.type` | string | `'async'` | `async` (preconnect + inline async Smart Code) or `sync` (`<script src>` to `lib/<id>.js`). |
| `loading.timeout.settings` | integer | `2000` | Async settings/anti-flicker timeout (ms). |
| `loading.timeout.library` | integer | `2500` | Library load timeout (ms). |
| `loading.usejquery` | string | `'import'` | jQuery handling flag. |

## When is the snippet added?

`vwo_page_attachments()` adds the Smart Code only when `id` is not null **and** the visibility
filter permits the current request (master toggle → per-user opt → content type → role → path). It
adds cache contexts (`user`, `user.roles`, `url.path`) matching whichever filters are active.

## Read / set via drush

```bash
drush config:get vwo.settings id
drush config:set vwo.settings id 654321 -y
drush config:set vwo.settings loading.type sync -y
drush config:set vwo.settings filter.page.type listinclude -y
```

Or programmatically:

```php
$c = \Drupal::configFactory()->getEditable('vwo.settings');
$c->set('id', 654321)->set('loading.type', 'sync')->save();
```

The **Extract Account ID** form is a convenience: paste the full VWO Smart Code and it
`preg_match`es the numeric Account ID out of it and stores it in `id`.

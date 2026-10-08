# Permissions

Defined in `ckeditor_mentions.permissions.yml`.

| Permission | Title | Controls |
|---|---|---|
| `use inline mentions` | Use ckeditor mentions (protects the AJAX callback path) | (1) the sole access requirement on route `ckeditor_mentions.ajax_callback` (`_permission: 'use inline mentions'`); (2) whether the CKEditor 5 mention feeds are emitted for the current user — `Plugin\CKEditor5Plugin\Mentions::getDynamicPluginConfig()` returns `[]` if the account lacks it. |

Grant it to roles that author content in mention-enabled formats. A user without it sees no
autocomplete and receives 403 from the callback route.

Set via drush:
```
drush role:perm:add editor 'use inline mentions'
```

No other permissions are defined. The submodules (`ckeditor_mentions_entity`,
`ckeditor_mentions_realname`) define no permissions of their own.

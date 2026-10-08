# Permissions

Defined in `sitemap.permissions.yml`.

| Permission | Gates | Restricted |
|---|---|---|
| `access sitemap` | View the published sitemap page. | no |
| `administer sitemap` | The settings form / what the sitemap displays (route `sitemap.settings`). | no |
| `set front page rss link on sitemap` | Configure the front-page RSS link, including linking to external sites and bypassing access checks on internal paths. | yes |
| `show disabled menu items on sitemap` | Whether disabled menu links are shown to sitemap viewers (would otherwise need 'Administer menus and menu links'). | yes |
| `show unpublished taxonomy terms on sitemap` | Whether unpublished terms are shown to sitemap viewers (would otherwise need 'Administer vocabularies and terms'). | yes |

The three restricted permissions expose information normally gated behind admin
permissions — grant only to trusted roles. Grant via drush:
```
drush role:perm:add authenticated 'access sitemap'
```

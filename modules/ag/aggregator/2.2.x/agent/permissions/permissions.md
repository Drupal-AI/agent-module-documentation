# Aggregator permissions

From `aggregator.permissions.yml` — two permissions:

| Permission | Title | Gates |
|---|---|---|
| `access news feeds` | View news feeds | The public listing `/aggregator` (`aggregator.page_last`) and viewing feeds/items. |
| `administer news feeds` | Administer news feeds | All admin routes: overview, settings, add feed, OPML import, manual refresh, delete items, and feed edit/delete forms. Marked `restrict access: TRUE`. |

Grant with Drush:

```bash
drush role:perm:add anonymous 'access news feeds'
drush role:perm:add content_editor 'administer news feeds'
```

## Security caution (from README)

`administer news feeds` lets a user create feeds pointing at arbitrary URLs. Because the
site fetches those URLs server-side, a feed can be used for low-threat **SSRF** — scanning
`localhost` ports or reaching hosts behind the same firewall (e.g. an intranet RSS feed,
which would then be exposed publicly). The maintainers judged this not severe enough to
restrict fetch URLs, but grant `administer news feeds` **only to trusted roles**.

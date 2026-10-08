# AdSense permissions

Defined in `adsense.permissions.yml` (three).

| Permission | Gates |
|---|---|
| `administer adsense` | All AdSense settings forms (`/admin/config/services/adsense`, managed, cse) and the oldcode submodule's forms. |
| `hide adsense` | A role with this permission **does not see ads** (ad units render nothing for them). Useful for editors/subscribers. |
| `show adsense placeholders` | A role with this permission sees **placeholder boxes** where ads would be (layout/QA), instead of real ads. |

The last two are read in `AdsenseAdBase::display()` (via `currentUser`) to decide whether to output
the real ad, a placeholder, or nothing — independent of the global `adsense_placeholder` /
`adsense_disable` switches in `adsense.settings`.

Assign with drush, e.g.:

```bash
drush role:perm:add editor 'hide adsense'
drush role:perm:add content_editor 'show adsense placeholders'
```

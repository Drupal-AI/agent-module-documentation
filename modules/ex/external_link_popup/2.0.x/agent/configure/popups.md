<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure pop-ups & global settings

Two config surfaces: per-pop-up **`external_link_popup` config entities**, and one global
**`external_link_popup.settings`** object. Both require the permission
`administer external link popup`.

## Routes

| Route | Path | Purpose |
|---|---|---|
| `external_link_popup.settings` (the `configure` route) | `/admin/config/content/external_link_popup/settings` | Global settings form |
| `entity.external_link_popup.collection` | `/admin/config/content/external_link_popup` | List / add pop-ups |
| `entity.external_link_popup.add_form` / `.edit_form` / `.delete_form` | `/admin/config/content/external_link_popup/...` | CRUD |
| `entity.external_link_popup.enable` / `.disable` | `.../{id}/enable` `.../{id}/disable` | Toggle status |

## The pop-up entity (`external_link_popup`)

`config_export` fields (config prefix `external_link_popup.external_link_popup.<id>`):

| Field | Type | Meaning |
|---|---|---|
| `id` | string | machine name |
| `name` | label | admin label |
| `status` | bool | enabled/disabled |
| `weight` | int | check order (lower first) |
| `close` | bool | show the close (X) icon |
| `title` | label | dialog title |
| `body` | text_format | `{value, format}` dialog body |
| `labelyes` | label | "Yes"/continue button text |
| `labelno` | label | "No"/cancel button text |
| `domains` | string | newline-separated domains this pop-up applies to |
| `new_tab` | bool | open links with no `target` in a new tab after confirm |

**Domain matching**: `domains` is newline-separated; `domain.com` also matches
`*.domain.com`; `*` matches every external link. Pop-ups are sorted by `weight` and the
**first** whose domain condition matches is shown (so a `*` pop-up above others hides them).

The shipped default pop-up is `external_link_popup.external_link_popup.default` (id `default`,
domains `*`, title "You Are Now Leaving This Site"). Do not delete it if you rely on a fallback.

### Create one in code / drush

```php
\Drupal\external_link_popup\Entity\ExternalLinkPopup::create([
  'id' => 'partners', 'name' => 'Partners', 'status' => TRUE, 'weight' => 0,
  'close' => TRUE, 'title' => 'Leaving for a partner site',
  'body' => ['value' => 'Continue to the external site?', 'format' => 'plain_text'],
  'labelyes' => 'Continue', 'labelno' => 'Stay', 'domains' => "example.com\nexample.org",
  'new_tab' => TRUE,
])->save();
```

## Global settings (`external_link_popup.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `whitelist` | string | `''` | Newline-separated **trusted** domains — links to these show **no** pop-up (matches subdomains too). |
| `show_admin` | bool | `false` | Also show pop-ups on admin routes. |
| `width` | `{value:int, units:string}` | `{85, '%'}` | Default dialog width. |

```bash
drush cset external_link_popup.settings whitelist "trusted.com
partner.org" -y
drush cget external_link_popup.settings
```

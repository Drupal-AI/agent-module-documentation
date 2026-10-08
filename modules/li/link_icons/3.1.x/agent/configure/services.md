# Link icon services — the `link_icon_service` config entity (configure)

Which domains get which icon is stored as **`link_icon_service`** config entities. Each holds one or
more trailing hostnames plus the Font Awesome icon to render for them. Managed through a standard
config-entity admin UI; nothing here is per-request user input.

## Admin UI & routes

Collection page: **`/admin/config/search/link_icon_service`** (menu link under *Configuration »
Search and metadata*), route `entity.link_icon_service.collection`. Route provider is core
`AdminHtmlRouteProvider`; the entity's `admin_permission` is **`administer link icon services`**.

| Route | Path | Access requirement |
|---|---|---|
| `entity.link_icon_service.collection` | `/admin/config/search/link_icon_service` | `_permission: administer link icon services` |
| `entity.link_icon_service.add_form` | `/admin/config/search/link_icon_service/add` | `_entity_create_access: link_icon_service` |
| `entity.link_icon_service.edit_form` | `/admin/config/search/link_icon_service/{link_icon_service}/edit` | `_entity_access: link_icon_service.update` |
| `entity.link_icon_service.delete_form` | `/admin/config/search/link_icon_service/{link_icon_service}/delete` | `_entity_access: link_icon_service.delete` |

The create/update/delete access checks all resolve to the same `administer link icon services`
permission via the config-entity default access handler. `canonical` is declared but core redirects it
to the edit form (no separate route is built).

## Fields (config_export / schema `link_icons.link_icon_service.*`)

| Key | Form element | Meaning |
|---|---|---|
| `id` | `machine_name` | Entity id; also the default HTML `class` when `class` is empty. |
| `label` | textfield (required) | Human name. |
| `hostnames` | repeatable textfields (first required) | Trailing hostname(s) to match, e.g. `google.com`. Stored as a sequence; matched against the link's last 2–5 host labels. |
| `class` | textfield | HTML class added to the `<i>` (defaults to `id`). |
| `icon` | textfield (required) | Main FA icon id, no `fa-` prefix (e.g. `google`). |
| `icon_style` | select (required) | FA style: `solid`, `regular`, `light`, `thin`, `duotone*`, `sharp*`, `brand`. |
| `icon_square` | textfield | Optional square variant id (used when `shaped` prefers squared). |
| `icon_circle` | textfield | Optional circular variant id. |
| `color` | textfield | CSS colour emitted as inline `style="color: …"` (e.g. `black`, `#000000`, `rgb(...)`). |

Form class `Form\LinkIconServiceForm` (add/edit, with AJAX add/remove hostname buttons);
`Form\LinkIconServiceFormDelete` (confirm delete). List builder
`Config\Entity\LinkIconServiceListBuilder` renders a per-row live preview `<i>` of each service.

## Programmatic create

```php
\Drupal\link_icons\Entity\LinkIconService::create([
  'id' => 'example',
  'label' => 'Example',
  'hostnames' => ['example.com', 'example.org'],
  'class' => 'example',
  'icon' => 'globe',
  'icon_style' => 'solid',
  'icon_square' => '',
  'icon_circle' => '',
  'color' => '#336699',
])->save();
```

## Provided services

Two schemes are hardcoded in the render helper and need no entity: `mailto:` (envelope) and `tel:`
(phone). An unmatched http(s) host falls back to a generic navy `globe`. Everything else comes from
entities — the base module ships **none**; enable the **`link_icons_brands`** submodule to import ~100
brand services (`config/optional/link_icons.link_icon_service.*.yml`, e.g. `facebook`, `x`, `github`).
That submodule is config-only and also carries `hook_update_N` importers (`_link_icons_brands_
read_services_config()`) that (re)write its shipped configs on update; overriding an entity locally and
then running its updates can restore the shipped values for that service.

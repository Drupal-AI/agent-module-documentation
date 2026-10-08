<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — enable domain access & choose behavior

## Two admin forms

| Route | Path | Access | Purpose |
|---|---|---|---|
| `domain_entity.ui` (`DomainEntityUi`) | `/admin/config/domain/entities` | `_permission: administer domains` | A `tableselect` of every fieldable entity type; tick to **enable/disable** domain access on a type. Also the global `bypass_access_conditions` checkbox. |
| `domain_entity.settings` (`DomainEntitySettings`) | `/admin/config/domain/entities/{entity_type_id}` | `_custom_access` = `administer domains` **and** the type is already enabled | Per-**bundle** settings for one enabled entity type: assignment behavior, default domains, excluded routes. |

## Enabling / disabling an entity type

Submitting the UI form compares the ticked types against the currently enabled ones and calls
`DomainEntityMapper::createFieldStorage($type)` for newly ticked types and
`deleteFieldStorage($type)` for unticked ones. "Enabled" therefore means **the
`domain_access` field storage exists** for that entity type (`getEnabledEntityTypes()`).

## Per-bundle behavior (`domain_entity.settings` form)

For each bundle you choose a **behavior**:

- `auto` (`DomainEntityMapper::BEHAVIOR_AUTO`) — a newly created entity is automatically
  affiliated to the current domain; no widget is shown on the entity form.
- `user` (`DomainEntityMapper::BEHAVIOR_USER`) — an `options_buttons` widget lets the editor
  pick the affiliate domain(s), with a default value.

You can also set default `domains` and a list of `exclude_routes` (routes exempt from
domain-source URL rewriting). These are saved on the bundle's `domain_access`
**field config** under `third_party_settings.domain_entity`:

```yaml
third_party_settings:
  domain_entity:
    domains: [DOMAIN_ID, ...]
    behavior: auto        # or user
    exclude_routes: [ROUTE_NAME, ...]
```

Schema key: `field.field.*.*.*.third_party.domain_entity`.

## Global config object

`domain_entity.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `bypass_access_conditions` | boolean | `false` | When `true`, the module's query alter / access filtering is disabled (troubleshooting) — entities then behave as accessible on all domains. |

```bash
drush cget domain_entity.settings
drush cset -y domain_entity.settings bypass_access_conditions true
```

## Notes

- Enabling a type does **not** add the field to bundles automatically for every case — the
  per-type settings form (and `DomainEntityMapper::addDomainField()`) create the bundle field
  with the `options_buttons` widget and remove it from the default view display.
- Existing entities with **no** domain value are treated as affiliated to **all** domains, so
  migrating content without assigning a domain can make it broadly visible (or, once rules are
  active, inaccessible if you expected a specific domain) — assign domains deliberately.

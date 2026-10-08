<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Access (adva) — agent index

An entity-agnostic access-control API generalizing core's node-grant system to any entity type
via **Access Provider** and **Access Consumer** plugins. Config UI `/admin/config/people/adva`
(route `adva.settings`, permission `administer adva`). Grants live in the `adva_access` table.

- **Settings form, enabling providers per consumer, rebuild flow, config entity, drush cset** →
  [configure/settings.md](configure/settings.md)
- **The two plugin types (Provider/Consumer, basic vs overriding), how to implement each,
  the built-in `anonymous` provider** → [plugins/access-plugins.md](plugins/access-plugins.md)
- **Grant storage, the access handler, and `hook_query_alter` filtering** →
  [api/access-model.md](api/access-model.md)
- **Permissions (`administer adva`, `bypass adva access`, per-type bypass)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Entity CRUD hooks + node-grant bridge that adva relies on** → [hooks/hooks.md](hooks/hooks.md)

Submodules (own docs):
- `adva_na` (node access) → [../../modules/adva_na/1.2.x/agent/start.md](../../modules/adva_na/1.2.x/agent/start.md)
- `adva_media` (media access) → [../../modules/adva_media/1.2.x/agent/start.md](../../modules/adva_media/1.2.x/agent/start.md)
- `adva_example_provider` — a `hidden: TRUE` demo Access Provider (not documented separately;
  read `modules/adva_example_provider/src/Plugin/adva/AccessProvider/ExampleAccessProvider.php`).

Key facts:
- **Two consumer kinds:** *basic* (`AccessConsumer`) only exposes provider config; *overriding*
  (`OverridingAccessConsumer`) also swaps the entity's access handler to
  `AdvancedAccessEntityAccessControlHandler` and stores/queries `adva_access` records.
  `adva_na` uses a **basic** consumer (bridges to core node grants via hooks);
  `adva_media` uses an **overriding** consumer.
- **Providers** implement `getAccessGrants($op,$account)` (realm→[gids] the user holds) and
  `getAccessRecords($entity)` (realm/gid + grant_view/update/delete rows for the entity).
- Records auto-rebuild on entity insert/update/delete; full rebuild is queued on config save
  (queue `adva_rebuild_access_records:<entity_type>`).

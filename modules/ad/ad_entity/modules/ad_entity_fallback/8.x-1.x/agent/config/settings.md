<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fallback configuration & swap mechanism

## Install & enable

```bash
drush en ad_entity_fallback -y
```

Requires `ad_entity`. Install runs `ad_entity_fallback_install()`, which sets the module weight to
**1100** (so its `hook_ENTITY_TYPE_view_alter()` runs after other alterations) and clears
ad_entity's cached plugin definitions. There are no permissions and no dedicated route; the
`configure` link is the shared Advertising entity list `entity.ad_entity.collection`
(`/admin/structure/ad_entity`).

## Per-entity fallback setting

Added by `_ad_entity_fallback_entity_form()` in `ad_entity_fallback.admin.inc`
(via `hook_form_ad_entity_form_alter()`). On any Advertising entity's edit form a **Fallback**
fieldset appears with a single **Advertising entity** select (`third_party_settings.ad_entity_fallback.ad_entity_id`):

- Options are all existing Advertising entities **except** the current one and except any entity
  that itself already has a fallback configured (prevents chaining loops one level).
- Empty value = no fallback. Stored as a string entity id in the entity's third-party settings.
- Schema: `config/schema/ad_entity_fallback.schema.yml` →
  `ad_entity.ad_entity.*.third_party.ad_entity_fallback.ad_entity_id` (string).

## Global timeout setting

Added by `_ad_entity_fallback_settings_form()` (via `hook_form_ad_entity_settings_alter()`) to the
global settings form (`admin/structure/ad_entity/global-settings`), stored on config object
**`ad_entity.settings`** under key `fallback.timeout`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `fallback.timeout` | integer | `1000` | Microseconds to wait after ad containers are collected before loading a fallback for an empty original. Form enforces `#min 100`; the submit handler (`_ad_entity_fallback_settings_form_submit`) also clamps anything `< 100` back to the default 1000. |

Schema for this key is registered dynamically in `hook_config_schema_info_alter()` (not in a schema
file). `hook_page_attachments()` copies the value to
`drupalSettings.ad_entity.fallback_timeout` (default 1000 when unset). Uninstall clears the
`fallback` key from `ad_entity.settings`.

## How the swap works

Render side — `ad_entity_fallback_ad_entity_view_alter(array &$build, AdEntityInterface $ad_entity)`:

1. If the entity has no `ad_entity_fallback.ad_entity_id`, return unchanged.
2. Load and **clone** the referenced fallback entity (clone because it is mutated and may be reused
   elsewhere).
3. Generate a correlation id `Crypt::randomBytesBase64(4)`; set
   `$ad_entity->_attributes['data-fallback-container'] = $id` on the original and
   `$fallback_entity->_attributes['data-fallback-container-for'] = $id` on the fallback.
4. Set `disable_initialization = TRUE` on the fallback and render it with the same `#variant`
   through the `ad_entity` view builder; attach `ad_entity_fallback/view`.
5. Replace `$build` with `[$build, $fallback_view]` so both containers render into the page.

Client side — `js/fallback.view.js` (library `ad_entity_fallback/view`, depends on `ad_entity/view`;
`hook_library_info_alter()` also forces it to load right before ad_entity's `viewready`):

- On `window` event `adEntity:collected`, schedule `processFallbacks` after `fallback_timeout` ms.
- `correlateContainers()` matches each original with its fallback via the correlation attributes.
- For a correlated pair, if the original is not `initialized`, is `inScope`, and not already
  `fallbackProcessed`, and the fallback is in scope and not initialized: remove
  `initialization-disabled` from the fallback, mark original disabled + `fallbackProcessed`, then
  call `ad_entity.restrictAndInitialize()` on the fallback container.

Net effect: the fallback ad is initialized only when the original slot did not fill within the
timeout.

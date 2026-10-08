<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ad — settings, placements, the ad block, permissions

## Install / enable

`drush en ad` provides only the framework. Enable a provider (`ad_content`) and usually a tracker
(`ad_track`) to serve real ads. `ad_install()` (`ad.install`) grants **`view ads`** to the
`anonymous` and `authenticated` roles so ads are visible to visitors by default.

## Config object `ad.settings`

Schema `ad.settings` in `config/schema/ad.schema.yml`; install defaults in
`config/install/ad.settings.yml`:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `trackers` | sequence(string) | `{}` | Map of **bucket id → tracker id** chosen per source. |
| `advertisement_indicator` | label | `Advertisement` | Small-print label added to ad blocks (ad-disclosure laws). |
| `hide_empty_blocks` | boolean | `TRUE` | Hide an ad block (incl. placeholder) when no ad matches. |

Edited by `SettingsForm` (`src/Form/SettingsForm.php`, form id `ad_settings_form`) at route
**`ad.settings`** → `/admin/config/content/ad`, permission `administer ad settings`. The form lists
one tracker `<select>` per registered bucket (options from `ad.tracker_factory->getList()`), plus
the indicator textfield and the hide-empty checkbox. If no bucket or no non-null tracker exists, it
shows a prompt to enable a source + a tracker.

## Placement config entity `ad_placement`

`src/Entity/AdPlacement.php` — a `ConfigEntityBase` (`config_prefix: ad_placement`), exported keys
`id`, `label`, `description`, `status`. Handlers: `AdPlacementListBuilder`, forms
`AdPlacementForm` (add/edit) and `AdPlacementDeleteForm`. `admin_permission: administer ad settings`.

Nine presets installed from `config/install/ad.ad_placement.*.yml`: `billboard`,
`fullsize_banner`, `halfsize_banner`, `large_leaderboard`, `leaderboard` (728×90),
`medium_rectangle`, `mobile_leaderboard`, `rectangle`, `skyscraper`. (The pixel size lives only in
the human label; the entity stores no width/height field.)

### Placement routes (`ad.routing.yml`, all `administer ad placements`)

- `entity.ad_placement.collection` — `/admin/config/content/ad/ad-placements`
- `entity.ad_placement.add_form` / `.edit_form` / `.delete_form`
- `entity.ad_placement.enable` / `.disable` — controller `AdPlacementController::performOperation`,
  guarded by **`_csrf_token: TRUE`**; calls `$entity->enable()/disable()->save()` and redirects.
- `entity.ad_placement.duplicate_form` — `AdPlacementController::duplicate` clones the entity
  (label prefixed "Duplicate of …") and returns the add form.

`AdPlacementManager` (service `ad.placement_manager`) offers `get($id)`, `getAll()`, `getList()`
(id → label). Helper `ad_get_placements_list()` is the `allowed_values_function` for the ad
content `placement` field.

## The Advertisement slot block (`ad`)

`src/Plugin/Block/AdSlot.php` — `#[Block(id: "ad", admin_label: "Advertisement slot",
category: "Advertisement")]`. Block settings schema `block.settings.ad`:

- `bucket_ids` — checkboxes, which buckets this slot may draw from.
- `placement_id` — select, which placement to serve.

`build()`: filters selected bucket ids, picks one at **random** (`rand()`), loads it via
`ad.bucket_factory->get()`, verifies the placement exists and is enabled, and — unless the bucket
`isEmpty()` while `hide_empty_blocks` is on — returns `bucket->buildPlaceholder($placementId)` (an
AJAX placeholder, so impression counting happens on view, not on cache render). `blockAccess()`
requires permission **`view ads`**.

## Permissions (`ad.permissions.yml`)

`administer ads`, `administer ad settings`, `administer ad placements` (all `restrict access: true`),
and `view ads` (granted to anon + authenticated on install). Additional content/type permissions
come from the `ad_content` submodule.

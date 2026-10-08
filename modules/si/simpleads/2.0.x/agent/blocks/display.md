# Displaying ads

There are four ways to place a group of ads. All of them render the `simpleads_advertisement` theme (an empty
`<div class="simpleads" data-group="…" …>` placeholder) and let the JS libraries fetch + rotate the actual ads
over REST. Rotation modes: `loop` (Slick autoplay carousel), `multiple` (N random ads), `refresh` (one random
ad per page load). Ads can also appear in a modal (jQuery-modal) with page-visit / delay gating.

## 1. Block plugin `simpleads` (`Plugin\Block\SimpleAdsBlock`)

Admin-label "SimpleAds". Place at Block layout; block settings (`blockForm`):

| Setting | Purpose |
|---|---|
| `group` (required) | Which active group to show (options from active `simpleads_group` entities). |
| `rotation` | `loop` / `multiple` / `refresh`. |
| `rotation_speed`, `rotation_pauseonhover`, `rotation_impressions` | Loop tuning; count an impression once per rotation. |
| `multiple_random_limit` | 1–25 ads for `multiple` mode. |
| `show_in_modal`, `modal_delay_type`, `modal_delay`, `modal_page_visits`, `modal_visits_timeout` | Modal behaviour. |
| `node_ref_field`, `simpleads_ref_field` | Optional: only show ads whose reference field overlaps the current node's reference field. |

`build()` sets cache tags `['simpleads_group_<gid>', 'simpleads_group']` + context `url.query_args`.

## 2. Text filter `simpleads` (`Plugin\Filter\SimpleAdsFilter`)

Filter id `simpleads` (transform-reversible). Turns a `<simpleads>` element in body text into an ad block.
Reads attributes `data-group`, `data-rotation-type`, `data-random-limit`, `data-impressions`, then renders
the `simpleads_advertisement` placeholder in its place. Enable the filter on a text format to use it.

## 3. CKEditor 5 plugin `simpleads_SimpleAds` (`simpleads.ckeditor5.yml`)

Adds a "SimpleAds" toolbar button (`Plugin\CKEditor5Plugin\SimpleAds`) that inserts the `<simpleads …>`
element the filter consumes. Allowed elements: `<simpleads data-group data-rotation-type data-random-limit
data-impressions>`. The insert dialog is `simpleads.ckeditor5_dialog` (`/simpleads/dialog/{uuid}`, form
`Form\CKEditorDialogForm`, permission `use text format advanced`); live preview is `simpleads.ckeditor5_preview`
(`/simpleads/preview/{editor}`, access = `use text format <that editor's format>`).

## 4. Views style `simpleads` (`Plugin\views\style\SimpleAds`)

A Views style plugin (`@ViewsStyle id = "simpleads"`) that turns a View of ads into a rotating/modal ad unit
with the same rotation + modal options as the block. The View id + display id are posted to the
`simpleads_views` REST resource by `simpleads.views.js`. Module also provides Views filters
`simpleads_group` and `simpleads_campaign` (and Views data for all three entity types), and ships default
views `simpleads`, `simpleads_advertisement`, `simpleads_campaign`, `simpleads_group`.

## Reference field placement

Attach a `simpleads_reference` field (see [../fields/fields.md](../fields/fields.md)) to any entity to hand-pick
ads; its formatter renders them via the `simpleads_reference` REST resource. The block's reference-field option
above instead matches ads to the current node by comparing two entity-reference fields.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pager Block — configuration & mechanism

Plugin: `Drupal\pager\Plugin\Block\PagerBlock` — `@Block(id = "pager", admin_label = "Pager Block")`.
Implements `ContainerFactoryPluginInterface`; injects `current_route_match`, `entity_type.manager`,
`pager.storage`, `image.factory`.

## Placement & configuration
There is no dedicated settings route. Configure per-instance on the standard block placement form
(`/admin/structure/block` → place "Pager Block"). Fields from `blockForm()`:

| Form key    | Label          | Type       | Required | Notes |
|-------------|----------------|------------|----------|-------|
| `txt_prev`  | Previous Text  | textfield  | no       | Label under the previous link. Default "Previous". |
| `txt_next`  | Next Text (form title literally reads "Next Test") | textfield | no | Label under the next link. Default "Next". |
| `field`     | Image Field    | select     | yes      | Image field machine name; options from image fields on node entities. |
| `style`     | Image Style    | select     | yes      | Image style machine name; options from all image styles. |
| `theme`     | Theme          | select     | yes      | `pager_block` (centred) or `pager_wings` (side tabs). |
| `types`     | Content Types  | checkboxes | yes      | Node types included in the sequence. |
| `terms`     | Taxonomy Terms | checkboxes | yes      | Terms whose tagged nodes are included. Labels are `Vocabulary: Term`. |
| `interm`    | Maintain Term  | checkbox   | no       | If on, neighbour must share the CURRENT node's term; if off, any selected term qualifies. |
| `direction` | Direction      | radios     | yes      | `forward` (created oldest→newest) or `backward` (reversed; the built array is `array_reverse`d and classes swapped). |
| `behavior`  | End Behavior   | radios     | yes      | `loop` / `single` / `current` (see below). |

`defaultConfiguration()`: `behavior=loop`, `field=''`, `style='large'`, `terms=[]`, `txt_next='Next'`,
`txt_prev='Previous'`, `types=[]`. Note `theme`, `interm`, `direction` have no default and are required.

`blockSubmit()` stores each value; `types`/`terms` are passed through `getOptionValues()` which flips,
drops the unchecked `0` entries, and ksorts. `blockValidate()` is empty.

## Build & query mechanism (`build()`)
1. Get the `node` route parameter; return `[]` if absent.
2. `getTid($node)`: return `0` (→ empty block) unless the node's type is in `types` AND the node is
   tagged with one of the configured `terms` (`PagerStorage::selectTid`).
3. `getPrevious()` / `getNext()` pick the neighbour by `created`:
   - `interm` on → search within `[$currentTid]`; off → search within all configured `terms`.
   - Previous = latest node with `created < current` (`selectPrev`, ORDER BY created DESC LIMIT 1).
   - Next = earliest node with `created > current` (`selectNext`, ORDER BY created ASC LIMIT 1).
   - All queries also filter `n.type IN (types)` and `n.status = 1` (published only).
4. **End Behavior** when no neighbour is found on that side:
   - `loop` → previous falls back to the newest overall (`selectLast`), next to the oldest (`selectFirst`).
   - `current` → link points to the current node itself.
   - `single` → no fallback; that side is simply omitted.
5. `backward` direction reverses/relabels the two items.
6. Each neighbour becomes a nav object via `getNavItem()`: `alt` (title run through `filterAlt()`
   regex scrub), `class` (`pager-prev-node`/`pager-next-node`), `href` (`Url::fromRoute('entity.node.canonical', absolute)`),
   `label` (`Html::escape`), `src` (image-style URL of the chosen field's file), `title`
   (`Html::escape`), `width`/`height` (from the derived image).
7. Render array: `#theme` = the configured theme, `#data` = nav objects, `#cache max-age 0`,
   `#attached` library `pager/drupal.pager-links`.

## Runtime requirements / gotchas
- The chosen **Image Field must exist on the neighbour node**; `getImgUrl`/`getImgProperty` return
  '' if `hasField()` is false, so cross-type pagination works best when all types share the field.
- Requires the core **image** module (used for `ImageStyle`) though `.info.yml` omits it.
- Sequence is chronological by `created` only — reordering content means editing creation times.
- Block is uncacheable (`max-age 0`); expect it to run its queries on every node view.

# Configure — attach a view to an entity

EVA has **no admin settings form** (`configure` is null). All configuration lives on the view
display itself, plus the entity's "Manage display" page. Requires the core Views module.

## Add an EVA display to a view

1. Edit a view at `/admin/structure/views/view/{view}`.
2. Under **Displays → + Add**, choose **EVA** (the display plugin `entity_view`). The display
   has no path or block — it renders through the entity it is attached to.
3. In the display's **Entity content settings** section (weight -10, second column) configure:

| Section | Option key | Meaning |
|---|---|---|
| Entity type | `entity_type` | The content entity type this display attaches to (radios of `ContentEntityType`s; **required**). Changing it resets `bundles`. |
| Bundles | `bundles` | Checkboxes of bundles. If **none** selected, attaches to **all** bundles of the entity type. |
| Arguments | `argument_mode` | How the view's contextual filter is populated: `None`, `id`, or `token`. |
| (token) | `default_argument` | Slash-separated token string used when `argument_mode` is `token` (e.g. `[node:author:uid]`). |
| Show title | `show_title` | Render the view's title above the output. |
| Hide output if the view is empty | `eva_hide_empty` | Return nothing when the view has no result/empty text. |
| Disable by default | `disable_by_default` | Add new EVA pseudo-fields to the "disabled" region instead of content. |

The display **must** be attached to an entity type — `validate()` errors otherwise.

## How the entity is passed as an argument

At render time `hook_entity_view()` sets the view's display and populates `$view->args`:

- `argument_mode = 'id'` → `$view->args = [$entity->id()]` (the entity's ID).
- `argument_mode = 'token'` → the `default_argument` token string is replaced against the
  current entity (via the `eva.token_handler` service), split on `/`, and passed as args.
- `argument_mode = 'None'` → no arguments are set.

Add a **contextual filter** (argument handler) to the view that consumes this — e.g. a "Content:
Authored by (uid)" or "User: Uid" filter — so the view filters by the current entity. Install
the optional `drupal/token` module to get a token browser under the arguments form.

## Place it as a pseudo-field on Manage display

Once the EVA display exists, EVA exposes it as an **extra (pseudo) field** via
`hook_entity_extra_field_info()` on the attached entity type/bundles. Go to the entity's
**Manage display** (`/admin/structure/types/manage/{bundle}/display` for nodes) and you will
see a row named after the view (label = the display's title, or the view name). Reorder it among
the real fields, move it between regions, or disable it per view mode — exactly like a field.

- The pseudo-field id is `{view_id}_{display_id}`.
- If the view uses an **exposed filter**, a second pseudo-field `{view_id}_{display_id}_form`
  is offered to render the exposed form separately.
- `disable_by_default` controls whether new EVA fields land in the content region (visible) or
  the disabled region.

## Config storage & lifecycle

- Options are stored on the view display under the `views.display.entity_view` schema
  (`config/schema/eva.display.schema.yml`): `entity_type`, `bundles`, `show_title`,
  `argument_mode`, `default_argument`, `eva_hide_empty`, `disable_by_default`.
- Deleting the last EVA display from a view removes the `eva` module dependency from the view
  config automatically (`hook_ENTITY_TYPE_presave` / `eva_view_presave`).
- On view save, module enable/disable, EVA clears stale pseudo-fields from entity displays and
  invalidates its caches.

**Infinite-loop warning (from README):** if the EVA view renders entities using a view mode, do
not include the EVA field itself in that view mode, or rendering recurses.

# Set visibility on a custom menu link

There is no settings page. You configure visibility **per menu link** on its edit form
(`admin/structure/menu/…/edit` for a custom / `menu_link_content` link). The module adds a
**Visibility** section (vertical tabs), one tab per applicable core Condition plugin — the same
plugins used by block visibility (Request Path, Node Type, User Role, Language, …). Fill in one
or more conditions and save.

## Data model

- Base field `visibility` is added to `menu_link_content` via
  `hook_entity_base_field_info` (`FieldType` id `menu_link_content_visibility`, a `no_ui`
  serialized `StringLongItem`; default widget `menu_link_content_visibility`).
- `MenuLinkContentVisibilityWidget::formElement()` builds a form for every
  `conditionManager->getDefinitionsForContexts($availableContexts)` (skipping `current_theme`,
  `gtag_domain`, `gtag_language`), grouped under a `visibility_tabs` vertical-tabs element.
- `massageFormValues()` submits each condition's config form, drops conditions left at their
  default configuration, and `serialize()`s the remaining `condition_id => config` map into the
  field value (empty → no value stored).

There is **no config schema** shipped for the serialized blob (the field is `no_ui` /
serialized).

## Runtime evaluation

The module replaces the core service `menu.default_tree_manipulators` (see
`menu_link_content_visibility.services.yml`) with
`MenuLinkContentVisibilityLinkTreeManipulator`, subclassing
`DefaultMenuLinkTreeManipulators`. Its `menuLinkCheckAccess($instance)`:

1. Runs `parent::menuLinkCheckAccess()` first (core access still applies).
2. **Short-circuits** (returns the parent result) when the request is a menu-admin route
   (`$request->attributes->get('_menu_admin')`) or the link is not a `MenuLinkContent` — so the
   admin menu UI always shows every link.
3. Loads the link entity by UUID (`entityRepository->loadEntityByUuid('menu_link_content', …)`),
   `unserialize()`s `visibility`; if empty, returns the parent result unchanged.
4. Builds a `ConditionPluginCollection`, applies runtime contexts to context-aware conditions
   (skipping `gtag_domain`/`gtag_language`), and resolves with **AND** (`resolveConditions(..,'and')`).
   - deny → `AccessResult::forbidden()` (with a reason string).
   - missing **context** → `forbidden()->setCacheMaxAge(0)` (cannot cache an unknown result).
   - missing context **value** → `forbidden()` (cacheable; e.g. a node-type condition on a
     non-node route).
5. Merges each condition's cache tags/contexts/max-age into the result and adds the link entity
   as a cache dependency (so edits re-trigger evaluation). Forbidden ⇒ the link is dropped from
   the tree.

## Important caveat — display only, not access control

This only decides whether the **menu link appears in the rendered tree**. It does **not**
protect the destination: a user who knows or guesses the URL can still load the target page
unless that route/entity enforces its own access. Do not rely on a hidden menu link to secure
content — pair it with real route/entity access (permissions, entity access, etc.).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component Audit & Details pages

Source: `cl_devel.routing.yml`, `src/Controller/ComponentAudit.php`,
`src/Controller/ComponentDetails.php`, `cl_devel.api.php`.

## Routes (both admin-only)

| Route id | Path | Controller | Requirement |
|---|---|---|---|
| `cl_devel.registry` | `/admin/config/user-interface/sdc/registry` | `ComponentAudit::audit()` | `_permission: 'administer site configuration'` |
| `cl_devel.component_details` | `/admin/config/user-interface/sdc/registry/{component_id}` | `ComponentDetails::details()` (title `ComponentDetails::title()`) | `_permission: 'administer site configuration'` |

Both are read-only GET pages. The audit page is also exposed as a **local task tab**
(`cl_devel.links.task.yml`, `Component Audit`, `base_route: sdc.settings`) and a **menu link**
(`cl_devel.links.menu.yml`, `Single Directory Components`, under `system.admin_config_ui`).

## `ComponentAudit::audit()`

- Injects `plugin.manager.sdc` (`ComponentPluginManager`) via `create()`.
- `getAllComponents()` returns every discovered component; sorted by plugin id.
- Computes **forked/overridden** components: filters to `extension_type === ExtensionType::Module`
  components whose `getPluginId()` differs from `find($id)->getPluginId()` (i.e. another component
  wins the lookup).
- Renders each via `buildComponentCard()` into a `#theme => 'item_list'` titled *Detected
  Components*; attaches library `cl_devel/cl_registry`; adds a reminder to check logs and a
  recommendation to add `README.md` + `thumbnail.png`.

### `buildComponentCard(Component $component, array $duped_components)` (private)

- On `InvalidComponentException` while reading metadata → renders a "💥 Error in Component" card
  with the path and the exception message (this is how a broken component surfaces).
- Otherwise builds a card with: title (linked to `cl_devel.component_details` via the
  `cl_label_with_link` theme hook), description (unless it is the "- Description not available -"
  placeholder), the component `path` in a `<pre>`, and a table with columns *Metadata*,
  *Default Template*, *Assets*, *Component Replacement*.
- **Template check**: compares `machineName.'.twig'` to `$component->template` → ✅ present / ❌
  missing.
- **Assets**: lists JS + component CSS keys from the plugin definition `library`.
- **Forked message**: original components say *"Original component"*; forked ones say
  *"Forked at `<path>`"* and *"…this other component will render instead: `<path>`"*.
- **Alter hook**: for non-forked components only, calls
  `moduleHandler()->alter('cl_component_audit', $card_build, $component)` →
  `hook_cl_component_audit_alter(array &$card_build, \Drupal\Core\Plugin\Component $component)`
  (documented in `cl_devel.api.php`). Use it to append render-array items to a component's card.

## `ComponentDetails::details(string $component_id)`

- Injects `plugin.manager.sdc` and `file_url_generator` (`create()`).
- `getComponent()` calls `pluginManager->find($component_id)`; on `ComponentNotFoundException`
  it adds a messenger error and returns NULL → the page shows an "Unable to find" message.
- Renders README markdown: if `League\CommonMark\CommonMarkConverter` exists it converts
  `$metadata->documentation` to HTML (logging `CommonMarkException` to the `cl_devel` logger),
  else falls back to `nl2br()`. The result is passed through **`Xss::filterAdmin()`** before being
  set as the `documentation` slot.
- Returns a render element `#type => 'component'`, `#component => 'cl_devel:component-details'`,
  passing props `machineName`, `id`, `name`, `description`, `status`, `thumbnailHref`
  (from `getThumbnailPath()` → `generateAbsoluteString()`), `path`, `props` (`$metadata->schema`),
  `slots`, and the sanitized `documentation` slot.

## Operate

1. Enable the module (see [config/settings.md](config/settings.md)).
2. As a user with **administer site configuration**, visit
   `/admin/config/user-interface/sdc/registry` (Config → User interface → Component Audit).
3. Click a component title to open its detail page.

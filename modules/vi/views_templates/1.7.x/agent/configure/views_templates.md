# Create a view from a template (admin UI)

The module has **no settings form** (`configure` = null in info.yml) and defines no config or
permissions of its own. It adds a workflow UI to the Views admin, all gated by the core
`administer views` permission.

## Routes (`views_templates.routing.yml`)

| Route | Path | Handler | Purpose |
|---|---|---|---|
| `views_templates.list` | `/admin/structure/views/template/list` | `ViewsBuilderController::templateList` | Table of every available template |
| `views_templates.create_from_template` | `/admin/structure/views/template/{view_template}/add` | `ViewTemplateForm` | Form to instantiate one (`{view_template}` = plugin id) |

Entry points: a local action **"Add view from template"** on the Views list page
(`entity.view.collection`, `views_templates.links.action.yml`) and a matching menu link
(`views_templates.links.menu.yml`).

## The list page
`templateList()` iterates `plugin.manager.views_templates.builder` definitions, instantiates
each builder, and shows a row (Name = `getAdminLabel()`, Description = `getDescription()`,
Add link) **only if `templateExists()`** is TRUE. Duplicate builders whose YAML is missing are
silently skipped. Empty text: "There are no available Views Templates".

## The create form — `ViewTemplateForm`
Titled "Duplicate of @label". Fields:
- `label` (View name, required, defaults to the builder's admin label),
- `id` (machine name; uniqueness checked with `\Drupal\views\Views::getView`),
- `description` (defaults to the builder's description),
- plus anything the builder's `buildConfigurationForm()` adds.

On submit it calls `$builder->createView($values)`, `$view->save()`, and **redirects to the
new View's edit form** (`entity.view.edit_form`) in the standard Views UI — where the created
View is fully editable like any other.

# Defining and editing config pages

Two entity types work together:

| Entity type id | Kind | Role |
| --- | --- | --- |
| `translatable_config_pages_type` | config entity (`ConfigEntityBundleBase`) | the **type/bundle** — its fields are defined via Field UI |
| `translatable_config_pages` | content entity (`ContentEntityBase`, `translatable = TRUE`) | the **values** — exactly one entity per type, translatable |

There is no classic settings form / `configure` route. You build each "settings page" as a bundle.

## 1. Create a type (bundle)

UI: `/admin/structure/translatable_config_pages_types` (route
`entity.translatable_config_pages_type.collection`, under *Structure*) → **Add translatable config
pages type** (`entity.translatable_config_pages_type.add_form`).

Form (`Form\TranslatableConfigPagesTypeForm`) fields:

| Field | Required | Stored as |
| --- | --- | --- |
| Label | yes | `label` |
| Machine name (`id`) | yes | `id` (bundle) |
| Menu → Description | yes | `menu.description` |
| Menu → Parent link | yes | `menu.menu_parent` (via `menu.parent_form_selector`) |

Saving rebuilds the router (`router.builder`) so the new admin menu link appears. The
`Plugin\Derivative\BuilderMenuItems` deriver (`translatable_config_pages.menus`) adds one menu link
per type under the chosen parent — pointing at the page's **edit form** if the page exists yet,
otherwise its **add form**.

Config object written: `translatable_config_pages_type.<id>` with schema
`translatable_config_pages.translatable_config_pages_type.*` (exports `id`, `label`, `uuid`, `menu`).

## 2. Add fields

The content entity's `field_ui_base_route` is `entity.translatable_config_pages_type.edit_form`, so
the **Manage fields / form display / display** tabs appear on the type edit form
(`/admin/structure/translatable_config_pages_types/manage/{type}`). Add any core or contrib field
(text, image, file, media, paragraphs, link, …) — these become the settings on that page.

## 3. Enable translation

Turn on translation for the entity/bundle at `/admin/config/regional/content-language`
(`content_translation`). Then each language edits its own values through the standard translation
tab. `view translatable config pages` permission is required even to reach the *add translation*
flow.

## 4. Edit the values

UI: `/admin/config/system/translatable-config-pages` (route
`entity.translatable_config_pages.collection`, under *Configuration › System*) → **Add translatable
config pages** picks a type and opens the field form (`Form\TranslatableConfigPagesForm`).

Singleton behaviour: the add page (`Entity\Controller\TranslatableConfigPagesEntityController::addPage`,
wired by `Routing\TranslatableConfigPagesRouteProvider`) hides any type that already has a values
entity ("You cannot add more configuration pages."). So a type holds **one** page; after creation
you only ever edit it (`entity.translatable_config_pages.edit_form`,
`/admin/config/translatable-config-pages/{id}/edit`). Saving redirects back to the edit form.

## Storage / deployment note

Field values live in the content tables (`translatable_config_pages`,
`translatable_config_pages_field_data`), **not** in configuration. They are not exported by
`drush cex` and not imported by `drush cim` — only the *type* definitions (bundles + their field
config) deploy as config. Enter or migrate the values per environment. Read them back with the
[manager service](../api/manager.md).

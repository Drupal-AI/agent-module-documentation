# The Pages wizard

All under **Structure → Pages**, permission `administer pages`. Editing is a CTools
`_entity_wizard` that stages changes in tempstore (`tempstore_id: page_manager.page`) until
you Finish/Save; navigating away discards them.

| Route | Path | Purpose |
|---|---|---|
| `entity.page.collection` | `/admin/structure/page_manager` | List all pages (configure route). |
| `entity.page.add_form` | `/admin/structure/page_manager/add` | Start the add wizard. |
| `entity.page.add_step_form` | `…/add/{machine_name}/{step}` | Wizard steps while adding. |
| `entity.page.edit_form` | `…/manage/{machine_name}/{step}` | Edit an existing page's steps. |

## Wizard steps (forms in `page_manager_ui/src/Form/` and `src/Wizard/`)
- **General** (`PageGeneralForm`) — label, path, admin-theme, description.
- **Parameters** (`PageParametersForm`, `ParameterEditForm`) — typed route params.
- **Access** (`PageAccessForm`, `AccessConfigure`) — access conditions + AND/OR logic.
- **Variants** — add via `PageVariantAddWizard` / `AddVariant*` forms: pick variant type,
  then its **Selection criteria** (`…SelectionForm`/`SelectionConfigure`), **Static contexts**
  (`StaticContextConfigure`), **Contexts** (`PageVariantContextsForm`), and variant content
  (`VariantPluginContentForm`, block add/edit forms for block variants).
- **Reorder variants** (`PageReorderVariantsForm`), **Delete** forms for pages/variants.

Wizards: `PageAddWizard`, `PageEditWizard`, `PageVariantAddWizard` (extend `PageWizardBase`).
List builder: `Entity\PageListBuilder`. Config-translation mappers translate page/variant
labels. The wizard writes standard `page` / `page_variant` config — see the engine module's
`configure/pages.md` for the resulting entity shape.

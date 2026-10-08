# Implemented hooks

All in `content_model_documentation.module` unless noted.

| Hook | What it does |
| --- | --- |
| `hook_form_alter` | On `cm_document_add_form`/`edit_form`: seeds `documented_entity` from a `?documented_entity` query param and trims already-documented options via `DocumentableEntityProvider::removeDocumentedEntities()`. |
| `hook_views_data_alter` | Adds Views field handlers: `non_delete_operations` (operations column without Delete) on every table that has `operation`; plus `field_cardinality setting` (`configuration_field_cardinality`) and `field_entity_reference_targets` (`configuration_field_entity_reference_targets`) on `config_field_field`. |
| `hook_views_pre_render` | On the `content_model_fields` view, removes the `non_delete_operations` field when `field_ui` is not enabled. |
| `hook_menu_local_tasks_alter` | Turns the per-bundle "Documentation" tab into an "Add Documentation" link (to `entity.cm_document.add_form` prefilled with `documented_entity`) when no cm_document exists yet for that bundle; sets cache max-age 0 accordingly. |
| `hook_entity_delete` | Deletes cm_document entities related to a deleted bundle/entity via `cm_document_manager->deleteRelatedDocuments()`. |
| `hook_help` | Renders `README.md` on `help.page.content_model_documentation` (through the `markdown` module if present). |
| `hook_theme_suggestions_HOOK` / `template_preprocess_*` | Theme plumbing for the `content_model_documentation` render element (twig `cm_document.html.twig`), suggestion `content_model_documentation__<style>`. |

## Local task derivatives (plugins it defines)

`Plugin/Derivative/DocumentLocalTab` and `Plugin/Derivative/DiagramLocalTab` derive the
"Documentation" and "Diagram" tabs shown on bundle/vocabulary/view/menu manage pages (the
`entity.<type>.document` and `.diagram` routes in `*.routing.yml`). It also defines two
Validation constraint plugins (`DocumentNameRequiredConstraint`,
`OneDocumentPerEntityConstraint`) — see api doc. It does **not** define any plugin *manager* of
its own.

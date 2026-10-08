# autosave_form — agent start

Periodically saves form state in the background and offers to restore it. Works by
decorating core `form_builder`/`form_validator`/`form_error_handler`. Config UI:
**Admin → Config → Content authoring → Autosave Form** (route
`autosave_form.admin_settings`). Depends on core `system`.

- Settings (interval, entity types, notification) → [configure/settings.md](configure/settings.md)
- Storage service (read/purge autosaved state) → [api/storage.md](api/storage.md)
- Add autosave to a custom (non-entity) form → [extend/custom-forms.md](extend/custom-forms.md)

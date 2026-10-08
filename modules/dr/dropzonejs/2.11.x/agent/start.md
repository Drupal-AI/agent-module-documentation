# dropzonejs — agent start

Drupal integration for the DropzoneJS drag-and-drop upload library. Exposes a
`#type => 'dropzonejs'` form element that POSTs files to route `dropzonejs.upload`
and stores them as temporary uploads. Requires the JS lib in `libraries/dropzone`.
Depends on core `file`. No admin config route (settings live in `dropzonejs.settings`).

- Global settings + placing the `dropzonejs` form element → [configure/settings.md](configure/settings.md)
- Services (upload handler / upload save) and events → [api/services.md](api/services.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Theme hook & template overrides → [theming/theming.md](theming/theming.md)

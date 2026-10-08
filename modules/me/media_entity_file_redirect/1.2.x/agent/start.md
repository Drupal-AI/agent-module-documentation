# Media Entity File Redirect — agent index

Adds `/document/{media}` → 302 redirect to the file URL of a file-source media entity. Access =
`media.view`; the feature is off per media type until you enable it. No permissions, no settings
page (`configure` null), no Drush.

- **Enable the `/document/{id}` path per media type + how the route/controller behaves** →
  [configure/enable.md](configure/enable.md)
- **Optional Linkit Matcher and Substitution plugins for linking to the path** →
  [plugins/linkit.md](plugins/linkit.md)

Key facts:
- Route `media_entity_file_redirect.file_redirect`, path `/document/{media}` (`\d+`),
  `_entity_access: media.view` (`media_entity_file_redirect.routing.yml`).
- Toggle stored at `media.type.*.third_party.media_entity_file_redirect.enabled` (default off).
- Controller 404s unless the media source is a core `File` source AND the type toggle is on.
- Redirect target comes from the file's own URI (no request-controlled redirect; no open-redirect).

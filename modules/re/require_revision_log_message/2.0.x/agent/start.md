# Require Revision Log Message — agent index

Makes the node **revision log message** a required field for selected content types. Pure
form-alter + settings form + one config object + two permissions. No services, plugins,
drush, or entities.

Key facts:
- Config object: `require_revision_log_message.adminsettings`
  - `content_types`: sequence of node-type machine names the requirement applies to
    (a type is "on" when its machine name is a value in this list).
  - `require_for_new_nodes`: boolean; when FALSE (default) the requirement only fires when
    **editing an existing** node, not when creating a new one.
- Configure route: `require_revision_log_message.admin_settings_form`
  → `/admin/config/require-revision-log/adminsettings`.
- When active on a type it forces `revision` on (and disabled) and marks `revision_log`
  `#required` on the node form.

- **Turn the requirement on for a content type / where it is stored / new-node behavior** →
  [configure/settings.md](configure/settings.md)
- **The two permissions (`administer` and `bypass`)** →
  [permissions/permissions.md](permissions/permissions.md)

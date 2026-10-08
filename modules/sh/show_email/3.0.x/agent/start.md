# Show Email — agent index

Makes the user `mail` base field display-configurable and adds a **Show email address** field
formatter so a user's email can be shown on their profile (optionally as a mailto link), with
hide-user-1 and hide-per-role toggles. No admin page (`configure` null), no permissions, no Drush.
Config schema for the formatter settings. No dependencies beyond core.

- **Enable the email display, the formatter and its three settings, storage location, and who can see
  whose email** → [configure/formatter.md](configure/formatter.md)

Key facts:
- `hook_entity_base_field_info_alter()` sets the user `mail` field `setDisplayConfigurable('view', TRUE)`
  so it shows up on *People » Account settings » Manage display*.
- Formatter `show_email_address` (`FieldFormatter`) applies only to `email` fields on the `user`
  entity. Settings: `hide_user_one` (default 1), `hide_per_role` (roles of the *viewed* account to
  suppress), `email_mailto` (default 0).
- It adds no view-access of its own — core field/profile view access still decides who can reach the
  value; these settings only further *hide* it.

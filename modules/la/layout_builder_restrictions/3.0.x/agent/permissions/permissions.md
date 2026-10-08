# Permissions

Defined in `layout_builder_restrictions.permissions.yml`:

- **`configure layout builder restrictions`** — "Configure layout builder restrictions".
  `restrict access: true` (security-sensitive; grant only to trusted admins/site builders).
  Required to reach the global plugin admin page
  (`/admin/config/content/layout-builder-restrictions`) and to set restrictions on layouts.
  It does not grant Layout Builder editing itself — that is still governed by core Layout
  Builder permissions (e.g. *configure any layout* / *configure all &lt;bundle&gt; layouts*).

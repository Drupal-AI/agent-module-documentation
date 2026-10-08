# roleassign — agent start

Lets a user with the new **Assign roles** permission (plus core **Administer users**) assign a
restricted, configurable subset of roles on the user edit form — without needing the dangerous
**Administer permissions**. A site admin picks which roles are assignable at
**People → Role assign** (`/admin/people/roleassign`, route `roleassign.settings`); the choice is
stored in `roleassign.settings` (`roleassign_roles`). A `hook_form_alter()` narrows the roles
field on user forms and a `hook_user_presave()` enforces it server-side. No module dependencies
beyond core.

- Pick which roles are assignable + config keys → [configure/roleassign.md](configure/roleassign.md)
- The "assign roles" permission vs core "administer permissions", and how access is decided → [permissions/roleassign.md](permissions/roleassign.md)

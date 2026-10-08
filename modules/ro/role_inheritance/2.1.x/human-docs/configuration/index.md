# Configuration

Configuration means deciding, for each role, which other role(s) it should inherit
permissions from. The module then grants each role the union of its own permissions
plus everything held by the roles it inherits from.

## Open the configuration form

1. Log in as an administrator with permission to administer permissions/roles.
2. Open the Role Inheritance configuration form (the
   `role_inheritance.config_role_inheritance` route).

## Define the inheritance relationships

On the form you set up which roles inherit from which. Following the newsroom
example:

- Leave **Writers** with no inheritance — this is your base role, and you grant the
  create/edit-content permissions to it directly on the normal
  **People → Permissions** page.
- Configure **Editors** to inherit from **Writers**, so Editors automatically gain
  everything Writers can do, on top of any permissions granted directly to Editors.
- Configure **Global Editors** to inherit from **Editors**, so they gain the
  Editors' set (which already includes the Writers' set) plus their own.

Inheritance chains like this let a permission granted once at the bottom flow up to
every role above it. You can also point several roles at a common base, or have a
role inherit from more than one role at once — the effective permission set is
always the union of everything reachable through inheritance.

Save the form when the relationships are set.

## Review effective permissions after every change

This is the step that keeps a hierarchy safe. Because inheritance is **additive and
only ever grants**, a single sensitive permission on a base or intermediate role
propagates to every role that inherits from it — sometimes granting more than you
intended.

After you change the graph:

- Walk each role and confirm its **effective** permissions (its own plus everything
  inherited) match what that role is supposed to be able to do.
- Pay special attention to any powerful permission (anything that administers users,
  permissions, content types, or site configuration): trace which roles now inherit
  it.
- Remember the module never *removes* a permission — if a role is over-privileged
  through inheritance, the fix is to restructure the graph or move the offending
  permission, not to expect inheritance to subtract it.

Building the hierarchy from the least-privileged base upward, and reviewing after
each change, keeps the convenience of inheritance without accidental privilege
escalation.

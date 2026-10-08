# Role Enum — manual setup guide

**Role Enum** (`role_enum`) is a **developer utility** that lets you express your
site's user roles as typed PHP **enums** instead of magic-string role IDs. With it,
custom code — bundle classes, tests, and business logic — can reference a role as an
enum case (for example `MyRoles::ContentEditor`) and get type-safety and IDE
autocompletion in return.

It goes a step further than a plain list of constants: a role enum can *back* real
Drupal role configuration. When you run a config import (`drush deploy` or
`drush cim`), the role configuration is generated from the enum, so the roles appear
in the normal Role and Permission UIs without you writing role YAML files by hand.
Permissions for each case can be declared with attributes (a single permission
string, a whole permission enum, or "all permissions" for admin/developer roles),
and the role's label and weight can be customized the same way. There is also an
optional trait/interface for the User entity that adds concise helpers such as
`$user->r->add(MyRoles::ContentEditor)`.

This is code-first tooling — there is no admin form. You use it from your module's
PHP. The module depends on core's User module and requires Drupal 11.1 or newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration UI** — this is a developer library you use from code.

## How to use it (in brief)

You define an enum in your own module, typically under `src/Role/`, that implements
the module's `ConfigBackedRoleInterface`, with one case per role and attributes
declaring permissions, label, and weight. On `drush deploy` / `drush cim` the roles
are generated and behave like any other Drupal role. Full code examples — including
the permission attributes, the "all permissions" attribute, YAML-backed enums, and
the User bundle-class trait — are in the module's project page and `README.md`, and
summarized in the [`agent/`](../agent/start.md) docs. Because this is developer
tooling, the setup lives in your codebase rather than in the admin UI.

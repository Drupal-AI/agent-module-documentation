# Configuration

Everything Authorization does is driven by **authorization profiles**. A profile
pairs one provider plugin with one consumer plugin and a table of mappings
between them. This page walks through building one and the one global setting.

## Manage profiles

Profiles live at **Configuration → People → Authorization**
(`/admin/config/people/authorization/profile`) — a collection page where you add,
edit, and delete profiles. Access is gated by the core **Administer site
configuration** permission.

## Building a profile, field by field

When you add or edit a profile you set:

- **Label** and **machine name** — how the profile is identified.
- **Provider** — the provider plugin that supplies proposals about the user (for
  example an LDAP provider from `ldap_authorization`). If no provider module is
  installed this list is empty and the profile can't do anything yet.
- **Provider configuration** — settings specific to the chosen provider plugin
  (for LDAP, for example, which server and how to read group memberships).
- **Consumer** — the plugin that grants a Drupal-side target. With the bundled
  submodule enabled this is **Drupal roles** (`authorization_drupal_roles`).
- **Consumer configuration** — settings specific to the consumer (the Drupal
  Roles consumer has none).
- **Mappings** — the heart of the profile. This is a paired table: each
  **provider mapping** is a match rule (a specific group name, or a regular
  expression / "Source" wildcard that matches any group), and the **consumer
  mapping** on the same row is what to grant when it matches (which role). The
  two lists are index-aligned — the consumer mapping on row *i* is granted when
  the provider mapping on row *i* matches. A regex wildcard lets you map any
  matched external group straight to a like-named role.
- **Synchronization modes** — *when* the profile acts. The typical mode is **on
  user logon**, so grants are reconciled every time the user logs in.
- **Synchronization actions** — *what* the consumer may do:
  - **Create consumers** — create missing targets on the fly (for example,
    create a Drupal role from an external group name that doesn't have a matching
    role yet).
  - **Revoke provider-provisioned** — revoke grants the module previously made
    when they no longer apply (de-provisioning). Only grants the module itself
    made are revoked — roles you assigned manually are left alone.

A profile only runs when it is **enabled** and both its provider and consumer
plugins resolve. Because profiles are config entities, they export and deploy
with `drush config:export` / `config:import`, so you can stage complex
directory-to-role policies in code.

## The global setting

The settings form at
`/admin/config/people/authorization/profile/settings` has one option: whether to
show users a **status message** after their authorizations are processed at login
(`authorization.settings:authorization_message`).

## Building a profile from the command line

Profiles are config entities of type `authorization_profile`, stored as
`authorization.authorization_profile.{id}`. The provider and consumer mappings
are index-aligned. This example creates a roles-only profile that maps to the
`editor` role (fill in a real provider id and its mappings once a provider is
installed):

```bash
drush php:eval '
$p = \Drupal::entityTypeManager()->getStorage("authorization_profile")->create([
  "id" => "ldap_to_roles",
  "label" => "LDAP to roles",
  "provider" => "",                          // e.g. an ldap_authorization provider id
  "provider_config" => [],
  "provider_mappings" => [],                 // provider-specific match rules
  "consumer" => "authorization_drupal_roles",
  "consumer_config" => [],
  "consumer_mappings" => [["role" => "editor"]],
  "synchronization_modes" => ["user_logon" => "user_logon"],
  "synchronization_actions" => [
    "create_consumers" => "create_consumers",
    "revoke_provider_provisioned" => "revoke_provider_provisioned",
  ],
]);
$p->save();
'
```

Read it back with `drush config:get authorization.authorization_profile.ldap_to_roles`.

## Notes

- **One provider + one consumer per profile.** The recommended pattern is one
  profile per provider/consumer combination; each profile is evaluated on its
  own.
- A profile does nothing useful until an `@AuthorizationProvider` plugin is
  installed (for example via `ldap_authorization`). Out of the box only the
  **Drupal Roles** consumer ships.

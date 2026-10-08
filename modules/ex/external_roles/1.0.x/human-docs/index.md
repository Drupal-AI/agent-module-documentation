# External Roles — manual setup guide

**External Roles** (`external_roles`) lets you grant Drupal permissions to users
based on roles that come from *outside* Drupal — the roles an identity provider or
SSO system reports for a user — without creating matching Drupal roles for each
one. It plugs into Drupal core's **Access Policy API** and layers the permissions
for a user's external roles on top of whatever their Drupal account already
grants.

The key idea, and the reason the module is safe to use for this, is *where* the
role-to-permission mapping lives. You define it in **`settings.php`**, not in the
site's configuration UI. That makes the mapping server-side and admin-controlled:
nobody can widen their own permissions by editing site config through the browser,
because the grants aren't stored as editable config at all.

This is a **developer-oriented** module. There is no click-through admin screen:
you write the role definitions in `settings.php` and you assign external roles to
users in code (typically from a user-save or SSO-login hook). It's an ideal fit
for projects that already authenticate against an external system and want that
system's roles to drive Drupal permissions. It depends only on core's User module
and supports Drupal 10.3+ and 11.

Because this module *grants permissions*, treat every mapping as a privilege
decision. A permission listed against an external role is handed to every user who
carries that role — so map deliberately, and be careful never to attach
high-privilege permissions (like *administer …* permissions) to a role your
identity provider hands out broadly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define the role→permission mapping in
   `settings.php` and assign external roles to users in code.

## Where it lives in the admin menu

External Roles adds **no admin page**. All of its configuration lives in
`settings.php` and in your custom code — see
[Configuration](configuration/index.md).

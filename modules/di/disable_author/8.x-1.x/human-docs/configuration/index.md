# Configuration

Disable Author has one simple setting: the list of roles for which the node-form
**Authoring information** fieldset should be hidden. Until you select at least one
role, the module changes nothing.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Disable Author → Settings**, or navigate directly to
   `/admin/config/disable_author/settings`.

## Choose the roles

The form lists your site's user roles as checkboxes (stored as the
`disallowed_roles` setting). Tick every role whose members should **not** see the
Authoring information fieldset on node forms. When a user who has any of the ticked
roles edits a node, the fieldset is hidden for them; everyone else keeps it.

Click **Save configuration** to apply. Changes take effect immediately on the next
node form load.

## Remember its limits

This setting only hides the widget in the editing UI. It does **not** prevent
authorship from being changed through REST, JSON:API, other forms, or programmatic
edits, and it does not remove any permission the user already has. If your goal is
to genuinely stop a role from reassigning authorship, enforce that with Drupal's
permission system as well — treat Disable Author as a way to declutter the form, not
as a security boundary.

# Configuration

Configuring this module means creating one or more **custom publishing options** and
then granting the permissions that control who can use them.

## Open the options collection

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Custom Publishing Options**, or
   navigate directly to `/admin/config/content/custom_publishing_option`.

This page lists your existing options and links to add, edit, and delete them.

## Create an option

Click **Add** (`/admin/config/content/custom_publishing_option/add`) and fill in:

- **Label** — the human-readable name editors will see next to the checkbox, e.g.
  "Archived" or "Featured".
- **Machine name** — the internal id. This is important: it also becomes the name of
  the boolean field added to every node, so choose it carefully (it is hard to change
  later).
- **Description** — an optional note explaining what the option is for.
- **Publish under promote options** — a checkbox. Leave it off and the option appears
  under a "Custom Publish Options" group on the node form; tick it and the checkbox is
  instead grouped with core's "Promotion options".

Save it. Behind the scenes the module installs a boolean field named after your
machine name on the `node` entity, so the new checkbox immediately appears on every
content type's add/edit form, and the field becomes usable in Views as a field,
filter, and sort. Deleting the option later removes that field again.

You can also set a **default value** for the option per content type: the node type
edit form's "Publishing options" section now includes your custom options, letting you
decide whether new nodes of that type start with the box ticked.

## Permissions

Custom Publishing Options adds two kinds of permission, both at **People → Permissions**
(`/admin/people/permissions`):

- **Administer custom publishing options** — create, edit, and delete the option
  definitions themselves. This is a restricted permission; grant it only to trusted
  roles.
- **Can set node publish state to *(each option)*** — one of these is generated per
  option (for example "Can set node publish state to Archived"). It controls whether
  that option's checkbox is shown to a role on the node form. Grant each option to the
  roles that should be allowed to set it.

Important caveat: these custom options are gated *only* by their per-option
permission. But a role still needs the core **Administer nodes** permission (or the
separate Override Node Options module) to see core's own Published/Promoted/Sticky
checkboxes. A role can set your custom options without `administer nodes`, just not the
core ones.

With Drush:

```bash
drush role:perm:add editor 'can set node publish state to archived'
drush role:perm:add editor 'administer custom publishing options'
```

## Setting an option in bulk

The module ships a node **action**, "Set a custom publish option value on a node". You
can run it from the content overview (`/admin/content`) or a Views bulk-operations
view: select nodes, choose the action, pick which option to set and whether to set it
on or off, and apply. This is the quick way to, say, archive a batch of nodes at once.

## Using an option in Views

Because each option is a normal boolean field on the node, no extra setup is needed to
use it in Views. Add it as a field, or add a filter or sort on it, to build listings
such as an "Archived content" report or a "Featured" block — exactly as you would with
any node field.

## Deploying as configuration

The option definitions are configuration entities
(`custom_pub.custom_publishing_option.<id>`), so they export with your site
configuration and can be deployed across environments.

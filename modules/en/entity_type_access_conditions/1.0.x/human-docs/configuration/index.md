# Configuration

There are two parts to setting this up: a global settings page where you choose
which condition plugins are available, and the per-bundle forms where you actually
build the conditions.

## The settings page — choose available conditions

1. Log in as a user with **Administer entity type access conditions**.
2. Go to **Configuration → Content authoring → Entity Type Access Conditions**
   (`/admin/config/content/entity-type-access-conditions`).
3. Under **Enabled conditions**, pick which condition plugins should be offered
   when someone builds conditions on a bundle form. This is where you curate the
   list so editors only see the conditions that make sense for your site.
4. Save.

The choices are stored in the `entity_type_access_conditions.settings`
configuration object.

## Add conditions to a bundle

1. Edit a supported bundle — out of the box that means a **Content type** (Structure
   → Content types), a **Media type**, or a **Taxonomy vocabulary**.
2. Find the **Entity Type Access Conditions** section on the edit form. This
   section is built by Conditions Helper from the conditions you enabled above,
   plus the contexts available on your site.
3. Configure one or more conditions (for example, a user-role condition, a
   request-path condition, or a language condition). When several are set, they are
   evaluated together.
4. Save the bundle. The conditions are stored on that bundle's configuration
   (in its third-party settings), so they are included in configuration exports.

## Which operations are restricted (the default map)

This is the key detail to get right. The module only enforces conditions for the
operations a given entity type declares as "restricted." The shipped defaults are:

| Entity type | Restricted operations |
|---|---|
| Node (content) | `create` |
| Node type (config) | `create`, `update`, `delete`, `view` |
| Media (content) | `create` |
| Media type (config) | `create`, `update`, `delete`, `view` |
| Taxonomy term (content) | `create` |
| Taxonomy vocabulary (config) | `create`, `update`, `delete`, `access taxonomy overview` |

Notice that for the *content* entities (node, media, taxonomy term) only
**create** is gated by default; the richer operations apply to the *bundle
configuration* entities. In practice this means setting a "view" or "update"
condition on a content type restricts the config entity, **not** the viewing or
editing of the individual content items. If you need to restrict those, consider
extending the operation map for your entity type (see the `agent/extend/add-entity-type.md`
docs for the YAML plugin approach).

## How enforcement works at runtime

When someone attempts a restricted operation, the module:

1. Lets anyone with **Bypass entity type access conditions** straight through
   (it returns "neutral" for them).
2. Returns "neutral" if there is no plugin for that entity type, the operation is
   not in the restricted list, or no conditions have been stored.
3. Otherwise evaluates the stored conditions. If they evaluate to **false**, access
   is **forbidden**; anything else is "neutral."

Because it only ever returns "forbidden" or "neutral" — never "allowed" — it can
only *deny*. Access itself is still granted by core and your normal permissions;
this module simply adds an extra gate on top.

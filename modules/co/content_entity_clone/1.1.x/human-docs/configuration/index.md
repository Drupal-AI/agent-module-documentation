# Configuration

Configuring the module has two parts: enabling cloning on the bundles you want (and
choosing how each field is copied), and granting the permissions that decide who can
configure and who can clone.

## Open the overview

1. Log in as a user with the **Administer entity cloning** permission.
2. Go to **Configuration → Content Entity Clone**, or navigate directly to
   `/admin/config/content_entity_clone`.

This page lists your entity types and bundles, with a link to each bundle's settings.

## Enable cloning on a bundle

Open a bundle's settings form (for example the Article content type). Here you:

- **Turn cloning on** for the bundle.
- **Set the clone link label** — the text of the Clone action/local task (for example
  "Clone" or "Duplicate").
- **Choose a field processor per field** — for each field you want carried into the
  copy, pick how its value should be handled. A field with no entry is left empty on
  the clone.

Save the form. Only the fields you configured are copied to the new entity.

### The field processors

The module ships four processors:

- **Copy values** — copies the field's value across unchanged. This is the everyday
  choice for most fields (body, image, references you want to reuse).
- **Entity label clone suffix** — appends " [CLONE]" to the entity's label field, so a
  copied item is obviously a copy (typically used on the title).
- **Clone referenced entities** — for reference fields, clones the *referenced*
  entities too rather than pointing the copy at the same ones. Use this to deep-copy,
  say, referenced paragraphs.
- **Copy layout** — copies a Layout Builder layout field, so a cloned page keeps its
  layout.

Developers can add more processors: the field-processor system is a plugin type, so a
custom processor placed in a module appears automatically as a choice here (and a hook
lets modules alter the available processors). See the sibling
[`agent/`](../agent/start.md) docs for the plugin API.

## Permissions

Two permissions, both at **People → Permissions** (`/admin/people/permissions`):

- **Administer entity cloning** — access the overview and bundle settings to decide
  what can be cloned and how. Grant to site builders/administrators.
- **Clone content entities** — actually see and use the Clone action on enabled
  entities. Grant to the editors who should be able to duplicate content.

With Drush:

```bash
drush role:perm:add editor 'clone content entities'
```

## How a clone works for editors

Once a bundle is enabled and a user has **Clone content entities**, a **Clone**
operation and a Clone local-task tab appear on entities of that bundle. Clicking it
opens the entity's normal creation form, pre-filled with the processed field values,
as a new **unsaved** entity. The editor reviews the copy and saves it themselves —
nothing is duplicated until they do.

## Deploying as configuration

Each bundle's clone settings are stored as a config object
(`content_entity_clone.bundle.settings.<entity_type>.<bundle>`), so they export with
your site configuration and deploy across environments.

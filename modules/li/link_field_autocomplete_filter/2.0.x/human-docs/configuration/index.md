# Configuration

This module has no settings page of its own. You configure it **per Link field
instance**, right on the field's edit form, and the choice is saved as part of that
field's configuration.

## Open the field's settings

1. Go to the field instance you want to restrict, for example **Structure → Content
   types → (type) → Manage fields**, then **Edit** on your Link field. (The same
   applies to Link fields on other entities, such as a paragraph type.)
2. On the field edit form you'll find an **"Autocomplete Filter"** fieldset. It only
   appears on fields of type **Link**.

## The settings, field by field

The fieldset has two controls:

### Which content types should be allowed for internal links?

A choice between two modes:

- **Include the selected below** — the field's autocomplete will suggest **only** the
  content types you tick. Use this to whitelist a small set (for example, a "Related
  page" field that should only ever point at Basic pages).
- **Exclude the selected below** — the field's autocomplete will suggest **every**
  content type **except** the ones you tick. Use this to blacklist a few types (for
  example, hide internal-only content types) and allow the rest.

### Content types

A list of checkboxes, one per content type. Tick the types the mode above applies to.

> **If none are checked, all are allowed.** Leaving every box unticked means the module
> does nothing and the field behaves exactly like core — every content type is
> suggested. This is the default.

Save the field. From then on, the field's internal-link autocomplete only offers nodes
of the allowed types.

## What happens when settings change

The module also adds a validation check on the field. If you tighten the allowed types
after content has already been created, an existing link that now points at a
disallowed content type will raise a form error the next time that content is saved —
so you find out about the mismatch instead of silently keeping a link you no longer
want.

## Per-instance, and deployable

Because the setting lives on the individual field instance, the **same base field can
be filtered differently on each bundle** — a shared "link" field can allow News on one
content type and Landing pages on another. And since it's stored as part of the field's
configuration, you can export it and deploy it across environments with Drupal's
configuration sync, or script it in an update hook. The settings are kept as
third-party settings on the field's config entity
(`field.field.<entity>.<bundle>.<field>`); for the exact keys and how the autocomplete
is filtered under the hood, see the [`agent/`](../agent/start.md) docs.

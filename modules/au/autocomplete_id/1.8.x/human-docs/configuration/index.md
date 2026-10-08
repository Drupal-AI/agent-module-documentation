# Configuration

There are two ways to switch on ID matching — a per-field widget and a site-wide
toggle — plus a permission that controls who sees ID results. The two modes are
**mutually exclusive**: the per-field widget only adds ID suggestions while the
global toggle is off, and the global toggle only works while you're *not* relying
on the per-field widget, so an ID suggestion is never added twice.

## Grant the viewing permission first

At **People → Permissions**, grant the roles that should see ID-based results:

- **View entity autocomplete id results** — required for the `Label (id)`
  suggestion to appear for a user. Without it, those users see only core's normal
  label matches.
- **Administer entity autocomplete id** — access to the settings form below. Keep
  this to administrators.

## Option A — the per-field widget (targeted)

Use this when you want ID matching on specific fields only.

1. Go to **Structure → *(entity type, e.g. Content types → Article)* → Manage
   form display**.
2. Find your entity reference field and change its widget to **Autocomplete match
   ID**.
3. Save. The widget honors the field's existing selection settings — allowed
   `target_bundles`, the match limit, tags/multi-value behavior, and auto-create —
   exactly as core does, and only adds the ID suggestion on top.

Leave the global toggle (below) **off** when using this mode.

## Option B — the global toggle (site-wide)

Use this to enable ID matching everywhere at once.

1. Go to **Configuration → Content authoring → Autocomplete ID**
   (`/admin/config/content/autocomplete-id`).
2. Turn on the global option (stored as the `autocomplete_id_global` config flag).
3. Save.

Every core entity-autocomplete field across the site now offers ID matches — for
users who also have the viewing permission.

## Option C — the form element (for developers)

In custom forms, use the `entity_id_autocomplete` render element type in place of
core's `entity_autocomplete` to accept either a label or an ID. This is a
code-level option; no UI configuration is involved.

## How access is protected

ID suggestions always respect each entity's `view` access, so an editor can never
reference an entity they aren't allowed to see, and any configured
`target_bundles` restriction still applies. The module's autocomplete route also
re-validates the same signed selection-settings key that core uses, so exposing
the route is not an access bypass.

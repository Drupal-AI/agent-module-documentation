# Configuration

Entity Reference Direct Input has a single, small settings form whose only job
is to decide which entity types accept direct input. Until you enable at least
one type here, the module changes nothing.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Entity Reference Direct Input**,
   or navigate directly to
   `/admin/config/content/entity-reference-direct-input`.

## Choose the enabled entity types

The form lists the three supported target types — **Node**, **User**, and
**Taxonomy Term** — as checkboxes. Tick the ones whose autocomplete reference
fields should accept pasted identifiers, and leave the rest unchecked.

- **Node** — editors can paste a node ID, `#123`, a node's canonical URL, or a
  path alias to reference it.
- **User** — in addition to ID and URL, editors can type a user's **email
  address** to resolve the reference (email lookup applies to users only).
- **Taxonomy Term** — editors can paste a term ID, URL, or alias.

Only the types you tick get the behaviour; every other reference field keeps
core's standard label-only autocomplete.

## Save

Click **Save configuration**. The setting is stored in
`entity_reference_direct_input.settings` and takes effect immediately — reload
any autocomplete reference field for an enabled type and try pasting an ID or
URL.

## Good to know

- **Bundle restrictions are always respected.** If a field is limited to
  certain target bundles, direct input will not inject a match outside that set
  — it cannot widen what a field is allowed to reference.
- **Accepted input forms** are: a bare number or `#number`; a user email (User
  only); a full `http(s)://` URL; and a path or alias, including
  `/node/N`, `/user/N`, and `/taxonomy/term/N` style paths.
- **Path-to-ID resolution skips a view-access check** by design when turning a
  path into an ID. That only affects which suggestion appears; the referenced
  entity is still subject to the field's selection handler and to the entity's
  own access controls when the host content is saved and rendered.

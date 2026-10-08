# Configure Token Content Access

There is **no dedicated settings page** (`configure` is null). TCA settings are edited inline
on the target entity's add/edit form, and per-bundle defaults on the bundle's edit form.

## Prerequisite: a TcaPlugin for the entity type
The base module supports no entity types on its own. Enable a submodule (or write a plugin,
see plugins/tca-plugin.md) so an entity type becomes "affected":
- `tca_node` → nodes
- `tca_commerce_product` → commerce products

Only affected entity types get the base fields and the TCA form section.

## Per-entity settings (the TCA fieldset)
`FormManglerService::addTcaSettingsToEntityForm()` adds a **TCA** fieldset to the entity form
when the current user has `tca administer <entity_type>` (or the bundle forces TCA). Fields:

| Form field | Base field | Meaning |
|---|---|---|
| **TCA Active** (`tca_active`) | `tca_active` | Require a matching `?tca` token to view this entity. Disabled/checked when the bundle forces it. |
| **TCA Public** (`tca_public`) | `tca_public` | When the token matches, **allow** view even without "View published content" (e.g. share unpublished/gated content). |
| **TCA Token** (`tca_token`) | `tca_token` | The secret token. Auto-generated on save via `TcaSettingsManager::generateToken()`; an AJAX "generate" sets the field. Regenerate to revoke old links. |

The shareable URL is the entity's canonical URL plus `?tca=<token>`.

## Per-bundle settings (force)
On the bundle (e.g. content type) edit form a **TCA** section adds an **Enforce Token usage**
(`force`) checkbox. Stored as a `tca.tca_settings.<bundle>` config entity
(`config/install/tca.tca_settings.default.yml` seeds `active:0, token:'', public:0, force:false`).
When forced, every entity of the bundle has TCA active and editors can't turn it off.

## Where settings are stored
- **Content entities** (node, product): in the `tca_active` / `tca_public` / `tca_token`
  base fields on the entity itself.
- **Bundles** and non-fieldable targets: in `tca.tca_settings.*` config entities
  (id = `<entity_type>` or `<entity_type>_<id>`), schema `tca_settings.schema.yml`.
`TcaSettingsManager::loadSettingsAsConfig()` merges these, falling back to
`tca.tca_settings.default`.

## Enforcement summary
`TcaAccessCheck::access()` runs on `view`. If TCA is active and the `?tca` query does not
`hash_equals()` the stored token (or is empty) → **forbidden**. If it matches and `public` is
set → **allowed** (bypasses normal view perms); if it matches but not public → neutral (normal
permissions still apply). Users with `tca bypass <entity_type>` skip the whole check.

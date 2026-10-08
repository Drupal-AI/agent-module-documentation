# Configuration

Everything is managed under **Structure → Synonyms configuration**
(`/admin/structure/synonyms`), which requires the **Administer synonyms**
permission. The overview lists every eligible entity type and bundle, with links to
manage its providers and behaviors. Two forms — the global settings and the
per-bundle *Manage behaviors* form — instead require core's **Administer site
configuration** permission.

There are three things to set up: **providers** (where synonyms are read from),
**global settings** (how a synonym is worded for display), and **behaviors** (which
integrations are active per bundle).

## 1. Register a Synonym provider

A **Synonym** is a configuration entity that binds a provider to one entity
type/bundle/field — it says "read this bundle's synonyms from this field".

1. On the overview, find the entity type and bundle you want (for example
   *Taxonomy term → Tags*) and choose **Add** (provider) for it. The add form is at
   `/admin/structure/synonyms/{entity_type}/{bundle}/add`.
2. Pick a provider. The shipped `field` and `base-field` providers offer one option
   per **supported field** on the bundle — so you effectively choose the field the
   synonyms live in. Supported field types are: text, entity reference, integer /
   number, float, decimal, email and telephone. (For an entity-reference field, the
   referenced entities' labels become the synonyms.)
3. Save. This creates a Synonym config entity storing the provider plugin and its
   configuration (at minimum a **wording** string).

You can add several providers to one bundle — for example synonyms from both a
plain-text "also known as" field and an entity-reference field.

## 2. Global settings — wording

At **Structure → Synonyms configuration → Settings**
(`/admin/structure/synonyms/settings`, requires *Administer site configuration*),
the `synonyms.settings` object controls how a synonym is formatted for display:

| Setting | Default | Meaning |
|---------|---------|---------|
| **Wording type** | `default` | Which wording strategy is used when a synonym is shown to a user |

The default wording is fine for most sites; change it only if you want a different
phrasing strategy across the board.

## 3. Enable behaviors per bundle

**Behaviors** are the actual integrations (autocomplete, select, search and so on),
contributed by the submodules you enabled. They are turned on per entity type and
bundle:

1. Go to the bundle's *Manage behaviors* form at
   `/admin/structure/synonyms/behavior/{entity_type}/{bundle}` (requires *Administer
   site configuration*).
2. Enable each behavior you want for this bundle. Enabling one stores a small config
   with:
   - **Status** — whether the behavior is on for this bundle.
   - **Wording** — a behavior-specific wording string, for example
     "@synonym is the @field_label of @entity_label".
3. Save.

Only behaviors whose submodules you enabled appear here — so if you want
synonym-aware autocomplete, make sure `synonyms_autocomplete` is enabled first (see
[Installation](../installation/index.md)).

## Permissions summary

| Permission | Gates |
|------------|-------|
| **Administer synonyms** | The overview and adding/editing/deleting Synonym provider config entities |
| **Administer site configuration** (core) | The global settings form and the per-bundle *Manage behaviors* form |

## Putting it together

A typical setup: enable `synonyms` + `synonyms_autocomplete`, register a `field`
provider on *Taxonomy term → Tags* reading an "alternate names" text field, then
enable the autocomplete behavior on that bundle. From then on, an autocomplete on a
Tags reference field matches "USA" to the term labelled "United States".

# Configuration

LocalGov Topics has **no settings form** — it works by shipping ready-made
configuration. The setup work is making use of what it installs: managing the
Topic vocabulary, attaching the topic field to your content types, and (optionally)
wiring the reference view and role permissions.

## The Topic vocabulary

Enabling the module creates a taxonomy vocabulary:

- **Name:** Topic
- **Machine name:** `localgov_topic`
- **Description:** "Topic tags group together related content across all services"

Manage its terms at **Structure → Taxonomy → Topic**
(`/admin/structure/taxonomy/manage/localgov_topic/overview`). Create a term for
each topic you want to group content under.

## Make a content type topic-taggable

The module installs a field **storage** called `localgov_topic_classified` — an
unlimited-cardinality, translatable entity-reference field pointing at taxonomy
terms — but it is **not attached to any content type**. Within the full
LocalGovDrupal distribution the content-type modules attach it for you; on a plain
site you attach it yourself.

To add topics to a content type, add a field that reuses the existing
`localgov_topic_classified` storage:

1. Go to the content type's **Manage fields** (for example **Structure → Content
   types → [your type] → Manage fields**).
2. Add a field and choose to **re-use** the existing
   `localgov_topic_classified` field, rather than creating a new one, so all
   content types share the same storage.
3. Point its reference target at the **Topic** (`localgov_topic`) vocabulary.

Once attached, editors can tag content with one or more topics when authoring.

## The Topics reference view

If Views is installed, the module also ships an optional **Topics** view
(`views.view.topics`) built on the Topic vocabulary. It has three displays:

- **default** — a page-style listing of topic term names, each linked to its term
  page. Useful as a simple topic index.
- **Private topics** (`entity_reference_1`) — an entity-reference selection
  display that includes both published and unpublished terms; suitable for admin
  selection.
- **Public topics** (`entity_reference_2`) — the same, but filtered to published
  terms only.

To let editors pick only **published** topics on a topic reference field, set that
field's reference method to **View** and choose `topics: entity_reference_2`
("Public topics") as the selection view.

## Roles integration (optional)

The module includes one small piece of code that grants the LocalGov **Editor**
role the *create*, *edit*, and *delete terms in localgov_topic* permissions — but
this only takes effect when the optional **LocalGov Roles** (`localgov_roles`)
module is installed. On a plain site (without `localgov_roles`), grant those core
taxonomy permissions yourself at **People → Permissions**
(`/admin/people/permissions`).

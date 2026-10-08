# Configuration

Entity Term needs configuration before it does anything. You tell it which
entities should have matching terms by defining one or more **entity term sets**,
each of which maps an entity type and bundle to a target vocabulary.

## Open the settings form

1. Log in as a user with the **Administer Entity Term** (`administer_entity_term`)
   permission.
2. Go to **Configuration → System → Entity Term**, or navigate directly to
   `/admin/config/system/entity_term`.

## Define an entity term set

Each set answers three questions:

- **Entity type** — the kind of entity to watch, for example *Content* (nodes).
- **Bundle** — the specific bundle within that type, for example the *Person*
  content type. Only entities of this bundle are synced.
- **Vocabulary** — the taxonomy vocabulary that will hold the matching terms. Give
  it its own vocabulary so that its terms are managed entirely by this module.

You can add more than one set to sync several bundles, each to its own vocabulary.

## Save and let the batch run

When you save the form, the module runs a **batch process** that creates one term
for each existing entity of the configured type and bundle — so an already
populated content type is brought into sync immediately, not just going forward.
After that initial pass, the module keeps everything current automatically:
creating an entity creates its term, renaming the entity renames the term, and
deleting the entity deletes the term.

## What editors will see afterwards

Terms created by a set are "locked" to protect the 1:1 link. On a synced term's
edit form the **name field is disabled**, the **delete link is hidden**, and a
validation guard blocks any attempt to change the label — editors are directed to
edit the source entity instead. When a synced term is rendered or linked, its URL
points to the source entity's canonical page rather than the term page.

## Important: removing a set deletes its terms

If you remove a set's configuration, the module deletes **every** term in that
vocabulary whose label matches an entity of the configured type and bundle —
including terms that existed before you set things up. Keep synced vocabularies
dedicated to this purpose, and keep entity labels unique per bundle so the 1:1
match always resolves to the right term.

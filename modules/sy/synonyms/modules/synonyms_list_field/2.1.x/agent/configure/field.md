# Configure the Synonyms list field

The field exists automatically on every content entity type once the submodule is enabled — you only
choose where it shows and whether to include the label.

## Show it

*Manage display* for the bundle (e.g. `admin/structure/types/manage/article/display`, or a taxonomy
vocabulary's term display) → move the **"Synonyms list"** field out of *Disabled*, pick a format, *Save*.
It is `view`-configurable only (read-only, not on forms).

## The one global setting

Route `synonyms_list_field.settings` → `/admin/structure/synonyms_list_field/settings`
(perm `administer site configuration`). Config `synonyms_list_field.settings`:

| Key | Type | Default | Effect |
|---|---|---|---|
| `include_entity_label` | boolean | FALSE | When TRUE, the entity's own label is added to the rendered synonyms list. |

The field is **computed** (`SynonymsFieldItemList`): it stores nothing and returns the values from the
entity's configured synonym providers (`synonyms.provider_service`) at render time, so it always
reflects current Synonyms configuration and never needs reindexing.

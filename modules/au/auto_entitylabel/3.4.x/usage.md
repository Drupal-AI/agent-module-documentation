Automatic Entity Labels generates the label (title/name) of any entity from a configurable token pattern and can hide the label field on the entity form, so editors never have to type titles by hand.

---

Many entity types require a label — node titles, comment subjects, taxonomy term names, media names, custom entity labels — but for some content that label is redundant or better derived from other fields. This module adds an "Automatic label" tab to each bundle's configuration (e.g. a content type at `/admin/structure/types/manage/article/auto-label`) where you choose one of four behaviors: disabled, automatically generate and hide the field, generate only if left empty (optional), or prefill the field. The generated value comes from a token pattern such as `[node:author] — [node:created:medium]`, resolved with the Token system. It can strip special characters, preserve labels on already-created content, and generate the label either before the first save (fast) or after (supports id-based tokens at the cost of a second save). Labels can be regenerated in bulk for existing content via a batch "Re-save" action. Permissions are created per entity type so you can delegate who may configure automatic labels. Developers can enable support for additional/custom entity types and post-process generated labels through hooks.

---

- Auto-generate node titles from other fields so authors never type a title.
- Hide the title field entirely on a content type's edit form.
- Name comment subjects automatically from the comment body or author.
- Generate taxonomy term names from a pattern.
- Auto-name media entities on upload (e.g. from the file name).
- Label custom/ECK entities that have no meaningful user-entered title.
- Build a label from multiple fields, e.g. `[node:field_first] [node:field_last]`.
- Include dates in labels like `Order [node:created:custom:Y-m-d]`.
- Make the title optional and only auto-fill it when left blank.
- Prefill the title field so editors can tweak the suggested value.
- Strip special characters from generated labels for clean output.
- Preserve titles on content that already exists when enabling the feature.
- Generate labels after save so `[node:nid]`-style tokens resolve correctly.
- Generate labels before save for speed when id tokens are not needed.
- Bulk re-save existing content to apply a new label pattern retroactively.
- Process content in configurable chunks during bulk re-save to avoid timeouts.
- Delegate label configuration per entity type with dedicated permissions.
- Enforce consistent, deduplicated titles across an editorial team.
- Auto-title paragraphs or inline entities used only as building blocks.
- Create human-readable labels for imported/migrated content lacking titles.
- Derive profile labels from the referenced user account.
- Combine static text with tokens, e.g. `Invoice [node:field_number]`.
- Enable automatic labels for an entity type provided by a custom module via a hook.
- Alter the final generated label in code before it is stored.

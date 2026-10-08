# Configuration

Taxonomy Container has no central admin page. You configure it **per field**, on
whichever taxonomy term reference field should show a grouped dropdown. This can
be a field on any entity type — content, media, users, paragraphs — as long as it
references taxonomy terms.

## Before you start

Grouping only makes sense for a **hierarchical** vocabulary — one where terms have
parent/child relationships. If every term is top‑level, there are no groups to
form. So make sure your vocabulary has parent terms with children under them.

## Enable grouped selection on a field

1. Go to **Structure → [your entity type] → Manage fields** and edit the taxonomy
   term reference field you want to change (or the field's settings /
   *Reference* section).
2. Set **Reference method** to **"Taxonomy term selection (with groups)"**.
3. (Optional) Under **Vocabularies**, restrict the field to the vocabulary or
   vocabularies you want, exactly as you normally would. Each selected vocabulary
   is grouped on its own.
4. Set the **List item prefix** — a short string (1 to 5 characters) placed before
   each child term's label to show indentation. The default is a dash (`-`). It
   repeats once per level of depth, so a grandchild gets two prefixes, and so on.
   Common choices are `-`, `–`, or `»`.
5. Save the field settings.

## Use a select or checkboxes widget

On the **Manage form display** tab for the same bundle, make sure the field uses a
**Select list** (or checkboxes) widget rather than an autocomplete widget. The
grouping only appears on the plain select path — if the field is set to
autocomplete, the module deliberately falls back to core's normal flat behaviour.

## What the grouped dropdown looks like

- Each **root (top‑level) term** becomes an `<optgroup>` heading. Once a root term
  has at least one child, the root itself is no longer selectable — it's a header
  only.
- **Child terms** appear under their parent group, each prefixed by your chosen
  character to show its depth.
- Only the **first** level of the hierarchy creates group headings. Grandchildren
  and deeper terms are still shown (indented further with extra prefixes) but stay
  inside their top‑level group rather than forming their own nested groups.
- **Access is respected**: a term the current user can't view is hidden, and so
  are the children of any parent the user can't view. Labels are safely escaped.

## Things to be aware of

- **No auto‑create.** Because grouped options aren't compatible with
  autocomplete‑style creation, this handler intentionally hides the core "Create
  referenced entities if they don't already exist" option. Editors can't spawn new
  terms from this widget — which is often exactly what you want.
- **Autocomplete falls back to flat.** If you later switch the field to an
  autocomplete widget, you'll lose the grouping and get core's standard flat
  matching instead.

# Configuration

Setting up Field Label Visibility is a two-stage job: first you tell the module
*which content types* should expose the per-widget label controls, then you
configure each field's label on that content type's **Manage form display**.

## Stage 1 — enable the controls per content type

1. Log in as a user with the **Administer Field Label Visibility** permission.
2. Go to **Configuration → User interface → Field Label Visibility**
   (`/admin/config/user-interface/field-label-visibility`).
3. Tick the **content types** where the per-widget label controls should appear.
4. Click **Save configuration**.

Only the content types you select here will show the extra label options on their
form widgets — everything else is left untouched.

## Stage 2 — configure a field's label on Manage form display

1. Go to **Structure → Content types → *(a selected type)* → Manage form display**.
2. Click the **gear icon** next to the field widget whose label you want to
   change.
3. The widget's settings panel now includes Field Label Visibility controls:

   - **Hide label** — removes the label element from the rendered form entirely
     (Drupal's `#title_display` is set to `none`). The input keeps its accessible
     name, so screen readers still announce the field correctly; only the visible
     label is gone.
   - **Custom label text** — replaces the default label wording. It has an
     optional **Singular / Plural** mode: enter the text as `Singular|Plural` and
     Drupal core decides which form to show, using the active language's plural
     rules and the number of items the field currently holds. Languages whose
     plural rules define more than two forms are handled by core.
   - **Inline format toolbar** — CKEditor-style controls for the label:
     **alignment** radios (left, center, right) and three **formatting toggles**
     (bold, italic, underline). Each one is applied as a CSS class shipped by the
     module — the module never writes inline styles.
   - **Inline wrapper tag** — optionally wraps the label text in `span`, `small`,
     or `mark` (the only phrasing-content tags valid inside a `<label>`). The
     surrounding `label for="…"` stays in place.
   - **CSS classes** and **id** — free-text boxes for extra styling hooks. Both
     are validated when you save (invalid class tokens and ids are rejected), so
     you can only enter values that produce valid CSS identifiers.

4. Set the options you want and **Update** the widget, then **Save** the form
   display.

## How the three modes fit together

- **Default** (no wrapper tag) — your custom id and CSS classes flow onto the
  native label through Drupal's form-element preprocessing.
- **Wrapper** (`span`, `small`, `mark`) — the label *text* is wrapped in the tag
  you chose, and the `label for="…"` element is preserved around it.
- **Hide** — the label is not rendered at all.

In every mode the input's accessible name is either preserved (with your custom
text and attributes) or removed cleanly along with the label, so the form stays
accessible.

## A note on safety

The module validates and re-checks everything before rendering: wrapper tags are
restricted to the `span` / `small` / `mark` allowlist, CSS class tokens are
filtered, an invalid id is discarded, alignment is limited to left/center/right,
and the label text is escaped before it is injected. You can use the classes and
ids freely without worrying about breaking the markup or opening an injection
hole.

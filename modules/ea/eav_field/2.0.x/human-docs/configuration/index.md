# Configuration

Setting up EAV Field is a two-step story: first you **define the attributes**,
then you **attach one EAV field** to the bundle that should carry them.

## 1. Define your attributes

1. Log in as a user with the **Administer EAV attributes** (`administer eav
   attributes`) permission.
2. Go to **Structure → EAV → Attributes** (`/admin/structure/eav/attributes`).
3. Click **Add attribute** and give it a name.

Each attribute has its own set of local tabs where you configure how it stores,
edits, and displays its value:

- **Storage** — the value field type (string, long text, integer, decimal,
  boolean, entity reference, or a list/options type) and its cardinality.
- **Field** — value field settings such as whether it is required and any allowed
  values.
- **Widget** — the form widget editors use to enter the value.
- **Formatter** — how the value is displayed on the rendered entity.

You can reorder attributes with the weight/sort control.

### Global vs. category-scoped attributes

Each attribute can optionally be given a **category** (a taxonomy term):

- **Leave the category empty** to make the attribute **global** — it applies to
  every host that has an EAV field.
- **Set a category** to scope the attribute. EAV then matches it to a host entity
  by comparing the host's entity-reference field to the attribute's category,
  including parent terms — so an attribute on a parent term is inherited by hosts
  referencing its children.

## 2. Attach the EAV field to a bundle

1. Go to the target bundle's **Manage fields** screen (for example a content
   type, media type, or any fieldable bundle).
2. Add a field of type **EAV**.
3. If you use category-scoped attributes, also give the bundle an
   **entity-reference field** pointing at the same taxonomy vocabulary your
   attribute categories use. That reference is what EAV compares against to decide
   which attributes apply to each item.

## 3. Edit and view values

Editors enter attribute values in one of two places:

- Directly on the **host entity form**, alongside the entity's other fields.
- On the dedicated **Edit EAV** local task tab at
  `{entity-path}/edit-eav/{field_name}`, which requires **update** access to that
  entity.

Which attributes appear for a given item is worked out automatically: EAV shows
all global attributes plus any whose category (and its parent terms) match the
host's category reference.

## Optional: search indexing

If you install the companion **Search API EAV Field** module, EAV values can be
indexed through a Search API processor so they are searchable like any other
field.

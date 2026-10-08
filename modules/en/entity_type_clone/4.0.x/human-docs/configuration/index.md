# Configuration

Entity Type Clone has no persistent settings — instead it gives you two admin forms that
perform the cloning. Both require the **Access Entity Type Clone** permission.

## Clone a bundle

Go to **Configuration → Development → Entity Type Clone**
(`/admin/config/entity-type-clone`). (You can also click the **Clone** operation on a
content type, vocabulary, paragraph type or profile type listing to arrive here with the
source pre-selected.)

Fill in the form:

- **Select Entity Type** — choose what kind of thing to clone: *Content type*, *Vocabulary*,
  *Block type* — plus *Paragraph type*, *Profile type* and *Storage type* if those modules
  are installed. Changing this refreshes the bundle list below.
- **of type** — the **source** bundle to copy from.
- **Target bundle name** — the human-readable label for the new bundle.
- **Target bundle machine name** — the machine name for the new bundle (limited to 32
  characters and checked for uniqueness).
- **Description** — an optional description for the new bundle.

Click **Clone** to run the copy as a batch (or **Reset** to clear the form). When it
finishes you get a confirmation like *"'X' type and N field(s) cloned successfully to
'Y'."* and are returned to the form.

### What a bundle clone copies

- The bundle entity itself (label, machine name, description).
- Every **bundle-level field** on the source (base fields are core's and are not copied;
  taxonomy's *parent* field is skipped).
- Every **enabled** form-mode display and view-mode display, including field-group and other
  third-party display settings, and which extra fields (links, title, etc.) are visible.

### What it does *not* do

- It does **not** copy content — no nodes, terms or blocks are duplicated.
- Taxonomy clones create a **fresh** vocabulary, so vocabulary-level settings are not carried
  over.
- Displays are copied by string-replacing the old bundle machine name with the new one. As
  the form warns on screen, **review a cloned bundle before you export configuration or
  create content in it** — a machine name that happens to be a substring of other values can
  produce surprises.

## Clone a role

Go to `/admin/config/role-clone` (linked from the bundle-clone form). Choose an existing
**role**, give the clone a new **label** and **machine name**, and submit. The new role is
created with **exactly** the source role's permission list — a good starting point for a
"restricted" variant you then trim down.

Note that only the permissions are copied; other role properties (the "administrator" flag,
weight, and so on) are **not** carried over, so set those on the new role afterwards if you
need them.

## Good to know

- A user with the permission can clone *any* clonable bundle or role on the site — the forms
  are not access-checked per bundle.
- Cloning is a one-shot action, not an ongoing sync: later changes to the source are not
  reflected in the clone.

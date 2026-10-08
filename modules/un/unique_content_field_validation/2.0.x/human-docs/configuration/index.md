# Configuration

There is no central settings page. Instead, you turn uniqueness on **inline**, in
one of three places depending on what you want to keep unique. In each case you tick
a **Unique** checkbox and can supply a custom error message. The choice is saved as
a third‑party setting on that config and is enforced when the entity form is saved.

## 1. Make a field's value unique (per bundle)

1. Go to **Structure → Content types → &lt;type&gt; → Manage fields**, then **Edit**
   the field.
2. In the **Unique** section:
   - Tick **Unique** to require the value to be unique among entities of this bundle.
   - Optionally fill in **Unique message validation** — the error shown on a
     duplicate. It supports two tokens: **`%label`** (the field label) and
     **`%value`** (the duplicate value the user entered).
   - For **multi‑value** fields there are two extra options: **Do not allow same
     value**, which prevents the *same value appearing twice within the one field*,
     and its own message.
3. Save.

The **Unique** option only appears for these field types: email, link, decimal,
float, integer, list (float/integer/string), entity reference, text (plain, long,
with summary), string (plain, long), and webform. When a value clashes with another
entity of the same bundle and language, the form shows the error and won't save.

## 2. Make a content type's title unique

1. Go to **Structure → Content types → &lt;type&gt; → Edit**.
2. In the **Unique** section (under the submission form settings), tick **Unique**
   to require the **title** to be unique for this content type, and optionally set a
   message (again supporting `%label` and `%value`).
3. Save.

From then on, saving a node of that type with a title that already exists on another
node of the same type is rejected.

## 3. Make a vocabulary's term names unique

1. Go to **Structure → Taxonomy → &lt;vocabulary&gt; → Edit**.
2. In the **Unique** section, tick **Unique** to require each term **name** in this
   vocabulary to be unique, and optionally set a message.
3. Save.

## How the checks behave

- **Scope** — uniqueness is checked **per bundle** (this content type / this
  vocabulary / this field's bundle) and **per language**. The same value can exist in
  a different bundle or a different language.
- **Editing is safe** — the current entity is excluded from the check, so re‑saving
  an unchanged entity never trips the validation.
- **Turning it off** — simply uncheck the **Unique** box (or remove the third‑party
  setting). There is no global switch.
- **Custom messages** — use `%label` and `%value` in your message text to name the
  field/title and echo back the duplicate value, so editors immediately see what
  conflicted.

## Exporting the settings

Because the choices are stored as third‑party settings on the field, node‑type, or
vocabulary config, they travel with your configuration when you export/import — no
separate settings object to manage.

# Configuration

Setting this module up has two parts: a one‑time **global setting** for which
field types may use the widget, and then a **per‑field** step where you switch a
field's form widget over and point it at a View.

## Global settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Entity Reference Views Search**
   (`/admin/config/entity-reference-views-search`).

The form has one setting:

- **Allowed field types** — a comma‑separated list of the field types the widget
  is allowed to attach to. The default is `string, email, entity_reference`. Only
  field types listed here will offer *Entity Reference Views Search* as a widget
  choice on the Manage form display screen. Keep this list tight, and — as noted
  below — keep sensitive entity types out of it.

Click **Save configuration** when done.

## Attach the widget to a field

1. Build (or reuse) a **View** that lists the entities you want editors to pick
   from. Add the module's **select** field to it — that is the Views field plugin
   which renders the per‑row "select" button. Use the View's exposed filters,
   sorts and pager to shape how editors search the candidate list.
2. Go to the bundle that owns your reference (or string/email) field, for example
   **Structure → Content types → *(your type)* → Manage form display**.
3. For the field, change its **Widget** to **Entity Reference Views Search**.
4. Open the widget's settings (the gear icon) and choose which **View and
   display** supplies the candidate rows.
5. Save the form display.

When an editor now edits that content, they see the embedded View next to the
field. Searching and clicking a row's select button writes the chosen entity's ID
into the field and renders that entity (in its *default* view mode) as an inline
preview.

## Security note — restrict which entities are pickable

The AJAX endpoint that loads and renders the preview is gated only by the core
*access content* permission and does **not** perform an additional per‑entity
view‑access check before rendering the selected entity's default view mode. A
crafted request could therefore preview an entity a user would not normally be
allowed to see. To stay safe:

- Keep sensitive entity types out of the **Allowed field types** list above.
- Only build picker Views over non‑sensitive content, and let the View's own
  filters constrain what can be selected.

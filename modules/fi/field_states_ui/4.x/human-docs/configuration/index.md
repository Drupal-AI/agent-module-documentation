# Configuration

Field States UI has **no central admin page**. You configure it per field, in the
widget settings on a bundle's **Manage form display** page. Each "field state" you
add says: *make this field do X when that other field is Y.*

## Open the widget's field‑states settings

1. Go to the bundle's **Manage form display** page — for a content type, that's
   **Structure → Content types → [your type] → Manage form display**
   (e.g. `/admin/structure/types/manage/article/form-display`). Users, taxonomy
   terms, media, paragraphs, and other entity types have the same tab.
2. Find the field you want to control — the one that should appear, hide, become
   required, and so on.
3. Click the **gear / cog** icon at the end of that field's row to open its widget
   settings.
4. In the settings you'll see **Manage Field States**.

## Add a field state

In **Manage Field States**:

1. Choose a **state** — the behaviour to apply. The built‑in states are:

   | State | What it does when the condition matches |
   |-------|------------------------------------------|
   | **visible** / **invisible** | Show or hide the field. |
   | **required** / **optional** | Make the field required, or drop the requirement. |
   | **enabled** / **disabled** | Allow editing, or grey the field out. |
   | **checked** / **unchecked** | Tick or untick a checkbox automatically. |
   | **expanded** / **collapsed** | Open or close a details/fieldset element. |

2. Click **Add**, then fill in the condition:

   - **Target field** — the machine name of the *other* field on the same form
     whose value is watched.
   - **Comparison** — how to test the target. `value` means "equals the value you
     type below"; other comparisons mirror the States API: `empty`, `filled`,
     `checked`, `unchecked`.
   - **Value** — the value to compare against. This is used when the comparison is
     `value` (for the state‑style comparisons like `filled` the comparison itself
     is the trigger, so the value is not needed).

3. Click **Update**, then **Save** the form display.

The widget's summary line now lists the states you configured. On the actual
entity form, the field will react live as the target field changes — for example
"visible when *Country* is *Canada*".

## Combining and stacking states

A single field can carry **several** states at once — the settings store them as a
list. So you can, for instance, make one field *visible when X* **and** *required
when Y* by adding two states to it. Add as many as the logic needs.

## Where the configuration lives

Everything you configure is stored as a third‑party setting on the widget inside
the form‑display configuration entity
(`core.entity_form_display.<entity>.<bundle>.<form_mode>`), so it is exported and
deployed as part of your form‑display config. To inspect a field's states from the
command line:

```bash
drush cget core.entity_form_display.node.article.default content.field_detail
# look under third_party_settings.field_states_ui.field_states
```

Because states are stored per form mode, you can give a field different conditional
behaviour in a custom form mode than in the default one.

## Extending the available states

Developers can add new state types by writing a custom **FieldState** plugin (the
module defines a `field_states_ui.fieldstate` plugin type). See the agent docs at
[`agent/plugins/field-state.md`](../agent/plugins/field-state.md) for the plugin
interface and base class.

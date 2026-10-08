# Configuration

Label Help has no central settings page. You add help text **per field**, from that
field's own settings form. This page covers how to do that, where the text is stored,
how it is themed, and the developer debug options.

## Add help text to a field

1. Log in as a user who can administer the entity's fields (an administrator by
   default).
2. Go to the field's edit form. For a content-type field that is **Structure →
   Content types → *(your type)* → Manage fields**, then **Edit** on the field
   (e.g. `/admin/structure/types/manage/article/fields/<field>`).
3. Find the **Label help message** textarea that Label Help adds to the form.
4. Type the guidance you want to appear below the field's label.
5. Save the field.

The help text now shows on every entity edit form that uses this field, positioned
next to the label. To remove it later, clear the textarea and save again — emptying
it unsets the setting entirely.

## Where it is stored

The message is saved as a third-party setting on the field's configuration entity
(`field.field.<entity_type>.<bundle>.<field_name>`), so it is included in
configuration exports and deploys with the rest of your config. Because it is config,
it can also be translated per language through Drupal's configuration translation.

## How placement works

You do not need to do anything for placement — Label Help figures it out. Because
Drupal widgets differ so much (plain textfields, checkboxes and radios, fieldsets,
details elements, datetime, link fields, autocomplete, select lists, multi-value
tables, and custom elements), the module runs a cascade of around eighteen
widget-specific rules to insert the text at the right spot near the label, with a
fallback if a widget is unusual. This is why the help lands sensibly whether the
field is a single textfield or a complex multi-value widget.

## Theming

The help text is rendered through a themeable element with dedicated CSS and
templates for the **Seven**, **Claro**, and **Gin** admin themes, attached
automatically based on the active theme stack. In most cases it will look right out
of the box; if you use a custom admin theme you can override the `label_help`
template to restyle it.

## Setting help text from code

For forms you build in code (that are not driven by a field), a developer can set the
same help text directly on a form element with the `#label_help` property — no field
configuration involved. See the [`agent/`](../agent/start.md) docs for an example.

## Debugging placement (settings.php)

If help text lands somewhere unexpected on an unusual widget, two flags in
`settings.php` help a developer diagnose it:

- `$settings['label_help_debug'] = TRUE;` — annotates each rendered help message with
  the internal "use case" number and placement, so you can see which rule fired.
- `$settings['label_help_debug_dump'] = TRUE;` — dumps the element render arrays (this
  may disrupt page rendering; that is expected while debugging).

Leave both off in production.

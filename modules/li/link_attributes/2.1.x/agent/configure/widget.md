# Enable the widget and pick attributes

On the entity's **Manage form display**, set a Link field's widget to
**Link (with attributes)** (`LinkWithAttributesWidget`). Then open the widget settings gear.

Widget settings (schema `field.widget.settings.link_attributes`):

| Setting | Meaning |
|---|---|
| `enabled_attributes` | Map of attribute id → bool; which attribute inputs are shown. |
| `placeholder_url` | Placeholder text for the URL field. |
| `placeholder_title` | Placeholder text for the link-text field. |
| `widget_default_open` | Whether the attributes details panel starts open (`''`/`open`). |

Built-in attributes (from `link_attributes.link_attributes.yml`): `id`, `name`, `target`
(select: `_self`/`_blank`), `rel`, `class`, `accesskey`, `aria-label`, `title`.

Attribute values are saved into the link field item's `options['attributes']` and rendered
automatically wherever the link is output. The trait `LinkWithAttributesWidgetTrait` holds
the shared form logic (reused by the Linkit submodule).

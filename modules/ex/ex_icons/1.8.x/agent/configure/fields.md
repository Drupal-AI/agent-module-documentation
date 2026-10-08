# Field API integration

## Field type `ex_icon` (`Plugin/Field/FieldType/ExIconItem`, extends StringItemBase)

Stores two columns: `value` (icon id, varchar 127, required, mainProperty) and `title` (text
alternative, varchar 255). Field setting `title` (radios): `DRUPAL_DISABLED` / `DRUPAL_OPTIONAL` /
`DRUPAL_REQUIRED` — controls whether the text alternative is hidden, optional, or required. Storage
setting `case_sensitive` (schema `field.storage_settings.ex_icon`). Default widget `ex_icon_select`,
default formatter `ex_icon_default`.

## Widget `ex_icon_select` (`ExIconSelectWidget`)

Renders the `ex_icon_select` visual picker for `value` plus a `title` textfield (shown per the field's
`title` setting). Adds validation: if the `title` setting is REQUIRED, title is required when an icon is
chosen; conversely an icon is required if a title is entered (OPTIONAL/REQUIRED). Wraps in a fieldset (or
inlines the label) depending on cardinality and whether title is disabled.

## Formatter `ex_icon_default` (`ExIconDefaultFormatter`)

Applies to `ex_icon`, `list_string`, and `string` fields. Renders each item as
`['#theme' => 'ex_icon', '#id' => $item->value, '#title' => $item->title, '#attributes' => filtered
width/height]`. Settings: `width`, `height` (textfields). If only one is set and numeric, the other is
computed from the icon's viewBox aspect ratio in `template_preprocess_ex_icon()`.

## Formatter `ex_icon_link` (`ExIconLinkFormatter`, extends the default)

Applies to `link` fields — renders the link but with an icon as its content instead of text. Settings add
`icon` (required, chosen via `ex_icon_select`), `rel` (checkbox → `nofollow`), `target` (checkbox →
`_blank`), plus inherited width/height. The link title is the field label, or, when the link item has a
title, that title with tokens replaced (`token` service, `['clear' => TRUE]`, data = the host entity).

## Config schema

`config/schema/ex_icons.schema.yml` defines `field.storage_settings.ex_icon`,
`field.field_settings.ex_icon`, `field.value.ex_icon`, `field.formatter.settings.ex_icon_default`,
`field.formatter.settings.ex_icon_link`, and `field.widget.settings.ex_icon_select`.

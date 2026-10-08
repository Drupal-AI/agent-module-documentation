# ala — widget & formatter

Both apply to the core `link` field type. Configure on *Manage form display* (widget) and
*Manage display* (formatter). Schemas: `field.widget.settings.ala_field_widget` and
`field.formatter.settings.ala_field_widget`.

## Widget `ala_field_widget` (`AdvancedLinkAttributesFieldWidget extends LinkWidget`)

Widget **settings** (`settingsForm`), each toggling advanced sub-fields on the edit form:
- `ala_link_class_settings` — `''` (Disabled) | `global` (use `ala.settings.ala_default_classes`) |
  `custom` (use `ala_link_class`).
- `ala_link_class` — textarea of `key|label` class lines (used when mode = custom).
- `ala_link_icon` (bool) — show an "Icon Class" textfield.
- `ala_link_roles` (bool) — show a "Visible for" role multi-select.
- `ala_link_color` (bool) — show Text Color / BG Color textfields (attaches `ala/color` JS).
- `ala_link_target` (bool, default 1) — show a target `<select>` (`_self/_blank/_parent/_top`).
- `ala_link_extra` (bool) — show textfields for each name in `ala.settings.ala_extra_attributes`.

`formElement()` reads the link item's `options` and renders an "Advanced settings" details group with
the enabled sub-elements. All values are written back into the link item's serialized `options`
(`class`, `icon`, `color`, `bgcolor`, `roles`, `attributes.target`, and extra attribute keys).

## Formatter `ala` (`AdvancedLinkAttributesFieldFormatter extends LinkFormatter`)

Formatter **settings** (on top of inherited core Link settings `trim_length`, `url_only`, `url_plain`,
`rel`, `target`):
- `ala_link_view_class` — `element` (class on the `<a>`) | `parent` (class on the wrapper; applied by
  `ala_preprocess_field()` reading `options['parent_classes']`).
- `ala_link_view_icon` — `inside` (emit `<i class="…">` in the title) | `class` (append icon to the
  link's class attribute) | `data` (as data attr).
- `ala_link_view_icon_position` — `left` | `right` (only for `inside`).
- `ala_link_view_roles` — `hide` (remove the element) | `hidden` (visually hidden).
Defaults: `trim_length=80`, `ala_link_view_class=element`, `ala_link_view_icon=inside`,
`ala_link_view_icon_position=left`, `ala_link_view_roles=hide`.

`viewElements()` behaviour:
- Link **title** is token-replaced with `['clear' => TRUE]` — intentionally unsanitized because the
  link generator auto-escapes the title during render (`LinkGenerator::generate()`).
- **Colours:** `options['color']`/`options['bgcolor']` become an inline `style="color:…;background-color:…"`.
  These editor-entered values are concatenated into the style attribute.
- **Icon (mode `inside`):** renders an `<i class="…">` element holding the icon value next to the link
  title. `inside` is the default icon mode. Modes `class`/`data` put the icon into an attribute instead.
- **Role visibility:** if `options['roles']` is set and doesn't include `all`, the delta is unset when the
  current user shares none of the selected roles (display-time hide, not an access control).

## Notes for agents

- To constrain class choices, prefer the global list (`ala.settings.ala_default_classes`) so the widget
  offers a `<select>` rather than free text.

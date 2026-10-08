# bootstrap_styles — agent start

Foundation styling engine for Layout Builder: two plugin types (`StylesGroup` tabs +
`Style` controls) and the `StylesGroupManager` service build style form elements, save chosen
values, and attach CSS classes to section/block builds on render. It does **not** add UI to
Layout Builder itself — consumer modules (chiefly **bootstrap_layout_builder**) call the
manager. Option classes live in one config object `bootstrap_styles.settings`. Depends on core
`layout_builder` + `media_library_form_element`. Config UI: **Admin → Config → Content
authoring → Bootstrap Styles** (`/admin/config/bootstrap-styles/settings`), route
`bootstrap_styles.settings`, permission `configure bootstrap styles`.

- Settings form, option class lists, groups/plugins, config keys → [configure/settings.md](configure/settings.md)
- Add a custom `@Style` / `@StylesGroup` plugin; the two managers → [plugins/bootstrap_styles.md](plugins/bootstrap_styles.md)
- Apply/render styles in code via `StylesGroupManager` + `bootstrap_styles_info` alter → [api/bootstrap_styles.md](api/bootstrap_styles.md)

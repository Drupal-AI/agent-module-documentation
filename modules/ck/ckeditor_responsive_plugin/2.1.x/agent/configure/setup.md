# Enabling the Responsive Area plugin

There is no module-specific settings page; everything is done through core's text-format /
CKEditor 5 configuration. The `configure` route is `filter.admin_overview`
(`/admin/config/content/formats`).

## Steps

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) and edit a format that uses **CKEditor 5**
   (e.g. Full HTML: `/admin/config/content/formats/manage/full_html`).
2. In the CKEditor 5 toolbar configuration, drag the **Responsive Area** button from
   *Available buttons* into the *Active toolbar*.
3. If the format uses **"Limit allowed HTML tags and correct faulty HTML"**, add `<div class>`
   (and, as needed, the column/grid classes) to the allowed tags so the inserted markup is not
   stripped. The plugin also declares `<h2>` and `<div>` as required elements.
4. Save the format. The button now appears in editors using that format.

## Markup and classes produced

The plugin inserts `<div>` blocks with standard responsive classes:
- Column classes: `onecol`, `twocol`, `threecol`, … (`*col`).
- Grid classes: `grid-1`, `grid-2`, … (`grid-*`).

Style these with the bundled `css/responsivearea.css` or map them to your theme's own grid
(e.g. Bootstrap). If the classes don't render responsively, copy the needed rules from
`css/responsivearea.css` into your theme.

## Notes

- Libraries loaded: `ckeditor_responsive_plugin/responsivearea` in the editor,
  `admin.responsivearea` while configuring the toolbar.
- On install, the module shows a status message linking to the text-formats page and the
  README. No permissions or config entities are created.

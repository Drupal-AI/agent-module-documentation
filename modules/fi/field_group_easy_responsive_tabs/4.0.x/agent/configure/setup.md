# Setup — external library + building the tab group

There is no settings page. "Configuration" is (1) placing the third-party JS/CSS library, then
(2) creating a nested field_group structure and choosing the two formatters on a display.

## 1. Install the required jQuery library (mandatory)

The library `field_group_easy_responsive_tabs/easy-responsive-tabs` references these paths in
`field_group_easy_responsive_tabs.libraries.yml`, resolved from the **web root**:

- `/libraries/easy-responsive-tabs/js/easyResponsiveTabs.js`
- `/libraries/easy-responsive-tabs/css/easy-responsive-tabs.css`

It is **not** pulled by Composer. Download the "Easy Responsive Tabs to Accordion" jQuery plugin,
rename its folder to `easy-responsive-tabs`, and unpack it so those two files exist under the docroot
`libraries/` directory (here: `web/libraries/easy-responsive-tabs/…`). Without it, the init behaviour
calls an undefined `easyResponsiveTabs()` and no tabs/accordion form. (On this site the folder is
absent by default — install it before expecting output.)

## 2. Enable the modules

`field_group` (dependency) and `field_group_easy_responsive_tabs`. Both formatters need field_group's
UI.

## 3. Build the group nesting

On **Manage form display** (`admin/structure/…/form-display`) or **Manage display**
(`…/display`) of an entity bundle:

1. **Add group** → format **"Easy Responsive Tabs to Accordion - Tabs"** (`ertta_tabs`). This is the
   wrapper. Configure its settings (see plugins/formatters.md for every key): `type`
   (Horizontal/Vertical/Accordion), `width`, `fit`, `closed`, the four colour fields, and an optional
   unique `id`.
2. **Add group** one or more times → format **"Easy Responsive Tabs to Accordion - Tab"**
   (`ertta_tab`), and set each of these groups' **parent** to the `ertta_tabs` group. Each Tab
   group's **label** becomes a tab header in the navigation; the fields you drag into it become that
   tab's panel.
3. Drag the fields into the appropriate `ertta_tab` groups.

Because both formatters support `form` and `view` contexts, repeat on whichever display(s) you want
the tabs to appear (edit form, full/teaser view, etc.).

## Notes

- The `id` field is validated by field_group's `field_group_validate_id`; leave it empty to let the
  wrapper derive a stable id from `md5()` of its classes. Give an explicit `id` when you need to
  deep-link to a tab or run multiple tab sets on one page.
- Colour/width settings are emitted verbatim as `data-*` attributes and read by the JS plugin; they
  are optional and default to empty (the plugin/theme CSS then applies).
- No permissions are added — access to configure these groups is field_group's / core's display
  administration permission (e.g. *Administer <entity> display*).

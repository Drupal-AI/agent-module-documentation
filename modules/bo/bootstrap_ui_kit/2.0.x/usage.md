<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap UI Kit provides an in-site living style guide at `/ui-kit` that showcases your Bootstrap-5 theme's foundations and Single Directory Components, styled by your own theme.

---

Install it with `composer require drupal/bootstrap_ui_kit` and enable it with `drush en bootstrap_ui_kit`; it has **no Drupal module dependencies** and pulls one Composer library, `twbs/bootstrap-icons` (bundled under the module's `vendor/` and used as the default icon set). The only real prerequisite is that your active theme is **Bootstrap 5 enabled**, because the kit ships no Bootstrap CSS/JS of its own — components inherit your theme's colours, spacing and typography, and you can further tune the kit chrome with CSS custom properties like `--bootstrap-ui-kit--sidebar-bg-color`. Visit **`/ui-kit`** (grant the *Access the UI Kit page* permission, `access bootstrap ui kit`) to browse the guide. Configure it at **Configuration → User interface → Bootstrap UI Kit** (`/admin/appearance/bootstrap_ui_kit/settings`, requires *Administer site configuration*): toggle **Developer Kit** to expose example-code modals (also needs the *Access developer mode* permission), and set the **iconography source folder** and **SVG sprite file** plus which icons to display. The **Glossary** tab lets you add, rename, reorder and remove sidebar groups and sections by drag-and-drop; the **Sections** tab lists them; and each section's **Manage** screen lets you assign SDC components by `provider:machine` id, choosing a **variant**, a **story** YAML (auto-discovered from `components/*/stories/*.story.yml` in your custom modules/themes), or custom JSON props. Component previews render live via core SDC, with an extensible slot pipeline (register a service tagged `bootstrap_ui_kit.slot_type` to add new slot item types). Version 2 optionally integrates with SDC Display / Bootstrap Components so site builders can wire components to fields and view modes without touching templates.

---

- Add a living style guide / UI kit to a Bootstrap 5 site.
- Show all theme foundations (color, typography, iconography) in one place at `/ui-kit`.
- Preview Single Directory Components styled by your own theme.
- Give designers and editors a shared reference for on-brand components.
- Browse and search Bootstrap Icons on the iconography page.
- Configure which icons and SVG sprite the kit displays.
- Enable developer mode to show example code snippets for each element.
- Build a sidebar of custom groups and sections without writing code.
- Reorder or rename style-guide sections by drag-and-drop.
- Assign SDC components to a section with props, variants, or stories.
- Auto-discover component story YAML across a project or monorepo.
- Deep-link to a specific section and copy its URL to share.
- Check colour contrast for accessibility on the color section.
- Document a design system built on Bootstrap 5.
- Onboard developers with a self-documenting component catalogue.
- Reuse the bundled Bootstrap Icons SVG sprite site-wide.
- Extend slot rendering with a custom slot-type handler service.
- Restrict style-guide access with a dedicated permission.
- Keep component previews consistent across variants and overrides.
- Provide a QA reference for reviewing component markup and behaviour.

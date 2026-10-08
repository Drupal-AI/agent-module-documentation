<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Disable provides an admin UI to hide unwanted core, theme, or contrib layout plugins so they no longer appear in Layout Builder, Display Suite, or any layout selection list.

---

The module is a thin wrapper around Drupal's layout plugin system (`layout_discovery`). Its single admin form (route `layout_disable` at `/admin/config/user-interface/layout-disable`, permission `access layout_disable`) lists every discovered layout plugin as checkboxes; the layouts you tick are saved into the config object `layout_disable.settings` under the `disabled_layouts` key (an associative list keyed by layout plugin id, e.g. `layout_twocol_section: layout_twocol_section`). An implementation of `hook_layout_alter()` then removes those ids from the layout definitions with `array_diff_key()`, so disabled layouts vanish from every layout picker sitewide. The core-required layouts `layout_onecol` and `layout_builder_blank` are deliberately excluded from the form and cannot be disabled. Saving the form clears the layout plugin manager's cached definitions so the change takes effect immediately; changing the config directly requires a matching cache clear. There is no field, entity, or per-context scoping — it is a global on/off list of layout ids.

---

- Hide the four-column section layout so editors can't pick it in Layout Builder.
- Remove rarely used core layouts (e.g. `layout_twocol_bricks`) from the section picker.
- Restrict Layout Builder to an approved subset of layouts for editorial consistency.
- Disable a layout added by a contrib module or theme that shouldn't be used.
- Simplify the Display Suite / Layout Builder layout dropdown for non-technical users.
- Prevent use of a broken or deprecated layout without removing its providing module.
- Enforce a design system by disabling off-brand column arrangements.
- Curate which layouts appear when configuring an entity view display's layout.
- Turn off experimental layouts on a production site.
- Reduce editor confusion by trimming a long layout list to a few options.
- Keep the required `layout_onecol` while disabling all other multi-column layouts.
- Export the disabled-layout list as config (`layout_disable.settings`) for deployment.
- Standardise available layouts across a multisite via shared config.
- Temporarily hide a layout during a redesign, re-enabling it later by unchecking.
- Disable theme-provided layouts that conflict with a component library.
- Limit landing-page building to a small set of vetted section layouts.
- Remove a layout that renders poorly on mobile from the selection list.
- Hide contrib layouts (e.g. from Layout Builder Blocks or Bootstrap Layouts) selectively.
- Audit which layouts are intentionally disabled by reading the config.
- Roll back a disable by unchecking the layout and saving (clears the layout cache).
- Keep the layout picker consistent after installing a module that adds many layouts.
- Disable the navigation layout on sites that don't use it.
- Provide governance over layout options without writing a custom `hook_layout_alter()`.

Simplifying declutters the Drupal admin experience by hiding chosen toolbar tabs, admin menu links, entity-form fields, local task tabs and contextual links, so editors see a stripped-down administration UI.

---

Simplifying is a configuration-driven "less is more" admin tool. From a single settings form at `/admin/config/development/simplifying` an administrator (permission `access simplifying setting`, restricted) picks what to remove: toolbar tabs (home, administration, shortcuts, user, devel, contextual, search), individual admin **menu links** by path, **entity-form fields** (author/format/options/revision/menu/path/sitemap groups on node, user, comment, taxonomy-term and block_content forms), **local task tabs**, and **contextual links** by route. All choices live in the single config object `simplifying.settings` (rich schema, no config entities). Hiding is applied through Drupal hooks — `hook_form_*_alter` sets `#access = FALSE` on chosen fields, `hook_menu_local_tasks_alter` and `hook_toolbar` prune tabs, `hook_contextual_links_view_alter` drops contextual links, and `hook_preprocess_menu__toolbar` tags links for JS. An editor can flip into a temporary "full administration" mode (everything shown again) via a `simplifying` browser cookie (`js_cookie` dependency), read by `SettingsActions::isFullAdministration()`. The module also tracks newly created/deleted entities in its own `simplifying_entity_unread` table (an "unread" toolbar indicator), ships static "Order additional services" and "Training" marketing pages, and has optional integration with the contrib `basket` e-commerce module's admin menu. Three alter hooks (`hook_simplifying_get_fields_alter`, `hook_simplifying_hide_field_alter`, `hook_simplifying_hide_toolbar_tabs_alter`) let other modules extend the hidden lists. Note: all hiding is UI-level convenience (`#access`/pruning of admin chrome), not an access-control or permission mechanism.

---

- Hide the Devel toolbar tab from editors on a production site.
- Remove the "Shortcuts" or "User" tab from the admin toolbar.
- Strip rarely used admin menu links (cache flush links, `admin/modules`, `admin/config`) from the toolbar menu.
- Hide the "Authoring information" field group on the node edit form.
- Hide the "Menu settings" or "URL path settings" group on node forms for content editors.
- Hide the text-format selector on comment or taxonomy-term forms.
- Hide the "Revision information" group on node and custom-block forms.
- Hide the Roles / Status / Notify fields on the user edit form.
- Hide Simple Sitemap or SEO field groups added by contrib modules on entity forms.
- Remove local task tabs (e.g. Webform Results/Test, taxonomy Manage-fields tabs) editors should not use.
- Let editors toggle individual local-task tabs on/off from the page via an AJAX trigger button.
- Remove selected contextual (pencil-menu) links such as block or view edit links.
- Give editors a one-click "full administration" cookie toggle to temporarily reveal everything.
- Provide a cleaner, less intimidating admin toolbar for non-technical content teams.
- Surface an "unread"/new-entity indicator in the toolbar for recently created content.
- Reorder / prune the `basket` e-commerce module's admin settings menu.
- Localise the bundled Services/Training help pages (English, Ukrainian, Russian).
- Extend the list of hidden fields for a custom entity type via `hook_simplifying_get_fields_alter`.
- Programmatically add your module's own toolbar tabs to the hidden list via `hook_simplifying_hide_toolbar_tabs_alter`.
- Prevent Simplifying from hiding one of your custom fields via `hook_simplifying_hide_field_alter`.
- Present a role-appropriate, minimal editing form without writing a custom form_alter for each field.
- Reduce onboarding/support friction by removing admin options editors never need.
- Keep the default toolbar design (colours, small toggle button) themable via the settings form.
- Roll the whole simplified configuration between environments as ordinary config (`simplifying.settings`).

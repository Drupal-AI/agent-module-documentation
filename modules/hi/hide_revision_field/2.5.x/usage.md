<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hide Revision Field replaces the core "Revision log message" field widget on revisionable entity edit/create forms with a configurable widget, letting you hide that field (and optionally the whole revision tab) per entity type and bundle, by permission, or per user — so revisions are still created but editors see less noise.

---

Drupal creates a `revision_log_message` base field on every revisionable content entity (nodes, media, taxonomy terms, and module-added types) and renders it as a plain textarea on the add/edit form. Hide Revision Field registers a custom field widget, `hide_revision_field_log_widget` (a subclass of core's StringTextareaWidget), and via `hook_entity_base_field_info_alter()` makes the revision log field display-configurable and assigns it that widget on every entity type that has the field. All of its behavior is therefore stored in the standard `core.entity_form_display.{entity_type}.{bundle}.default` config entity, on the `revision_log` component's `settings`. The key settings are `show` (render the field by default or hide it), `hide_revision` (when the field is hidden, also hide the entire revision fieldset/tab and the "Create new revision" checkbox), `permission_based` (only show the field to users with the "access revision field" permission), `allow_user_settings` (let users override visibility per bundle on their own profile), and `default` (a default value for the log message). The module adds two permissions — `access revision field` and `administer revision field personalization` — and a per-user `revision_log_settings` base field on the user entity to store personal overrides. There is no dedicated settings page; you configure it on each bundle's "Manage form display" page (requires the core Field UI module) or by editing the form-display config directly. It sets its own module weight to 1 on install so its form alters run late.

---

- Hide the revision log message textarea on the Article node add/edit form while still recording revisions.
- Remove revision-log clutter from a specific content type without disabling revisions for that type.
- Hide the entire "Revision information" tab/fieldset (including the "Create new revision" checkbox) on a bundle's form.
- Show the revision log field only to trusted editors by granting them the "access revision field" permission.
- Keep the revision log hidden for most roles but expose it to a "Content lead" role via permission.
- Let individual users choose whether they see the revision log field, per content type, from their profile page.
- Give the revision log field a default message (e.g. "Edited via editorial workflow") for every new revision.
- Set the number of rows / a placeholder on the revision log textarea via the widget settings.
- Hide the revision field on Media entity edit forms to simplify the media library editing UX.
- Hide the revision log on taxonomy term forms for a cleaner vocabulary-management experience.
- Apply revision-field visibility consistently across environments by exporting the form-display config.
- Reduce cognitive load for non-technical site owners who never use revision log messages.
- Enforce a policy where only administrators can write custom revision log messages.
- Turn the revision log field back on for a bundle by flipping the widget's `show` setting.
- Configure revision-field visibility purely through the "Manage form display" UI, no code.
- Bulk-configure revision visibility across many bundles by editing `core.entity_form_display.*` config in code.
- Provide a per-user opt-in so power editors can still annotate revisions while others don't see the field.
- Hide the revision field on custom (module-defined) revisionable entity types automatically.
- Prevent accidental blank revision log messages by hiding the field and supplying a sensible default.
- Simplify a multi-field content form by dropping the rarely used revision log section.
- Combine per-bundle hiding with permission-based display so the field appears only for specific users on specific types.
- Streamline a headless/editorial dashboard by removing revision metadata from author-facing forms.
- Standardize editorial forms across a large site by disabling revision logs everywhere except workflow-critical types.
- Keep revisions enabled for audit/compliance while hiding the log field from the UI.

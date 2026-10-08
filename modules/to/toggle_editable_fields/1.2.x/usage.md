Adds a "Toggle Editable Formatter" for Boolean fields that renders the value as a Bootstrap
Toggle switch which the user can flip **directly in the display** (entity view or a Views
listing) to change the stored value over AJAX — no edit form, no page reload.

---

Toggle Editable Fields registers a single field formatter (`toggle_editable_formatter`) that
applies to `boolean` field types. Instead of printing "On/Off", the formatter builds one small
per-item Ajax form (`AjaxToggleForm`) containing a checkbox styled as a
[Bootstrap Toggle](https://github.com/minhur/bootstrap-toggle/) switch. Flipping the switch
fires a `change` AJAX event that re-saves the host entity with the new boolean value. The
formatter settings expose the Bootstrap Toggle options — custom On/Off labels, size
(large/normal/small/mini), on/off styles (default/primary/success/info/warning/danger), and
optional pixel height/width — stored via `field.formatter.settings.toggle_editable_formatter`
config schema. Access is enforced on every save: the switch is disabled and the write is
skipped unless the current user passes the field's `edit` access check and (absent a
field_permissions rule) the entity's `update` access. The switch renders anywhere the field is
displayed, including Views fields, so it works for bulk-style inline toggling of many rows. The
module requires the external `bootstrap-toggle` JS/CSS library placed under `/libraries` (a
`hook_requirements` warning fires if it is missing) and depends on `field`, `field_ui`, and the
contrib `libraries` module.

---

- Publish/unpublish nodes inline from a content listing by toggling the `status` boolean.
- Flip a "Featured" boolean on articles straight from a teaser or admin view.
- Toggle a "Sticky at top of lists" flag without opening the node edit form.
- Let editors mark a product "In stock / Out of stock" from a Views product grid.
- Enable/disable a user-profile boolean (e.g. "Subscribed to newsletter") in place.
- Toggle a taxonomy term's custom boolean flag from a term listing.
- Provide a one-click "Approved" switch on moderation dashboards built with Views.
- Turn a "Show in menu" boolean on/off directly on the entity display.
- Give content managers a fast "Highlight / Promote" switch on landing-page tiles.
- Toggle a paragraph's "Visible" boolean inside a rendered layout.
- Mark tasks "Done" from a project task list rendered as a view.
- Flip a "Verified" flag on submitted entities during review.
- Toggle "Comments open/closed" per node from an overview screen.
- Switch a media item's "Usable" boolean from the media library listing.
- Provide styled on/off switches (colored success/danger) for at-a-glance status columns.
- Use custom On/Off labels (e.g. "Yes"/"No", "Live"/"Draft") on the toggle.
- Size toggles down to "mini" for dense admin tables.
- Give reviewers a quick "Flagged for follow-up" switch on report rows.
- Toggle a "Send notifications" preference on a settings entity display.
- Let shop staff toggle "On sale" across a catalog view without bulk operations.
- Toggle an event's "Registration open" boolean from an events calendar list.
- Provide accessible switch UI for boolean fields in customer-facing dashboards (with proper access).
- Toggle a "Maintenance" boolean on infrastructure/asset entities inline.
- Flip an org unit's "Active" boolean from an admin roster.
- Replace clunky boolean checkboxes in read displays with a modern switch control.

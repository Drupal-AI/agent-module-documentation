Form Mode Control lets you decide which entity **form mode** (create/edit form) is used for a given bundle, per user role, and lets users switch form modes on the fly with a `?display=<form_mode>` URL query parameter.

---

Drupal core lets you build alternate *form modes* for an entity bundle (extra "Manage form display" tabs) but gives no UI to choose which one a given role actually gets. Form Mode Control fills that gap. It implements `hook_entity_form_display_alter()` to swap the active `entity_form_display` at form-build time based on two inputs: a stored default (choose, per entity type + bundle + operation `create`/`update` + role, which form mode is the default) and an ad-hoc `?display=<form_mode_id>` query parameter on the add/edit URL. Defaults are configured on one admin form at `/admin/structure/display-modes/form/config-form-modes` and saved into the `form_mode_control.settings` config object under a `defaults` tree keyed `entity_type → bundle → operation → role → form_mode_id`. When several roles apply to the current user, the role with the **highest weight** wins. The module also exposes a **dynamic permission per activated form mode** plus a master `access_all_form_modes` permission; the `?display=` switch is only honoured when the user holds the matching permission (or the master one). It relies entirely on core Field UI form modes and form displays — it defines no field type, widget, or entity of its own.

---

- Give the Editor role a slimmed-down Article creation form while Administrators keep the full form.
- Serve a different edit form to a "Reviewer" role than to authors of the same content type.
- Let power users open an alternate "compact" node form by adding `?display=compact` to the add URL.
- Set a default `register` form mode for anonymous users and a different `default` (edit) mode for the account form.
- Configure per-bundle create vs. edit form modes independently (e.g. simple create, detailed edit).
- Expose a specialised media entity form mode only to a "Media manager" role.
- Route a taxonomy term edit form to a curated form mode for translators.
- Provide a "quick add" form mode reachable by URL for internal tools/bookmarks.
- Restrict who can even reach a given form mode via the auto-generated per-form-mode permission.
- Grant a trusted role the `access_all_form_modes` permission so it can switch to any form mode by URL.
- Standardise which form mode each role lands on for a content type across an editorial team.
- Deploy role/bundle form-mode defaults as exported configuration (`form_mode_control.settings`).
- Hide advanced/technical fields from lower-privilege roles by pointing them at a reduced form mode.
- Present a marketing team a form mode with only SEO/promo fields on the Basic page type.
- Use vertical-tab organised config to manage form-mode defaults across many entity types at once.
- Automatically clean up stored defaults when a form mode/form display or a role is deleted.
- Offer a link/button in your UI to `/node/add/article?display=super_2` for a task-specific form.
- Let the user register form and the user edit form use distinct form modes.
- Give different form modes to the same bundle depending on which role weight is highest for the user.
- Keep the create form minimal and the update form comprehensive for the same content type.
- Provide a data-entry-optimised form mode to a call-centre role while editors use the standard form.
- Switch a workflow entity's edit form per role without writing a custom form alter.
- Migrate legacy per-role form customisations into config-managed form-mode defaults.
- Trial an alternate form layout with a subset of roles before making it the default for everyone.

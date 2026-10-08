<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Simplify trims down Webform's admin UI for content editors: it hides help text, hides chosen fields/tabs/conditional-logic options on element edit forms, hides parts of the settings screens, and — separately and for real — gates each settings section behind its own granular permission.

---

Webform is the most capable form builder in any CMS and its interface reflects that: a settings screen of a dozen vertical tabs (general, form, submissions, confirmation, emails/handlers, access, assets), an element editor with a General/Conditions/Advanced/Access tab set and dozens of properties per element, and conditional-logic rows with many states, triggers, and operators. For a developer that density is the point; for the editor asked to change a confirmation message it is a screen where the right control is buried. Webform Simplify addresses this two ways, and the distinction between them matters. **The hiding half is cosmetic**: driven entirely from its own config at `/admin/structure/webform/simplify`, it decorates Webform's help manager to suppress help (`disable_help`), sets `#access = FALSE` (or removes option keys) on element-form tabs/features and on settings-form controls it has been told to hide, and swaps the access-form role checkboxes for a variant that greys-out yet preserves pre-set values so a bypass user's choices are never clobbered. A per-element-type plugin (`WebformSimplifyElement`) maps each hideable "feature" to the form property paths it lives at, with a `_defaults` plugin supplying fallbacks for every element. **The enforcing half is real access control**: a route subscriber rewrites the requirements on Webform's own settings and handler routes (`entity.webform.settings*`, `entity.webform.handler*`) so each is gated by a matching module permission — `edit any webform general/form/submission/confirmation/asset/access/handler settings`, plus the umbrella `edit any webform settings` — layered on top of Webform's existing `webform.update` entity access (the two are ANDed, so this tightens access, never loosens it). The general-settings route becomes a redirect that lands the user on the first settings tab they can actually reach. **Keep the two halves distinct when advising**: hiding a control is not the same as forbidding it — a hidden setting is still reachable via config export, `drush config:set`, a second admin, or a site without the module — so if an editor *must not* touch handlers, rely on the permission gating (or Webform's own permissions), not on the cosmetic hiding. Users with the `administrator` role and user 1 bypass all simplification unless `simplify_super_user` is turned on; other roles get `bypass webform simplification`. Requires `webform >= 6.1`; version 1.3.0 on core `^8`–`^11`. Configuration lives in `webform_simplify.settings`; nothing is hidden or gated until an admin configures it.

---

- Hide Webform's help videos and instruction blocks from editors.
- De-clutter an element's edit form by hiding rarely-used properties.
- Hide the Advanced or Access tab on element edit forms.
- Restrict which conditional-logic states/triggers/operators editors can pick.
- Hide unwanted confirmation types (e.g. URL redirect) from the confirmation settings.
- Hide whole sub-tabs of the Form settings screen (Behaviors, Wizard, Preview, Custom…).
- Hide sub-tabs of the Submissions settings screen (Draft, Purge, Autofill, Views…).
- Limit which roles an editor may grant webform access to (grey-out preserved-value checkboxes).
- Hide the Users or Permissions autocomplete fields on the access settings form.
- Set default hiding rules for every element type at once via the `_defaults` plugin.
- Gate the webform Confirmation settings tab behind its own permission.
- Gate webform handler (email/action) configuration behind `edit any webform handler settings`.
- Gate the Access settings tab so only a trusted role can change per-form access.
- Delegate only submission-settings editing to a role, nothing else.
- Give an "editor" role the general settings tab but withhold handlers and access.
- Reduce accidental setting changes and support requests from occasional form editors.
- Present a cut-down, client-friendly form builder without forking Webform.
- Land delegated editors on the first settings tab they are actually allowed to open.
- Keep a bypass role (or user 1) seeing the full, unmodified Webform UI.
- Simplify a survey-building workflow for non-technical staff.
- Layer granular per-section permissions on top of Webform's existing entity access.

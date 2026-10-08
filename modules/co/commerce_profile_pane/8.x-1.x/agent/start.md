<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Profile Pane (commerce_profile_pane) — agent index

Adds a **Commerce checkout pane** that renders an inline edit form for the current user's **Profile**
entity of a given profile type, inside the checkout flow. A plugin deriver
(`ProfileFormCheckoutPaneDeriver`) creates one pane per non-`customer` profile type, so each profile
type you define shows up as its own pane (`profile_form:<profile_type_id>`) that a store admin can
drag into a checkout step. The pane class (`ProfileForm`) embeds an `inline_entity_form` element for
the profile: it loads the profile with `EntityStorage::loadByUser($current_user, $profile_type_id)`
and, if the user has none, builds a fresh profile with `uid = current_user`. The profile is always
scoped to the current session user — there is no request-supplied profile id.

The pane is **disabled by default** (`default_step = "_disabled"`) so new profile types don't
silently appear in every checkout flow. Visibility is access-gated: if a profile exists the pane
shows only when `$profile->access('update')` is TRUE; otherwise only when the profile type's
`createAccess()` is TRUE. There is no module settings page — everything is configured per-pane inside
a checkout flow. The `customer` profile type is deliberately skipped (Commerce core already provides
billing/shipping panes for it), and for profile types that allow multiple profiles per user the pane
edits only the **first** one found.

- Depends on: `commerce:commerce`, `commerce:commerce_checkout`, `profile:profile`,
  `inline_entity_form:inline_entity_form`.
- Core: `^9.3 || ^10 || ^11`. Package: `Commerce`.
- No dedicated settings page / `configure` route. Panes are configured inside a **checkout flow**
  (`admin/commerce/config/checkout-flows/manage/<flow>`). Provides config schema, **no** permissions
  of its own (it relies on the Profile module's `create`/`update own`/`update any` permissions), no
  drush, and **defines no plugin type** (it provides a plugin *instance* of Commerce's existing
  `commerce_checkout_pane` type).
- Implements two entity hooks that flush cached checkout-pane definitions when profile types are
  added/removed, so derived panes stay in sync.

## What you'd do → where

- **Enable/place the pane in a checkout flow, set the form mode & label, understand the config keys** →
  [configure/checkout-pane.md](configure/checkout-pane.md)
- **Understand the pane plugin, its deriver, the profile-scoping/IEF mechanism, methods and hooks (to
  subclass or debug)** → [api/plugin.md](api/plugin.md)

## Key facts (real machine names)

- Checkout pane plugin: base id `profile_form`, derived ids `profile_form:<profile_type_id>` (one per
  non-`customer` profile type). Annotation `@CommerceCheckoutPane`: `default_step = "_disabled"`,
  `wrapper_element = "fieldset"`, `deriver = ProfileFormCheckoutPaneDeriver`.
- Classes: `Drupal\commerce_profile_pane\Plugin\Commerce\CheckoutPane\ProfileForm` (extends
  `CheckoutPaneBase`); deriver
  `Drupal\commerce_profile_pane\Plugin\Derivative\ProfileFormCheckoutPaneDeriver` (extends
  `DeriverBase`, `ContainerDeriverInterface`).
- Pane config keys: `form_mode` (default `"default"`), `display_label` (default `"Edit profile"`),
  plus inherited pane keys (`step`, `weight`). Config schema
  `commerce_checkout.commerce_checkout_pane.profile_form:*` (type
  `commerce_checkout_pane_configuration` + `form_mode` string).
- Form element used: `#type = inline_entity_form`, `#entity_type = profile`,
  `#bundle = <profile_type_id>`, `#form_mode = <form_mode>`, `#default_value = <profile>`.
- Services consumed (none defined): `entity_type.manager`, `entity_display.repository`,
  `current_user`, `language_manager`; deriver uses `entity_type.bundle.info`.
- Hooks (`commerce_profile_pane.module`): `hook_ENTITY_TYPE_insert` /
  `hook_ENTITY_TYPE_delete` for `profile_type` →
  `commerce_profile_pane_profile_type_insert` / `_delete`, both call
  `plugin.manager.commerce_checkout_pane->clearCachedDefinitions()`.
- Dead code (documented as **NOT CURRENTLY IN USE**): `ProfileForm::processEntityForm()` and the
  `Drupal\commerce_profile_pane\CheckoutPaneElementSubmit` class (an `inline_entity_form\ElementSubmit`
  subclass). Submit is instead wired via
  `inline_entity_form\ElementSubmit::addCallback($complete_form['actions']['next'], $complete_form)` in
  `buildPaneForm()`.
- No routes, no `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, or `*.links.*.yml`.

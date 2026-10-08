<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# atsmarttag_tacjs — integration mechanism

How the module wires AT Internet SmartTag into TacJS. Everything here is the whole module; there is no config UI to learn.

## Install / enable

`drush en atsmarttag_tacjs -y`. This requires and enables `tacjs` and `atsmarttag` (both `dependencies` in `atsmarttag_tacjs.info.yml`). No install hook, no config import, no schema. After enabling, go to the **TacJS** configuration and switch on the **AT Internet SmartTag** service — that per-service `status` flag (stored by `tacjs`, read as `drupalSettings.tacjs.services.atinternet_smarttag`) is the only toggle.

## PHP hooks (`atsmarttag_tacjs.module`)

- `atsmarttag_tacjs_page_attachments(array &$page)` — when `\Drupal::service('router.admin_context')->isAdminRoute()` is **false**, appends `atsmarttag_tacjs/atsmarttag_tacjs` to `$page['#attached']['library']`. Effect: the JS loads on front-end pages only, never in the admin area.
- `atsmarttag_tacjs_tacjs_content_alter(array &$content)` — TacJS's own alter hook. Sets:
  ```php
  $content['analytic']['atinternet_smarttag'] = [
    'about' => ['name' => 'AT Internet (SmartTag)'],
    'code'  => ['js' => '', 'html' => ''],
  ];
  ```
  This registers the service in TacJS's `analytic` group so it appears in the consent manager. The empty `code.js`/`code.html` are intentional (the comment notes they suppress log warnings); the real tag code is supplied client-side by the JS below, not through these keys.
- `atsmarttag_tacjs_help()` — static help text only.

## JS service registration (`js/atsmarttag_tacjs.js`)

IIFE over `(jQuery, Drupal, drupalSettings, window.tarteaucitron)`:

1. Bails early unless both `drupalSettings.atsmarttag` and `Drupal.atsmarttag` are defined (i.e. the `atsmarttag` module actually provided its settings/behavior).
2. Reads `drupalSettings.tacjs.services.atinternet_smarttag`; proceeds only if that service exists and `.status` is truthy (the operator enabled it in TacJS).
3. Neutralizes the default AT Internet auto-load: `Drupal.behaviors.atsmarttag.attach = () => {};` — so the tag does **not** fire outside the consent flow.
4. Defines `tarteaucitron.services.atinternet_smarttag`:
   - `key: 'atinternet_smarttag'`, `type: 'analytic'`, `name: 'AT Internet (SmartTag)'`
   - `uri`: AT Internet privacy-centre help URL (shown in the banner)
   - `needConsent: true`
   - `cookies`: `atidvisitor, atreman, atredir, atsession, atuserid, attvtreman, attvtsession` (cleared when consent is withdrawn)
   - `js()`: on consent, calls `Drupal.atsmarttag.createTagAndDispatch(drupalSettings.atsmarttag)` — the actual tag creation is delegated to the `atsmarttag` module using its own settings.
   - `fallback()`: empty (`// TODO`).

## Data flow / boundaries

- SmartTag configuration (site id / tracking params) is **not** owned here — it comes from `atsmarttag` as `drupalSettings.atsmarttag` and is consumed only by `atsmarttag`'s `createTagAndDispatch`. This module passes it through untouched.
- Consent state and cookie cleanup are owned by `tacjs`/tarteaucitron.
- The module performs no server-side HTTP, no user-input handling, no rendering of config values into markup, and exposes no route or permission. It is inert until the operator enables the TacJS service and a visitor consents.

## Notes

- If either `atsmarttag` or `tacjs` is absent/disabled, nothing loads (guards in step 1–2 and the hard module dependencies).
- Admin routes are always excluded, so tracking never runs in the back office.

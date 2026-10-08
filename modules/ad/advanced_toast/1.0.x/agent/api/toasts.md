<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Toast: API, components, config & pipeline

## Install & enable

```bash
composer require drupal/advanced_toast
drush en advanced_toast -y
drush cr
```

Only dependency is core **`sdc`** (Single Directory Components, in core). No sub-modules, no Drush,
no permissions of its own.

## Trigger a toast

### PHP (`advanced_toast.toast` service → `AdvancedToastService`)

```php
$toast = \Drupal::service('advanced_toast.toast');
$toast->status('Saved!');
$toast->warning('Check your input.');
$toast->error('Something failed.');
$toast->addToast('Welcome', 'info', [
  'duration' => 3000,
  'dismissible' => FALSE,
  'fallback' => 'status',
  'additional_props' => ['points' => 5],
]);
```

`addToast()` builds a `toast_data` array (`type`, `message`, `duration`, `dismissible`, resolved
`component`, optional `fallback`, `additional_props`) and appends it to the **private tempstore**
(`tempstore.private`, collection `advanced_toast`, key `toasts`). `status()`/`warning()`/`error()`
are shorthands. Options accept both `dismissible` and `dismissable` spellings.

### Twig (`AdvancedToastTwigExtension`)

```twig
{{ toast_status('Saved!') }}
{{ toast_warning('Check your input.') }}
{{ toast_error('Something failed.') }}
{{ toast('Welcome', 'info', { duration: 3000, fallback: 'status' }) }}
```

Each function calls the service and returns an empty string (side-effect only).

### JavaScript (`Drupal.toast`)

```js
Drupal.toast('Saved!', 'status');
Drupal.toast('Welcome', 'info', { duration: 3000, fallback: 'status', additional_props: {points: 5} });
```

`Drupal.toast()` → `ToastManager.show()` builds query params and calls the `advanced_toast.render`
route through `Drupal.ajax`, whose `addToast` command injects the returned HTML.

## Component resolution & fallback

`AdvancedToastService::getComponentForType($type)` merges the default map
(`status→advanced_toast:toast-status`, `warning→…toast-warning`, `error→…toast-error`) with
`type_component_mapping` from config, falling back to `advanced_toast:toast-{type}`.
`resolveComponentWithFallback($componentId, $fallback)` checks the component exists via the SDC plugin
manager (`plugin.manager.sdc`); if not, tries the `fallback` type's component; if that also fails,
uses the base `advanced_toast:toast`. Each fallback step logs a warning to the `advanced_toast`
channel.

## SDC components (`components/`)

- `toast` — base component (`toast.twig`), props `message` (required), `type`, `dismissible`, `icon`,
  `utility_classes`. Renders the `.advanced-toast` wrapper, `role="alert"`, `aria-live` (`assertive`
  for errors, else `polite`), a dismiss button, and a progress bar.
- `toast-status` / `toast-warning` / `toast-error` — each `{% include 'advanced_toast:toast' %}` with
  a type-specific inline SVG icon.

A component is treated as a toast component when its `*.component.yml` declares
`thirdPartySettings.advanced_toast.is_toast_component: true` and a required `message` string prop; the
settings form validates these when you map a type. Themes add their own toast type by creating such a
component and mapping it in the admin UI (see `README.md` for a worked celebration example).

## Render pipeline

1. `hook_page_attachments()` attaches library `advanced_toast/toast` on every page and passes
   `drupalSettings.advancedToast` (`replaceMessages`, `defaultDuration`, `position`, `enabledTypes`).
2. `hook_page_top()` adds `['#type' => 'advanced_toast_messages']`.
3. `AdvancedToastMessages::generatePlaceholder()` (`#pre_render`) turns it into a placeholdered
   `#lazy_builder` call to `advanced_toast.lazy_builder:renderToasts` (forced placeholder so it works
   on GET and POST, keeping the page cacheable).
4. `AdvancedToastLazyBuilder::renderToasts()` pulls queued toasts (`getPendingToasts()` reads then
   **deletes** the tempstore key), optionally converts core Drupal messages (see below), renders each
   as `['#type' => 'component', '#component' => …, '#props' => ['message' => …, 'dismissible' => …]]`,
   attaches the component's auto-library, and appends `{html, type, duration}` to
   `drupalSettings.advancedToast.pendingToasts`.
5. `js/toast-manager.js` (`ToastManager`) reads `pendingToasts`, injects each toast's HTML into a
   `.advanced-toast-container--{position}`, runs the entrance animation, wires the dismiss button and
   auto-dismiss timer (skipped when `duration <= 0`). Toasts are queued until the window has focus.

## Routes

`advanced_toast.routing.yml`:

- `advanced_toast.settings` → `/admin/config/user-interface/advanced-toast`
  (`AdvancedToastSettingsForm`, permission **`administer site configuration`**; menu under
  *Configuration → User interface*).
- `advanced_toast.render_toasts` → `/advanced-toast/render-toasts`
  (`ToastController::renderToasts`, `_access: 'TRUE'`): returns pending toasts (from tempstore) as
  `AddToastCommand`s.
- `advanced_toast.render` → `/advanced-toast/render` (`ToastController::renderToast`,
  `_access: 'TRUE'`): renders a single toast from query params `message`, `type`, `dismissible`,
  `duration`, `additional_props` (JSON) and returns one `AddToastCommand`.

## Configuration (`advanced_toast.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `replace_drupal_messages` | bool | `false` | Convert mapped core message types into toasts. |
| `default_duration` | int (ms) | `5000` | Default auto-dismiss time. |
| `default_dismissible` | bool | `true` | Whether toasts show a dismiss button by default. |
| `position` | string | `top-right` | Container position (top/bottom × left/right/center). |
| `type_component_mapping` | sequence | status/warning/error → base components | Toast type → SDC component id. |

Schema: `config/schema/advanced_toast.schema.yml`. Install defaults:
`config/install/advanced_toast.settings.yml` (note it also seeds
`default_dismissible: true` and a `type_component_mapping`).

### Drupal-message replacement

When `replace_drupal_messages` is on, `renderToasts()` reads `messenger()->messagesByType()` for
`status`/`warning`/`error`, and **only for types that have a `type_component_mapping` entry** converts
each message to a toast and `deleteByType()`s the originals. Unmapped types stay as normal Drupal
messages.

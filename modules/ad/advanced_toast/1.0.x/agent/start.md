<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Toast Messages (advanced_toast) — agent index

A **toast notification system** built on **Single Directory Components (SDC)**. Toasts are queued from
PHP/Twig/JS, rendered server-side through a lazy builder, and displayed client-side. Depends only on
core **`sdc`**. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.3.

- **Full API (PHP/Twig/JS), the SDC components, config, routes and the render pipeline** →
  [api/toasts.md](api/toasts.md)

## What it provides

- **Service** `advanced_toast.toast` → `AdvancedToastService` (`src/AdvancedToastService.php`,
  interface `AdvancedToastServiceInterface`): `addToast($message, $type, $options)`, `status()`,
  `warning()`, `error()`, `getPendingToasts()`, `resolveComponentWithFallback()`. Queues toasts in
  the **private tempstore** (`tempstore.private`, collection `advanced_toast`).
- **Lazy builder** `advanced_toast.lazy_builder` → `AdvancedToastLazyBuilder::renderToasts()`
  (`TrustedCallbackInterface`): renders queued toasts + (optionally) converted Drupal messages into
  SDC components and passes rendered HTML to JS via `drupalSettings.advancedToast.pendingToasts`.
- **Render element** `#type => 'advanced_toast_messages'` (`src/Element/AdvancedToastMessages.php`),
  injected on every page by `hook_page_top()`; it placeholders the lazy builder.
- **Twig extension** `AdvancedToastTwigExtension` (service `advanced_toast.twig_extension`): functions
  `toast()`, `toast_status()`, `toast_warning()`, `toast_error()`.
- **AJAX command** `AddToastCommand` (`src/Ajax/AddToastCommand.php`, JS command `addToast`).
- **Controller** `ToastController` with two routes (see below).
- **SDC components** under `components/`: `toast`, `toast-status`, `toast-warning`, `toast-error`
  (each flagged `thirdPartySettings.advanced_toast.is_toast_component: true`, required prop `message`).
- **Libraries** `advanced_toast/toast` (js/toast-manager.js + css/toast.css) attached on every page by
  `hook_page_attachments()`; `advanced_toast/admin`.
- **No permissions of its own** beyond the settings route's `administer site configuration`.

## Routes (`advanced_toast.routing.yml`)

- `advanced_toast.settings` → `/admin/config/user-interface/advanced-toast`
  (`AdvancedToastSettingsForm`, permission **`administer site configuration`**).
- `advanced_toast.render_toasts` → `/advanced-toast/render-toasts`
  (`ToastController::renderToasts`, `_access: 'TRUE'`) — returns queued toasts as AJAX commands.
- `advanced_toast.render` → `/advanced-toast/render`
  (`ToastController::renderToast`, `_access: 'TRUE'`) — renders one toast from query params
  (`message`, `type`, `dismissible`, `duration`, `additional_props`).

## Config (`advanced_toast.settings`)

`replace_drupal_messages` (bool), `default_duration` (int ms), `default_dismissible` (bool),
`position` (string), `type_component_mapping` (sequence: type → SDC component id). Schema in
`config/schema/`, install defaults in `config/install/advanced_toast.settings.yml`.

## Render pipeline (from source)

`addToast()`/Twig functions → tempstore → `hook_page_top()` adds `advanced_toast_messages` →
`AdvancedToastMessages::generatePlaceholder()` → lazy builder `renderToasts()` resolves each toast's
component (with fallback), renders it, and hands the HTML + metadata to `drupalSettings`. Client
`js/toast-manager.js` (`Drupal.behaviors.advancedToast`) reads `pendingToasts`, injects each toast's
HTML into a container, animates, and auto-dismisses. `Drupal.toast()` and the `render` route provide a
runtime path via `Drupal.ajax` + the `addToast` command.

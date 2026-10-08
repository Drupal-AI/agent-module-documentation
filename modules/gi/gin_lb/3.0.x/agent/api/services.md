<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & callable API

Three services in `gin_lb.services.yml`. No plugin manager, no events dispatched.

| Service id | Class | Use |
|---|---|---|
| `gin_lb.context_validator` | `Service\ContextValidator` (`ContextValidatorInterface`) | the only service you'd normally call |
| `gin_lb.twig` | `TwigExtension\GinLbExtension` | registers the `glb_classes()` Twig function |
| `gin_lb.layout_choose_controller_alter` | `EventSubscriber\LayoutBuilderBrowserEventSubscriber` | kernel `VIEW` subscriber, weight 50 |

## `ContextValidatorInterface`

```php
$cv = \Drupal::service('gin_lb.context_validator');

$cv->isValidTheme(): bool                  // FALSE when active theme IS gin / a gin sub-theme
$cv->isLayoutBuilderRoute(): bool          // current route is a layout_builder.* route
$cv->isLayoutBuilderFormId(string $form_id, array $form): bool
```

`isValidTheme()` and `isLayoutBuilderRoute()` memoise on the instance, so they are cheap to call
repeatedly within a request. `isLayoutBuilderFormId()` short-circuits to FALSE when
`isValidTheme()` is FALSE.

This is the service to reuse if you write a companion module that must style the same requests —
`gin_lb_plus` does exactly that in its `hook_page_attachments()`.

## `GinLayoutBuilderUtility`

Static helper, one method:

```php
\Drupal\gin_lb\GinLayoutBuilderUtility::attachGinLbForm(array &$form): void
```

Recursively sets `#gin_lb_form = TRUE` on every child element that does not already have it.
Call it from an `#after_build` if you add a form that should get the Gin LB treatment; the
module exposes a ready-made callback for that:

```php
$form['#after_build'][] = [\Drupal\gin_lb\HookHandler\FormAlter::class, 'afterBuildAttachGinLbForm'];
$form['#gin_lb_form'] = TRUE;
$form['#attributes']['class'][] = 'glb-form';
```

## `GinLbExtension` (Twig)

Provides one function, `glb_classes(Attribute $attribute): Attribute`. See
[../theming/mechanism.md](../theming/mechanism.md).

## `LayoutBuilderBrowserEventSubscriber`

Subscribes to `KernelEvents::VIEW` at weight 50. It does nothing unless the
`layout_builder_browser` module is installed; on the `layout_builder.choose_block` route (and
only when the build has no `add_block` key) it adds the class `layout-builder-browser` to
`$build['block_categories']`. That is its entire job — the submodule `gin_lb_plus` has a much
larger subscriber of the same class name at weight 45.

## Hook handler classes

All hooks in `gin_lb.module` are thin wrappers that resolve a handler through
`\Drupal::service('class_resolver')->getInstanceFromDefinition(...)`. The handlers live in
`src/HookHandler/`: `CssAlter`, `FormAlter`, `FormMediaLibraryAddForm*Alter`, `Help`,
`LibraryInfoAlter`, `PageAttachments`, `Preprocess`, `Theme`, `ThemeSuggestionsAlter`,
`ThemeSuggestionsFormAlter`, `ViewsPreRender`. They are **not** services — do not try to
`\Drupal::service()` them; use the class resolver if you ever need one directly.

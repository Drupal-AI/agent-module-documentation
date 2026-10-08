<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ng_lightbox` service and how links are altered

```yaml
# ng_lightbox.services.yml
ng_lightbox:
  class: Drupal\ng_lightbox\NgLightbox
  arguments: ['@path.matcher', '@path_alias.manager', '@config.factory', '@router.admin_context', '@request_stack']
```

## Public API

```php
public function isNgLightboxEnabledPath(\Drupal\Core\Url $url): bool;
public function addLightbox(array &$link): void;
const NgLightbox::DEFAULT_MODAL = 'drupal_modal';
```

`isNgLightboxEnabledPath()` returns FALSE for external URLs, for admin routes when
`skip_admin_paths` is TRUE, for empty paths or paths not starting with `/`, and when `patterns`
is empty. Otherwise it lower-cases the path (minus the base path) and tries
`path.matcher->matchPath()` against the patterns, then the same test against
`path_alias.manager->getAliasByPath()`. Decisions are memoised per path in `$this->matches`.

`addLightbox()` mutates the link render array:

```php
$link['options']['attributes']['class'][]         = 'use-ajax';
$link['options']['attributes']['data-dialog-type'] = str_replace('drupal_', '', $renderer);
$link['options']['attributes']['data-dialog-options'] = json_encode([
  'width'       => $config->get('default_width'),
  'dialogClass' => $config->get('lightbox_class'),
]);
```

So with the shipped defaults a lightboxed link ends up as:

```html
<a href="/contact" class="use-ajax" data-dialog-type="modal"
   data-dialog-options='{"width":700,"dialogClass":""}'>…</a>
```

## Entry point

```php
// ng_lightbox.module
function ng_lightbox_link_alter(&$vars) {
  $lightbox = \Drupal::service('ng_lightbox');
  if ($lightbox->isNgLightboxEnabledPath($vars['url'])) {
    $lightbox->addLightbox($vars);
  }
  elseif (!empty($vars['options']['attributes']['class'])) {
    $vars['options']['attributes']['class'] = (array) $vars['options']['attributes']['class'];
    if (in_array('ng-lightbox', $vars['options']['attributes']['class'])) {
      $lightbox->addLightbox($vars);   // manual opt-in by class
    }
  }
  \Drupal::moduleHandler()->alter('ng_lightbox_ajax_path', $vars);
}

function ng_lightbox_page_attachments(array &$attachments) {
  $attachments['#attached']['library'][] = 'ng_lightbox/ng_lightbox';   // -> core/drupal.ajax
}
```

`hook_link_alter()` only fires for links built through the link generator / `#type: link`; markup
written by hand in a Twig template is not touched.

## Where the renderer list comes from

`NgLightboxServiceProvider::alter()` adds an `ng_lightbox` attribute to the
`render.main_content_renderer` tags of core's `main_content_renderer.dialog` ("Core Dialog") and
`main_content_renderer.modal` ("Core Modal"). `NgLightboxPass` (a compiler pass registered by the
same service provider) collects every service tagged `render.main_content_renderer` that carries
an `ng_lightbox` attribute into the container parameter **`ng_lightbox_renderers`**, keyed by the
tag's `format`. The settings form reads that parameter for its Renderer select, so a module that
adds its own main-content renderer with an `ng_lightbox` tag attribute automatically appears as an
option.

```bash
drush ev 'print json_encode(\Drupal::getContainer()->getParameter("ng_lightbox_renderers")) . PHP_EOL;'
# {"drupal_dialog":"Core Dialog","drupal_modal":"Core Modal"}
```

## Library

`ng_lightbox.libraries.yml` defines `ng_lightbox` with **no JS or CSS of its own** — only a
dependency on `core/drupal.ajax` — and `hook_page_attachments()` attaches it to every page so the
dialog behaviour is always available.

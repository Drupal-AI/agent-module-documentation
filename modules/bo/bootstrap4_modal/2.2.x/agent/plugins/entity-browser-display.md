<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Browser display: `bootstrap4_modal`

Requires the **Entity Browser** module. This is an implementation of Entity Browser's
`@EntityBrowserDisplay` plugin type (not a new plugin type defined by this module).

- **id:** `bootstrap4_modal`
- **label:** "Bootstrap 4 Modal"
- **class:** `Drupal\bootstrap4_modal\Plugin\EntityBrowser\Display\Bootstrap4Modal` (extends
  Entity Browser's core `Modal` display, `uses_route = TRUE`).
- **extra config:** `modal_size` (string, e.g. `''`, `modal-lg`, `modal-sm`) added to the
  parent Modal display's configuration.

It opens the entity browser inside a Bootstrap 4 modal, closing it with a
`CloseBootstrap4ModalDialogCommand` when selection completes. The module also overrides the
iframe/page templates (`html__entity_browser__bootstrap4_modal`,
`page__entity_browser__bootstrap4_modal`) and re-registers the
`bootstrap4_modal_selection` JS library on `entity_browser` via `hook_library_info_alter`.

## Configure it

On an entity browser's edit form (`/admin/config/content/entity_browser`), set **Display
plugin** to *Bootstrap 4 Modal* and choose a modal size.

As config (`entity_browser.browser.<name>` config entity):

```yaml
display: bootstrap4_modal
display_configuration:
  modal_size: 'modal-lg'
```

Scriptable:

```php
use Drupal\entity_browser\Entity\EntityBrowser;
EntityBrowser::create([
  'name' => 'my_browser',
  'label' => 'My browser',
  'display' => 'bootstrap4_modal',
  'display_configuration' => ['modal_size' => 'modal-lg'],
  'widget_selector' => 'tabs',
  'selection_display' => 'no_display',
  'widgets' => [],
])->save();
```

Read back: `drush cget entity_browser.browser.my_browser display` → `bootstrap4_modal`.

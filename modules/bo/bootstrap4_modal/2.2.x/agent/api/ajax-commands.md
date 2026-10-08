<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opening & closing Bootstrap 4 modals

Two ways to use it: declarative `use-ajax` links, or PHP AJAX command classes.

## 1. Declarative link/button

Any core AJAX link opting into the dialog type opens in a Bootstrap 4 modal:

```html
<a href="/node/1"
   class="use-ajax"
   data-dialog-type="bootstrap4_modal"
   data-dialog-options='{"dialogClasses":"modal-dialog-centered","dialogShowHeader":false}'>
  Open in Bootstrap 4 Modal
</a>
```

- `data-dialog-type="bootstrap4_modal"` selects this module's dialog (response format
  `drupal_bootstrap4_modal`, served by the `Bootstrap4ModalRenderer` main content renderer).
- `#drupal-bootstrap4-modal` is the DOM element the modal is rendered into.
- No library needs attaching manually — `bs4_modal.dialog` and `bs4_modal.dialog.ajax` are
  attached to every page by `hook_preprocess_page`.

### Dialog options (`data-dialog-options` / `drupalSettings.bs4_modal_dialog`)

| Option | Effect | Default |
|---|---|---|
| `dialogClasses` | extra classes on `.modal-dialog` (e.g. `modal-lg`, `modal-dialog-centered`) | `''` |
| `dialogShowHeader` | show the modal header bar | `true` |
| `dialogShowHeaderTitle` | show the title in the header | `true` |
| `buttonClass` | class applied to dialog buttons | `btn` |
| `buttonPrimaryClass` | class for the primary button | `btn-primary` |
| `backdrop` | Bootstrap backdrop (`true`/`false`/`'static'`) | `true` |
| `keyboard` | close on ESC | `true` |
| `focus` | trap focus | `true` |
| `autoOpen` | open immediately | `true` |

## 2. PHP AJAX command classes

Namespace `Drupal\bootstrap4_modal\Ajax`. They extend core's dialog commands, so usage
mirrors `OpenModalDialogCommand` / `CloseModalDialogCommand`.

```php
use Drupal\Core\Ajax\AjaxResponse;
use Drupal\bootstrap4_modal\Ajax\OpenBootstrap4ModalDialogCommand;
use Drupal\bootstrap4_modal\Ajax\OpenBootstrap4ModalDialogByUrlCommand;
use Drupal\bootstrap4_modal\Ajax\CloseBootstrap4ModalDialogCommand;

$response = new AjaxResponse();

// Open rendered content in a modal:
$response->addCommand(new OpenBootstrap4ModalDialogCommand(
  $this->t('My title'),
  $render_array_or_html,
  ['dialogClasses' => 'modal-lg'],   // dialog options
));

// Open a URL's content in a modal (settings['url'] is loaded client-side):
$response->addCommand(new OpenBootstrap4ModalDialogByUrlCommand($title, '/some/path', $options));

// Close the current modal (defaults to selector #drupal-bootstrap4-modal):
$response->addCommand(new CloseBootstrap4ModalDialogCommand());
return $response;
```

| Class | Constructor | Emits JS command |
|---|---|---|
| `OpenBootstrap4ModalDialogCommand` | `($title, $content, array $dialog_options = [], $settings = NULL)` | `openBootstrap4Dialog` |
| `OpenBootstrap4ModalDialogByUrlCommand` | `($title, $url, array $dialog_options = [], $settings = NULL)` | `openBootstrap4DialogByUrl` |
| `CloseBootstrap4ModalDialogCommand` | `($selector = '#drupal-bootstrap4-modal', $persist = FALSE)` | `closeBootstrap4Dialog` |

Both Open commands force `dialog_options['modal'] = TRUE` and target the selector
`#drupal-bootstrap4-modal`. The renderer also attaches this module's libraries automatically.

Note: this module only styles the dialog. **Bootstrap 4's own CSS/JS is not bundled** — use a
Bootstrap-4-based theme (or add Bootstrap yourself).

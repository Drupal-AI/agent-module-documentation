# plugins — the `AiApiExplorer` plugin type

This module **defines one plugin type**: `AiApiExplorer`. Each plugin is a single explorer
form for one AI operation. Add your own to expose a custom operation (or a module-specific
test form) in the explorers UI.

| | |
|---|---|
| Attribute | `#[AiApiExplorer]` (`src/Attribute/AiApiExplorer.php`) |
| Interface | `Drupal\ai_api_explorer\AiApiExplorerInterface` |
| Base class | `Drupal\ai_api_explorer\AiApiExplorerPluginBase` |
| Plugin namespace | `Plugin/AiApiExplorer` (i.e. `src/Plugin/AiApiExplorer/`) |
| Manager service | `plugin.manager.ai_api_explorer` (`AiApiExplorerPluginManager`) |
| Alter hook | `hook_ai_api_explorer_info_alter()` (alterInfo `ai_api_explorer_info`) |
| Cache key | `ai_api_explorer_plugins` |

The attribute takes `id`, `title` (TranslatableMarkup), and `description` (TranslatableMarkup).

**Plugin ID gotcha (from the attribute docblock):** due to an implementation quirk the plugin
is only discovered when the `id` is either identical to the "group" or prefixed with the
group + colon, e.g. group `foo` → id `foo` or `foo:bar`. The built-in explorers use plain
single-token ids like `chat_generator`.

## What a plugin must implement

Extend `AiApiExplorerPluginBase` — it implements most of `AiApiExplorerInterface` for you
(`getLabel`/`getDescription`/`label` from the attribute, `isActive()` defaulting to TRUE,
`hasAccess()` returning TRUE when the account has `access ai prompt`, form-template and
code-example helpers, file handling). You typically override:

- `isActive(): bool` — return FALSE to hide the explorer when no capable provider/operation
  is available (this is what makes the landing page and the access checker skip it).
- `buildForm(array $form, FormStateInterface $form_state): array` — the input UI.
- `getResponse(array &$form, FormStateInterface $form_state): array` — run the AI call and
  render the result.
- `getAjaxResponseId(): string` — the form method name used for the AJAX response
  (base returns `::ajaxResponse`).
- optionally `hasAccess(AccountInterface $account)`, `submitForm()`, `generateFile()`.

You do **not** register a route — `AiApiExplorerRouteSubscriber` auto-creates
`ai_api_explorer.form.<id>` at `/admin/config/ai/explorers/<id>` for every discovered plugin,
and `AiApiExplorerForm` renders it.

## Skeleton

```php
namespace Drupal\my_module\Plugin\AiApiExplorer;

use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\ai_api_explorer\AiApiExplorerPluginBase;
use Drupal\ai_api_explorer\Attribute\AiApiExplorer;

#[AiApiExplorer(
  id: 'my_explorer',
  title: new TranslatableMarkup('My Explorer'),
  description: new TranslatableMarkup('Test my custom AI operation.'),
)]
final class MyExplorer extends AiApiExplorerPluginBase {

  public function isActive(): bool {
    // e.g. check the provider manager for a capable provider.
    return TRUE;
  }

  public function buildForm(array $form, FormStateInterface $form_state): array {
    $form = $this->getFormTemplate($form, 'my-explorer-response');
    // ...add inputs to $form['left']...
    return $form;
  }

  public function getResponse(array &$form, FormStateInterface $form_state): array {
    // ...call an AI Core provider service, build a render array...
    return [];
  }

}
```

The base constructor injects `request_stack`, `ai.form_helper` (`AiProviderFormHelper`),
`ai_api_explorer.helper` (`ExplorerHelper`), and `ai.provider` (`AiProviderPluginManager`) —
override `create()`/the constructor if you need more. See the shipped plugins in
`src/Plugin/AiApiExplorer/` (e.g. `ChatGenerator.php`, `ToolsExplorer.php`) for full examples.

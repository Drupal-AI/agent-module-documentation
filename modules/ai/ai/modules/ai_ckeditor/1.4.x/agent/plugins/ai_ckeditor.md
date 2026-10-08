# plugins — the `AiCKEditor` action plugin type

This module **defines** one plugin type: `AiCKEditor`. Each plugin is one AI action offered
to editors in the modal dialog / balloon menu (Summarize, Translate, …).

| | |
|---|---|
| Attribute | `#[AiCKEditor]` — `Drupal\ai_ckeditor\Attribute\AiCKEditor` |
| Namespace | `Plugin/AiCKEditor` (i.e. `src/Plugin/AiCKEditor/`) |
| Manager service | `plugin.manager.ai_ckeditor` (`PluginManager\AiCKEditorPluginManager`, `Plugin/AiCKEditor` subdir, alter hook `ai_ckeditor`) |
| Interface | `PluginInterfaces\AiCKEditorPluginInterface` |
| Base class | `AiCKEditorPluginBase` (implement most plugins by extending this) |

Attribute properties: `id` (string), `label` (`TranslatableMarkup`), `description`
(`TranslatableMarkup|string`), `module_dependencies` (array, default `[]`). If any listed
module is not installed the manager's `findDefinitions()` silently drops the plugin — this is
how `ai_ckeditor_tone` and `ai_ckeditor_translate` (both `module_dependencies: ['taxonomy']`)
disappear when taxonomy is absent.

## Built-in plugins (`src/Plugin/AiCKEditor/`)

| id | label | needs selection? | deps |
|---|---|---|---|
| `ai_ckeditor_completion` | Generate with AI | no | — |
| `ai_ckeditor_modify_prompt` | Modify with a prompt | yes | — |
| `ai_ckeditor_summarize` | Summarize | yes | — |
| `ai_ckeditor_translate` | Translate | yes | taxonomy |
| `ai_ckeditor_tone` | Tone | yes | taxonomy |
| `ai_ckeditor_spellfix` | Fix spelling | yes | — |
| `ai_ckeditor_reformat_html` | Reformat HTML | yes | — |
| `ai_ckeditor_help` | Help and Support | — | — |

## Writing a plugin

```php
namespace Drupal\my_module\Plugin\AiCKEditor;

use Drupal\Core\Ajax\AjaxResponse;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\ai_ckeditor\AiCKEditorPluginBase;
use Drupal\ai_ckeditor\Attribute\AiCKEditor;
use Drupal\ai_ckeditor\Command\AiRequestCommand;

#[AiCKEditor(
  id: 'my_module_expand',
  label: new TranslatableMarkup('Expand'),
  description: new TranslatableMarkup('Expand the selected text into a fuller paragraph.'),
  module_dependencies: [],
)]
final class Expand extends AiCKEditorPluginBase {

  // Per-format admin settings (shown on the text-format toolbar form).
  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    $form['provider'] = [
      '#type' => 'select',
      '#title' => $this->t('AI provider'),
      '#options' => $this->aiProviderManager->getSimpleProviderModelOptions('chat', FALSE),
      '#empty_option' => $this->t('-- Default from AI module (chat) --'),
      '#default_value' => $this->configuration['provider']
        ?? $this->aiProviderManager->getSimpleDefaultProviderOptions('chat'),
    ];
    return $form;
  }

  public function submitConfigurationForm(array &$form, FormStateInterface $form_state): void {
    $this->configuration['provider'] = $form_state->getValue('provider');
  }

  // TRUE = require an editor selection; FALSE = free prompt (like completion).
  protected function needsSelectedText() {
    return TRUE;
  }

  // The dialog "Generate" AJAX callback: build a prompt, dispatch AiRequestCommand.
  public function ajaxGenerate(array $form, FormStateInterface $form_state) {
    $response = new AjaxResponse();
    $values = $form_state->getValues();
    $prompt = 'Expand this text:' . PHP_EOL . $values['plugin_config']['selected_text'];
    $response->addCommand(new AiRequestCommand(
      $prompt,
      $values['editor_id'],
      $this->pluginDefinition['id'],
      'ai-ckeditor-response',
    ));
    return $response;
  }

}
```

Key points from the base class (`AiCKEditorPluginBase`):
- It already builds the modal form (selected-text field, Generate button, an editable
  `text_format` response field, Save button). Override `buildCkEditorModalForm()` to add
  fields (see `Completion` which adds a free-text prompt box), and implement `ajaxGenerate()`.
- `AiRequestCommand($prompt, $editor_id, $plugin_id, $wrapper_id)` is what actually triggers
  the streamed AI call — the JS POSTs to route `ai_ckeditor.do_request`
  (`/api/ai-ckeditor/request/{editor}/{ai_ckeditor_plugin}`), and `Controller\AiRequest`
  runs a `chat` operation via AI Core's `ai.provider` and streams the reply.
- `needsSelectedText()` FALSE makes an action that works without a selection (completion).
- `availableEditors()` normally returns `[id => label]`; override to expose several editor
  entries from one plugin.
- Add config schema for any extra settings under
  `ckeditor5.plugin.ai_ckeditor_ai.<your_id>` (extend `..._ai_base`, which has `enabled` +
  `provider`).

The plugin does **not** talk to the LLM directly — it constructs a prompt and hands off to
the controller, which resolves the provider (per-plugin or AI Core default `chat`) and
streams the response.

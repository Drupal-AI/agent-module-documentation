<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tokenizer settings (config object + form)

## Install & enable

```bash
composer require drupal/ai_dropsolid
drush en ai_dropsolid -y
```

Hard dependency: `ai_provider_dropsolidai` (`^1`), which brings in the `ai` module. PHP `>=8.1`.
The LiteLLM tokenizer mode additionally needs `ai_provider_litellm` enabled and configured; the CLI
mode needs a private file system and a SentencePiece executable on the server.

## Route & access

`ai_dropsolid.routing.yml`:

- **`ai_dropsolid.tokenizer_settings`** → path `/admin/config/ai/dropsolid/tokenizer`,
  `_form: '\Drupal\ai_dropsolid\Form\TokenizerSettingsForm'`, requirement
  **`_permission: 'administer ai'`**.
- Menu link (`ai_dropsolid.links.menu.yml`): *Dropsolid Tokenizer* under parent
  `ai.admin_providers`, weight 20.

## Config object `ai_dropsolid.settings`

Install default (`config/install/ai_dropsolid.settings.yml`):

```yaml
tokenizer:
  mode: 'lite_llm'
```

Schema (`config/schema/ai_dropsolid.schema.yml`, type `config_object`):

| Key | Type | Meaning |
|---|---|---|
| `tokenizer.mode` | string | `lite_llm` \| `cli_sentencepiece` \| `none`. |
| `tokenizer.cli.executable_name` | string | SentencePiece binary name (default `spm_encode`). |
| `tokenizer.cli.executable_path` | string | Absolute dir holding the binary if not on `$PATH`. |
| `tokenizer.cli.model_file` | integer | Managed **file id** of an uploaded model. |
| `tokenizer.cli.model_path` | string | Direct filesystem path to a model file (alternative to upload). |

## The form — `Form\TokenizerSettingsForm`

`ConfigFormBase`, form id `ai_dropsolid_tokenizer_settings`, editable config `ai_dropsolid.settings`.

- **Private file system gate** — `isPrivateFileSystemConfigured()` checks the `private` stream
  wrapper is valid and `settings.file_private_path` is a real dir. If not, it shows an error
  telling you to set `$settings['file_private_path']` and **disables** the mode select and CLI
  fields. When available it prepares `private://ai_dropsolid/tokenizers`.
- **Mode select** — `lite_llm` (default, "LiteLLM (HTTP) tokenizer"), `cli_sentencepiece`, `none`.
  A `#states` block shows the LiteLLM fieldset for `lite_llm` and the CLI fieldset for
  `cli_sentencepiece`.
- **LiteLLM fieldset** (`buildLlmConfiguration()`) — read-only info: links to
  `ai_provider_litellm.settings_form`, warns if `ai_provider_litellm` is not enabled or its `host`
  is empty, otherwise prints the current LiteLLM host. No key entry here (it reuses LiteLLM's).
- **CLI fieldset** (`buildCliConfiguration()`) — `executable_name` (required, default `spm_encode`),
  `executable_path`, `model_file` (`managed_file`, `#upload_location => private://ai_dropsolid/tokenizers`,
  validators `FileExtension => ['model json bpe']`, autoupload), and `model_path` (direct path
  alternative).

### Validation (`validateForm()`)

- **CLI mode**: requires a model file *or* a model path, then runs `testCliTokenizer($cli)` which
  (a) `exec('command -v <escapeshellarg(fullExecutablePath)>')` to confirm the binary exists, then
  (b) resolves the model (uploaded file's realpath or the given path, checking `file_exists`), then
  (c) runs `echo <TEST_STRING> | <exe> --model=<model> --output_format=piece --extra_options=bos:eos`
  (all args `escapeshellarg`-quoted; the test string is a fixed constant) and reports the token
  count. Errors block submit; warnings/success are messages.
- **LiteLLM mode**: requires `ai_provider_litellm` enabled, then `testLiteLlmTokenizer()` POSTs the
  fixed test string to `{litellm host}/utils/token_counter` with `Authorization: Bearer <key>`
  (key resolved from the LiteLLM Key entity) and expects `tokenizer_type == 'huggingface_tokenizer'`.
- **none**: no validation.

### Submit (`submitForm()`)

Saves `tokenizer.mode`; clears the legacy `tokenizer.llm`; writes `tokenizer.cli.executable_name`
/`executable_path`/`model_path`; if a `model_file` was uploaded it is set **permanent**, saved, and
its id stored in `tokenizer.cli.model_file` (else that key is cleared). If the CLI fieldset is
empty, `tokenizer.cli` is cleared.

## Operate

1. Ensure a private file path is configured (needed even for LiteLLM mode, because the form gates on
   it before enabling the select).
2. For **LiteLLM**: enable + configure `ai_provider_litellm` (host + API key via Key), then pick
   *LiteLLM (HTTP) tokenizer* and save — the form verifies the endpoint.
3. For **CLI SentencePiece**: install `spm_encode` on the server, upload the matching SentencePiece
   model (e.g. multilingual-E5-Large-Instruct's `sentencepiece.bpe.model`) or point `model_path` at
   it, and save — the form runs a live tokenization test.
4. The chosen mode drives `DropsolidXlmRobertaTokenizer` at runtime (see
   [../services/tokenizer.md](../services/tokenizer.md)).

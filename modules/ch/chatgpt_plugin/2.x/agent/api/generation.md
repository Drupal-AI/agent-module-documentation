<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenAI call path: services, forms, translation

## Services (both use Drupal's Guzzle `@http_client`, default TLS)

### `GPTApiService` (`src/GPTApiService.php`, service `chatgpt_plugin.gpt_api`)
`getGptResponse($prompt_text)`:
1. Reads `chatgpt_plugin.adminsettings` for `access_token`, `chatgpt_temperature` (int),
   `chatgpt_max_token` (int), `completion_endpoint`, `model_name`, `moderation_endpoint`.
2. POSTs to the completion endpoint: `{model, messages:[{role:"user",content:$prompt_text}],
   temperature, max_tokens}` with header `Authorization: Bearer <access_token>`.
3. Extracts `choices[0].message.content`.
4. POSTs that text to `moderation_endpoint`; if `results[0].flagged` is truthy the return
   value is replaced with *"The generated content violated OpenAI Content usage policy…"*.
5. Guzzle exceptions are re-thrown to the caller.

### `DallEApiService` (`src/DallEApiService.php`, service `chatgpt_plugin.dalle_api`)
`getDalleResponse($prompt_text, $image_count, $image_size)` POSTs `{prompt, n, size}` to
`dalle_endpoint` with the same Bearer header and returns `data` (array of `{url:...}`).

## Content generator (node form modal)

`chatgpt_plugin_form_alter()` (`.module`): if the user has `access chatgpt search form` and
the form is a `NodeForm` whose bundle is in `content_types`, it prefixes every `text` /
`text_long` / `text_with_summary` field with a `use-ajax` modal link to
`/chatgpt/search_form/<field_name>`.

`ChatGPTForm` (`src/Form/ChatGPTForm.php`, route `chatgpt_plugin.search_form`, perm *access
chatgpt search form*): a textfield (`chatgpt_search`, maxlength 1024) + a "Generate" button
with AJAX callback `chatgptSearchResult()`. That callback builds the prompt
`"Write an article on this topic in <site default language> - <input>"`, calls
`GPTApiService::getGptResponse()`, and returns an `AjaxResponse` with
`HtmlCommand('#chatgpt-result', nl2br($response))`. `js/chatgpt_plugin.js`
(`Drupal.behaviors.chatgpt_plugin`) shows a "Use this content" button that pushes
`#chatgpt-result` HTML into the CKEditor 5 instance (`ckeditorInstance.setData`) or, if no
editor, the field's `<input>` value.

## Assistance tool

`ChatGPTAssistToolForm` (`src/Form/ChatGPTAssistToolForm.php`, route
`chatgpt_plugin.chatgpt_assist_tool`, perm *access chatgpt search form*). Operation select:
- **image_generation** → `DallEApiService::getDalleResponse()`; renders returned URLs into an
  HTML `<table>` of `<img src>` via `HtmlCommand`.
- **seo_generation** → prompt *"Extract SEO keywords from the following text - …"* → GPT →
  `nl2br` into `#chatgpt-result`.
- **article_creation** → prompt *"Generate an engaging article … within N words -…"* → GPT,
  then `Node::create(['type'=>'article','title'=>$title,'body'=>$content])->save()` — creates
  and saves a node programmatically inside the AJAX callback.

## Translation

- `ChatgptContentRouteSubscriber` (priority -211, after core's -100) rewrites any route whose
  `_controller` is core `ContentTranslationController::overview` to
  `ContentTranslationControllerOverride::overview` (`src/Controller/…`). For `node` it wraps
  the overview build in `ChatGPTTranslateForm`.
- `ChatGPTTranslateForm` (`src/Form/ChatGPTTranslateForm.php`) adds a "ChatGPT Translations"
  column with a per-language `Link` to `chatgpt_plugin.translate_content` for languages the
  node does not yet have.
- `ChatGPTTranslateController::translate($lang_code,$lang_name,$node_id)`
  (`src/Controller/ChatGPTTranslateController.php`, perm *access chatgpt translation*): loads
  the node, collects title + text/string fields, calls `GPTApiService` per field with prompt
  *"Translate this into <lang_name> - <value>"*, then `insertTranslation()` adds a translation
  and saves each field with format **`full_html`**. Redirects back to `HTTP_REFERER`.

## Library

`chatgpt_plugin.libraries.yml` → `chatgpt_assets`: `js/chatgpt_plugin.js` (footer) depending
on `core/ckeditor`, `core/drupal`, `core/drupalSettings`, `core/jquery`, `core/once`.
Attached globally by `chatgpt_plugin_page_attachments()`.

# Configure the Simple search form block

There is **no admin settings page** (`configure: null`). All configuration is per **block
instance**: place the "Simple search form" block (plugin `simple_search_form_block`, category
Search) at `/admin/structure/block` (Place block) and fill its block form, or set it in the
`block` config entity's `settings`.

## Settings (schema `block.settings.simple_search_form_block`)

| Key | Type | Meaning |
|---|---|---|
| `action_path` | path | **Required.** URL the form submits to. Must start with `/`, `?`, or `#` (validated in `blockValidate`). |
| `get_parameter` | string | **Required.** Query-string key the typed text is sent as. |
| `input_type` | string | `search` (default), `textfield`, or `search_api_autocomplete` (only offered if that module is enabled). |
| `input_label` | label | Search input label (default `Search`). |
| `input_label_display` | string | `before` / `after` / `invisible`. |
| `input_placeholder` | label | Placeholder text. |
| `input_css_classes` | string | Space-separated CSS classes added to the input. |
| `submit_display` | boolean | Show the submit button (default TRUE). |
| `submit_label` | label | Submit button text (default `Find`). |
| `input_keep_value` | boolean | Keep the submitted value in the input after redirect (default FALSE). |
| `preserve_url_query_parameters` | sequence | List of URL query params to carry through the submit (entered comma-separated in the UI). |
| `search_api_autocomplete` | mapping | `search_id`, `display`, `filter`, `arguments` — see [../api/integration.md](../api/integration.md). |

## What submit does

The form is `#method => 'get'` with `#token => FALSE`. Submitting navigates the browser to
`action_path?get_parameter=<typed value>`. A `#after_build` callback (`cleanupGetParams`) hides
`form_id`/`form_build_id` so they don't appear in the URL. Example result:
`/search?search_api_fulltext=drupal`.

## Example (block config `settings`)

```yaml
settings:
  id: simple_search_form_block
  action_path: /search
  get_parameter: search_api_fulltext
  input_type: search
  input_label: Search
  input_label_display: invisible
  input_placeholder: 'Search the site…'
  submit_display: true
  submit_label: Find
  input_keep_value: true
  preserve_url_query_parameters: []
```

## Auto-guessed defaults (Views)

If Views is enabled and a View is **tagged `simple_search_form`**, the block form pre-fills
`action_path` from that view's routable (page) display URL and `get_parameter` from its exposed
`search_api_fulltext` filter identifier. You can still override both. Details:
[../api/integration.md](../api/integration.md).

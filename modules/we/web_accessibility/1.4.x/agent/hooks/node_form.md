# Hooks it implements

## `web_accessibility_form_node_form_alter()` — `hook_form_BASE_FORM_ID_alter` for the node form

Adds the accessibility-checker UI to node edit forms. Behavior (in `web_accessibility.module`):

- **Only for existing nodes** — guarded by `if (!$node->isNew())`, so it never appears on
  the node *create* form (there is no saved URL yet).
- Inserts a `details` element `web_accessibility_settings`:
  - title "Web Accessibility Services", `#group => 'advanced'` (the vertical-tabs /
    sidebar region), `#open => FALSE`, `#weight => 30`, class `web-accessibility-form`,
    `#access => TRUE`.
  - a `#markup` label "Check with".
- Computes the node's public URL once: `$node->toUrl('canonical', ['absolute' => TRUE])->toString()`.
- Reads every stored service via `web_accessibility.service_manager`'s `findAll()`, and for
  each one renders a link:
  - `#type => 'link'`, wrapped in `<div class="web_accessibility_link form-item">…</div>`,
    styled as a `button`, `target => '_blank'`.
  - href = the service `url` with `WebServiceInterface::URL_TOKEN` (`<URL>`) replaced by the
    node's absolute canonical URL, passed through `Url::fromUri(..., ['absolute' => TRUE])`.
  - label = the service `name`.

So an editor opening an existing node sees a collapsed "Web Accessibility Services" tab
whose buttons open each configured validator against the live page in a new tab. The
target page must be publicly reachable for the external validator to fetch it (the
README notes "the content must be public").

## `web_accessibility_help()` — `hook_help`

On `help.page.web_accessibility` it returns the module's `README.md`. If the optional
`markdown` module is enabled it renders the file through the `markdown` filter plugin
(using `markdown.settings` config); otherwise it returns the raw text wrapped in `<pre>`.

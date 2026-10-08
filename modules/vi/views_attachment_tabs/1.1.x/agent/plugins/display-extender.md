# Display extender plugin: `views_attachment_tabs_extender`

The whole module hangs off one plugin. It is **not a new plugin type** — it is a plugin *of* the core
Views `display_extender` type, so there is no manager service, attribute, or interface to implement
here; you interact with it through Views' extender API and through the template preprocess.

- Id: `views_attachment_tabs_extender`
- Class: `Drupal\views_attachment_tabs\Plugin\views\display_extender\TabsExtender`
  (`src/Plugin/views/display_extender/TabsExtender.php`), extends
  `Drupal\views\Plugin\views\display_extender\DisplayExtenderPluginBase`.
- Annotation: `@ViewsDisplayExtender(id = "views_attachment_tabs_extender", … no_ui = FALSE)`.
  `no_ui = FALSE` is what makes it appear in the *Display Extenders* checkbox list at
  `admin/structure/views/settings`.

## Options (`defineOptions`)

```php
$options['enabled']  = ['default' => FALSE];
$options['title']    = ['default' => ''];
$options['weight']   = ['default' => 0];
$options['tokenize'] = ['default' => FALSE];
```

These are per-display and stored under
`display_options.display_extenders.views_attachment_tabs_extender` (see configure/tabs.md).

## Form wiring

- `buildOptionsForm(&$form, $form_state)` — **returns early unless**
  `$form_state->get('section') === 'views_attachment_tabs'`. Title text differs by context:
  displays that `usesAttachments()` get "Set attachments to this display as tabs"; an attachment
  display gets "Display this attachment as tab". Builds the `enabled` checkbox, then
  `tokenize`, the token help (`tokenForm()`), `title`, and `weight` (number, min −100 / max 100),
  all `#states`-gated on `enabled` being checked.
- `submitOptionsForm(&$form, $form_state)` — same section guard; copies `enabled`, `tokenize`,
  `title`, `weight` from form values into `$this->options`.
- `optionsSummary(&$categories, &$options)` — registers where the summary link appears:
  - On a display that `usesAttachments()`: adds a `views_attachment_tabs` category (title
    "Attachment tabs", column `second`) and an option row showing Enabled/Disabled.
  - On an `Attachment` display: adds a single option row under the existing `attachment` category
    (title "Attach as tab", `#weight` 99).
  - Returns without adding anything if the display neither uses attachments nor *is* an attachment.

## Value helpers (used by the preprocess)

```php
public function isEnabled(): bool;            // !empty($this->options['enabled'])
public function getTabTitle();                // $this->options['title'] tokenized, or t('Tab') if empty
public function getTabWeight(): int;          // (int) $this->options['weight'] ?? 0
public function tokenizeValue(string $value): string;
```

`getTabTitle()` calls `tokenizeValue()`, which — only when `tokenize` is on — runs
`$this->view->getStyle()->tokenizeValue($value, 0)` (Views field/argument tokens from the **first
row**), and in all cases applies `globalTokenReplace()` for global tokens. `tokenForm()` is a
**verbatim copy of core `TokenizeAreaPluginBase::tokenForm()`**: it lists the display's field/argument
tokens (e.g. `{{ field_name }}`, `{{ arguments.arg }}`, `{{ raw_arguments.arg }}`), notes Twig syntax
is allowed, lists the admin-allowed HTML tags (`Xss::getAdminTagList()`), and adds the global-token
form; all token UI is `#states`-gated on the `tokenize` checkbox.

## How the extender is consumed at render time

The preprocess (`views_attachment_tabs_preprocess_views_view_attachment_tabs`) fetches the extender
off each display via `$display->getExtenders()['views_attachment_tabs_extender']`, checks
`instanceof TabsExtender && isEnabled()`, and reads `getTabTitle()` / `getTabWeight()` to build the
tab. A display whose extender is absent or `enabled === FALSE` is left as an ordinary
attachment (not turned into a tab). See [../hooks/preprocess.md](../hooks/preprocess.md).

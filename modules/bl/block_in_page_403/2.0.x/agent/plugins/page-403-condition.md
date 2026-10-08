<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `page_403` — "Page 403" block visibility condition

Class `Drupal\block_in_page_403\Plugin\Condition\Page403Request` in
`src/Plugin/Condition/Page403Request.php`. Annotation `@Condition(id = "page_403",
label = @Translation("Page 403"))`. Extends core `ConditionPluginBase`, implements
`ContainerFactoryPluginInterface`. This is the module's only code.

## Install & enable

```
composer require drupal/block_in_page_403
drush en block_in_page_403 -y
```

Requires core **Block** (`dependencies: - drupal:block`). No PHP or library requirements, no
external services.

## How to use

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place or configure a block; open its **Visibility** tab.
3. Under the **"Page 403"** condition, tick **"Show in page 403"** (optionally **Negate**).
4. Save. The block now evaluates as visible only on 403 responses (subject to its other
   conditions and access checks).

There is no dedicated admin route or permission — configuration is entirely through the core block
UI. Managing block layout requires core's own `administer blocks` permission.

## Evaluate logic (`evaluate()`)

- Reads `$this->configuration['page_403']`.
- If it equals `1`: gets the current request via the injected `request_stack`
  (`getCurrentRequest()->attributes->get('exception')`) and returns **TRUE** only when
  `$exception && $exception->getStatusCode() == 403`; otherwise **FALSE**.
- If it is not `1` (default/unchecked, `defaultConfiguration()` sets `page_403 => ''`): returns
  **TRUE** unconditionally, so the condition imposes no restriction.
- **Negate** is not handled inside `evaluate()`; core's condition/access resolver inverts the
  result when the block's negate flag is set. `summary()` returns
  *"Return true on the following page 403."* or the negated variant.

This is an ordinary Drupal block visibility condition: it is combined (AND/OR per the block's
condition logic) with the block's other visibility conditions and its plugin-level access. It can
only narrow visibility — it never grants access to a block the viewer could not otherwise see, and
blocks shown on the 403 page still go through core's normal block rendering/access path.

## Config form & storage

- `buildConfigurationForm()` adds a static `#markup` heading `<h5>Page 403</h5>` (no dynamic/user
  data) and a `#type => checkbox` `page_403` bound to the current value.
- `submitConfigurationForm()` saves `$form_state->getValue('page_403')` into
  `$this->configuration['page_403']`.
- Stored inside the host block config entity's `visibility.page_403` mapping, e.g.:

```yaml
visibility:
  page_403:
    id: page_403
    negate: false
    page_403: true
```

## Cache

`getCacheContexts()` appends `url.path` to the parent contexts, so a block using this condition
varies by path.

## Config schema caveat

`config/schema/block_in_page_403.schema.yml` declares the type key
**`condition.plugin.page_not_found_request`** (a leftover name from the sibling "Block In Page 404"
project), not `condition.plugin.page_403`. Because the schema type does not match this plugin's id,
the `page_403` visibility value is not covered by a matching schema definition (it falls back to
untyped handling). This is a correctness/typed-config nit only — the boolean still stores and
evaluates correctly — but config schema validation tools will flag the mismatch.

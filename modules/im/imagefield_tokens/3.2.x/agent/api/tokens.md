<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token storage & replacement mechanism

## Where token text lives

Editors type tokens into the image field's normal **Alt** (`alt`) and **Title** (`title`) values.
The raw token string is stored verbatim on the image field item — the module does **not** add new
columns or field settings; it reuses the core image field's `alt`/`title`.

## Widget (`ImageFieldTokensWigdet`, extends `image_image`)

- `formElement()` adds a `token_tree` element (`#theme => token_tree_link`) scoped to the host
  entity's token type, so editors can browse/insert tokens.
- `process()` builds a preview and pre-replaces tokens for display:
  `\Drupal::token()->replace($item['alt'], [$entity_type => $current_entity])` (and the same for
  `title`), falling back to the raw value if replacement is empty.
- It resolves the host entity type from the field's parent entity (or `$element['#entity_type']`).

## Formatter (`ImageFieldTokensFormatter`, extends the core image formatter)

- Injects the `token` service (`@token`).
- `viewElements()` runs, per item:
  ```php
  $alt   = $this->tokenService->replace($item_values['alt'],   $data, [], $alt_bubbles);
  $title = $this->tokenService->replace($item_values['title'], $data, [], $title_bubbles);
  ```
  where `$data` is the host entity keyed by its token type.
- It merges the returned **BubbleableMetadata** (`$alt_bubbles`, `$title_bubbles`) into the render
  element's cache metadata, so token-derived alt/title invalidate correctly with the entity.

> **Known incompatibility (Drupal 11.4+):** `ImageFieldTokensFormatter::create()` calls the parent
> `ImageFormatter` constructor with the pre-11.4 argument list; core 11.4 added an 11th
> `$imageDerivativeUtilities` argument, so instantiating this formatter fatals with an
> `ArgumentCountError`. The widget (above) is fine; the formatter needs a patch to add the new
> constructor argument. Verified on the live 11.4 site.

## Colorbox formatter (`ColorboxFormatter`)

Same token replacement, but rendering through Colorbox; registered as `imagefield_tokens_colorbox`
and only usable when the `colorbox` module is enabled.

## No API to implement

The module defines no plugin types, hooks (`*.api.php`), services, or Drush commands. It only
provides the above core-plugin instances and a few `hook_*_alter` integrations
(FileField Sources, IMCE, conditional crop/colorbox availability).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Like! — the `like_default` formatter and computed `likes` field

## The computed field

Once an entity type is enabled (config `like.settings:enabled_entity_types`),
`like_entity_base_field_info()` (`like.module`) adds a base field **`likes`** to that entity type:

- `BaseFieldDefinition::create('integer')`, label *Likes*, `setComputed(TRUE)`,
  `setDisplayConfigurable('view', TRUE)`, default display region `hidden`.
- Class `LikeItemList` (`src/LikeItemList.php`): `computeValue()` sets item 0 to
  `\Drupal::service('like.helper')->getNumOfLikes($entity)` — a live COUNT of `like` rows for that
  entity. So the field value is always the current like total; it is not stored on the host entity.

Because it is computed and display-configurable, you expose it on **Manage display** like any field.

## The formatter

`LikeFormatter` (`src/Plugin/Field/FieldFormatter/LikeFormatter.php`):

- `@FieldFormatter(id = "like_default", label = "Likes", field_types = { "integer" })` — it targets
  integer fields; in practice you attach it to the computed `likes` field.
- `defaultSettings()`: `default_state = 'Like'`, `liked_state = 'You liked this.'`
  (schema `field.formatter.settings.like_default`, both type `label`).
- `settingsForm()`: two text fields — **Default state text** and **Liked state text** — the labels
  shown next to the heart before/after the current visitor has liked.
- `viewElements()`: for each item it renders a `container` with class `like--wrapper` and
  `data-entity-type` / `data-entity-id` attributes, then builds the like form via
  `formBuilder->getForm('\Drupal\like\Form\LikeForm', $item, $this->getSettings())`. It attaches
  library `like/like` and adds `drupalSettings.like['<type>:<id>']` (entity type/id + the formatter
  settings) so `js/like.js` can update labels and counts.

## The like form (`LikeForm`, `src/Form/LikeForm.php`)

A `FormBase` (form id `like_form`, theme hook `like_form`, template `templates/like-form.html.twig`
which just prints `{{ form }}`). `buildForm($form, $form_state, $item, $settings)`:

- Reads the host entity from `$item->getEntity()`; the form id is unique per entity.
- Renders a `checkbox` `like_toggle` (default value = `like.helper::userHasLiked()`), a heart
  `<i class="fa-solid fa-heart">`, a `<span class="like-txt">` with `liked_state`/`default_state`,
  and a `<span class="like-num">` count. The checkbox has an `#ajax` callback `ajaxSubmit`.
- On the AJAX trigger it optimistically flips the label and increments/decrements the shown count
  for immediate feedback, and reflects the new state back into the form.
- If `antibot_protect_form()` exists (Antibot installed), the form is passed through it
  automatically.

`ajaxSubmit()`: re-reads `userHasLiked()` for the bound entity and calls `like.helper::like()` if
not yet liked, else `unlike()`. The **entity is bound at form-build time** from the field item, not
taken from request input, so a submit only affects the entity that was rendered to the user. The
`AjaxRefreshLikeSubscriber` re-enables pointer events on `.like--wrapper` after the response (the JS
disables them during the round-trip to stop rapid double-clicks).

Label text (`default_state` / `liked_state`) is admin-entered formatter config and is rendered
through `#type => html_tag` `#value`, which the render system escapes. The count is produced by
`likesTxt()` via `t('(<span>@value</span>) Likes', ['@value' => $value])` with `$value` an integer.

## Client behaviour (`js/like.js`, library `like/like`)

`Drupal.behaviors.like` wires the checkbox: on change it disables the input, mirrors the checked
state and label/count across any sibling widgets for the same entity on the page, and sets
`pointer-events: none` until the AJAX refresh. An `IntersectionObserver` lazily GETs
`like/{type}/{id}` when a widget scrolls into view to sync the displayed count and, from the
`Drupal.visitor.like` cookie, the anonymous checked state. Library deps: `core/jquery`,
`core/drupal`, `core/drupalSettings`, `js_cookie/js-cookie`; CSS `css/like.css`.

## Config-export snippet (per view-display)

```yaml
# In core.entity_view_display.node.article.default.yml, under content:
likes:
  type: like_default
  label: hidden
  settings:
    default_state: 'Like'
    liked_state: 'You liked this.'
  weight: 100
```

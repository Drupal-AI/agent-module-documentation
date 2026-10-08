<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the length indicator on a field

There is **no admin settings page** and `configure` is `null`. You enable the indicator
per field, per form mode, on the *Manage form display* page.

## UI steps

1. Go to the entity's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
2. The field must use a supported widget: **Textfield** (`string_textfield`) or
   **Text area (multiple rows)** (`string_textarea`). Other widgets show no option.
3. Click the field's widget **cog/gear**.
4. Tick **Length indicator**, then set:
   - **Optimum minimum** (`optimin`) — start of the "good" range (min 1, default 10).
   - **Optimum maximum** (`optimax`) — end of the "good" range (min 5, default 15).
     Must be greater than `optimin`.
   - **Tolerance** — how far the "ok" (amber) band extends past the good range on each
     side (min 0, default 5). Must be **smaller than** `optimin`.
5. Click **Update**, then **Save**.

The form-display summary line then reads `Length indicator: On`.

## Where it is stored

As a third-party setting on the field's component in the form-display config entity:

```
core.entity_form_display.<entity>.<bundle>.<form_mode>
  content.<field>.third_party_settings.length_indicator:
    indicator: true
    indicator_opt:
      optimin: 40
      optimax: 60
      tolerance: 10
```

## Set it in code / config

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default');
$component = $fd->getComponent('field_summary');   // must be a string_textfield/string_textarea widget
$component['third_party_settings']['length_indicator'] = [
  'indicator' => TRUE,
  'indicator_opt' => ['optimin' => 40, 'optimax' => 60, 'tolerance' => 10],
];
$fd->setComponent('field_summary', $component)->save();
```

Constraints enforced on the UI form (mirror them when writing config):
`optimax > optimin` and `tolerance < optimin`.

## Validation errors you may hit

- "Optimum maximum has to be greater than the optimum minimum" — raise `optimax`.
- "Tolerance has to be smaller than the optimum minimum" — lower `tolerance`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `media_qualtrics` field formatter

The module **implements** one field formatter plugin (it does not define a new plugin *type*).

- Plugin id: **`media_qualtrics`**, label **"Remote Media - Qualtrics"**.
- Class: `Drupal\media_qualtrics\Plugin\Field\FieldFormatter\MediaQualtricsEmbedFormatter`
  extends `Drupal\media_remote\Plugin\Field\FieldFormatter\MediaRemoteFormatterBase`.
- `field_types = {string}` — it applies to plain **string** fields (paste the survey URL as text).

## Apply it to a field

The formatter is selected on an entity's **Manage display** (`entity_view_display`) for a
`string` field. Stored config path:

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  <field_name>:
    type: media_qualtrics
    label: hidden
    settings: {  }
    region: content
```

Scriptable:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_mq_survey', ['type' => 'media_qualtrics', 'label' => 'hidden', 'region' => 'content'])->save();
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_mq_survey`
→ `type: media_qualtrics`.

## What it renders

For each non-empty item whose value matches an allowed host
(see [configure/allowed-hosts.md](../configure/allowed-hosts.md)):

- Builds `Url::fromUri($value, ['query' => ['Q_CHL' => 'si']])` — the `Q_CHL=si` param lets
  Qualtrics post height changes to the parent (undocumented, may change).
- Themes it via `#theme => 'media_qualtrics'` → `media-qualtrics.html.twig`, an
  `<iframe class="qualtrics-embed-container" src="…">` inside an `<article>`, preceded by a
  fallback "public form" link.
- Attaches the `media_qualtrics/qualtrics-controller` library (JS resizer).
- The iframe `title` is taken from the parent entity's `name` field.

Values that do **not** match any allowed host produce no output.

## Valid URL examples the formatter recognises

Per allowed host `H`: `H/jfe/form/[your-survey-id]` and `H/se/?SID=[your-survey-id]`
(from `getValidUrlExampleStrings()`).

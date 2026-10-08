# Plugins — ParagraphsBehavior

Behavior plugins add non-field functionality to a paragraph type: extra render attributes,
CSS classes, layout/container options, preprocess variables — without adding storage fields.
Enabled per type on the type edit form; settings live under `behavior_plugins.<id>`.

- **Manager service:** `plugin.manager.paragraphs.behavior`
  (`Drupal\paragraphs\ParagraphsBehaviorManager`, tag via `paragraphs.plugin_type.yml`).
- **Namespace:** `Plugin\paragraphs\Behavior`
- **Discovery:** attribute `#[Drupal\paragraphs\Attribute\ParagraphsBehavior]`
  (legacy annotation `@ParagraphsBehavior` also supported).
- **Interface:** `ParagraphsBehaviorInterface`; **base:** `ParagraphsBehaviorBase`.

## Attribute params
`id`, `label` (TranslatableMarkup), optional `description`, `weight` (int), `deriver`.

## Key interface methods
- `buildBehaviorForm($paragraph, &$form, $form_state)` — settings shown on the paragraph in
  the widget (gated by the `edit behavior plugin settings` permission).
- `validateBehaviorForm()` / `submitBehaviorForm()` — validate and persist those settings.
- `view(array &$build, Paragraph $paragraph, EntityViewDisplayInterface $display, $view_mode)`
  — alter the render array at view time.
- `preprocess(&$variables)` — add template variables.
- `static isApplicable(ParagraphsType $type)` — whether the plugin may be enabled on a type.
- `settingsSummary(Paragraph $paragraph)` — short summary strings for the collapsed widget.

## Skeleton
```php
namespace Drupal\my_module\Plugin\paragraphs\Behavior;

use Drupal\paragraphs\ParagraphsBehaviorBase;
use Drupal\paragraphs\Attribute\ParagraphsBehavior;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\Core\Entity\Display\EntityViewDisplayInterface;
use Drupal\paragraphs\Entity\Paragraph;
use Drupal\paragraphs\Entity\ParagraphsType;

#[ParagraphsBehavior(
  id: 'my_layout',
  label: new TranslatableMarkup('My layout'),
  description: new TranslatableMarkup('Adds layout classes.'),
  weight: 0,
)]
class MyLayoutBehavior extends ParagraphsBehaviorBase {
  public static function isApplicable(ParagraphsType $paragraphs_type) { return TRUE; }
  public function view(array &$build, Paragraph $paragraph, EntityViewDisplayInterface $display, $view_mode) {
    $build['#attributes']['class'][] = 'my-layout';
  }
}
```

Alter registered plugins with [`hook_paragraphs_behavior_info_alter()`](../hooks/hooks.md).

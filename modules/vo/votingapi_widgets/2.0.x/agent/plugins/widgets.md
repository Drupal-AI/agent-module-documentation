# The VotingApiWidget plugin type

This module **defines** a plugin type for vote widgets.

- **Manager:** `Drupal\votingapi_widgets\Plugin\VotingApiWidgetManager` — service
  `plugin.manager.voting_api_widget.processor` (also autowire-aliased by class name).
- **Discovery dir:** `Plugin/VotingApiWidget` in any module.
- **Attribute:** `Drupal\votingapi_widgets\Attribute\VotingApiWidget` (params: `id`, `label`,
  `values`, optional `deriver`). Legacy Annotation `…\Annotation\VotingApiWidget` also works.
- **Interface:** `VotingApiWidgetInterface` (`buildForm()`, `getStyles()`).
- **Base class:** `VotingApiWidgetBase` — implement your widget by extending this.
- **Alter hook:** `hook_votingapi_widgets_voting_api_widget_info_alter()`. Cache bin
  `votingapi_widgets_voting_api_widget_plugins`.

Built-in widgets: `fivestar` (values 1–5), `like` (value 1), `useful` (values -1 / 1).

## Implement a custom widget
Mirror `Plugin/VotingApiWidget/FiveStarWidget.php`:

```php
namespace Drupal\my_module\Plugin\VotingApiWidget;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\votingapi_widgets\Attribute\VotingApiWidget;
use Drupal\votingapi_widgets\Plugin\VotingApiWidgetBase;

#[VotingApiWidget(
  id: "ten_point",
  label: new TranslatableMarkup("Ten point"),
  values: [1 => new TranslatableMarkup("1"), /* … */ 10 => new TranslatableMarkup("10")],
)]
class TenPointWidget extends VotingApiWidgetBase {

  // Called by the formatter's lazy builder. Wrap the vote form and attach a library.
  public function buildForm($entity_type, $entity_bundle, $entity_id, $vote_type, $field_name, $settings) {
    $form = $this->getForm($entity_type, $entity_bundle, $entity_id, $vote_type, $field_name, $settings);
    return [
      'rating' => ['#theme' => 'container', '#attributes' => ['class' => ['votingapi-widgets', 'ten-point']], '#children' => ['form' => $form]],
      '#attached' => ['library' => ['my_module/ten_point']],
    ];
  }

  // Decorate the value element on the entity edit form (initial-vote element).
  public function getInitialVotingElement(array &$form) {
    $form['value']['#prefix'] = '<div class="votingapi-widgets ten-point">';
    $form['value']['#suffix'] = '</div>';
  }

  // Style options offered in the formatter settings.
  public function getStyles() {
    return ['default' => $this->t('Default')];
  }
}
```

What the base class gives you (do not re-implement):
- `getForm()` — builds the `BaseRatingForm` for the vote entity via the entity form builder,
  passing `options` (= your `values`), `settings`, and the plugin instance.
- `getEntityForVoting()` — creates or reloads the current user's `vote` entity honoring the
  rollover window (anonymous votes keyed by IP).
- `canVote($vote)` — permission check (`vote on …` for new, `edit own vote on …` for existing).
- `getResults()` / `getVoteSummary()` — pull Voting API results and render the summary theme.
- `getValues()`, `getLabel()`, `getWindow()`.

Your widget id becomes selectable as the field's **vote_plugin** storage setting. JS/CSS that
reacts to the rendered `select[data-*]` element lives in your attached library (see the shipped
`js/fivestars.js`, `js/like.js`, `js/useful.js`).

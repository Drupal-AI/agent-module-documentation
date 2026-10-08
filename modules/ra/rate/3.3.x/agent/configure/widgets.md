<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build & configure a rate widget

A widget is a **`rate_widget` config entity** (config prefix `rate_widget`; config names
`rate.rate_widget.<id>`). Manage at **Structure → Rate widgets**
(`/admin/structure/rate_widgets`); add at `/admin/structure/rate/add` (permission
`administer rate`).

## Exported fields (`config_export`)

| Field | Meaning |
|---|---|
| `id`, `label` | machine name + admin label |
| `template` | widget style: `custom`, `fivestar`, `numberupdown`, `emotion`, `thumbsup`, `thumbsupdown`, `yesno` |
| `value_type` | VotingAPI totalling: `points` (summed), `percent` (averaged), or option counts |
| `options` | sequence of `{value, label, class, function}` — the buttons; values must be unique integers |
| `entity_types` | sequence of `"<entity_type>.<bundle>"` the widget attaches to (e.g. `node.article`) |
| `comment_types` | sequence of comment bundles the widget attaches to |
| `voting` | `{use_deadline, anonymous_window, user_window}` (rollover windows in seconds; special values for never/immediately/votingapi) |
| `display` | `{display_label, label_class, label_position, description, description_class, description_position, readonly}` |
| `results` | `{result_type, result_position}` for the summary |

## Read / inspect from the CLI

```bash
drush pm:list --status=enabled | grep rate           # confirm enabled
drush config:get rate.rate_widget.my_widget          # dump a widget
drush php:eval 'print implode("\n", array_keys(\Drupal::entityTypeManager()->getStorage("rate_widget")->loadMultiple()));'
```

## Create a widget in code

```php
use Drupal\rate\Entity\RateWidget;
RateWidget::create([
  'id' => 'article_stars',
  'label' => 'Article stars',
  'template' => 'fivestar',
  'value_type' => 'percent',
  'options' => [
    ['value' => 0,   'label' => '1', 'class' => '', 'function' => ''],
    ['value' => 25,  'label' => '2', 'class' => '', 'function' => ''],
    ['value' => 50,  'label' => '3', 'class' => '', 'function' => ''],
    ['value' => 75,  'label' => '4', 'class' => '', 'function' => ''],
    ['value' => 100, 'label' => '5', 'class' => '', 'function' => ''],
  ],
  'entity_types' => ['node.article'],   // a plain list; keys must NOT contain dots
  'comment_types' => [],
  'voting' => ['use_deadline' => 0, 'anonymous_window' => -2, 'user_window' => -2],
])->save();
```

After adding a widget you must grant the generated per-bundle voting permission (see
[settings.md](settings.md)) or nobody can vote.

## Voting deadline

Setting `voting.use_deadline` adds a datetime field (`field_rate_vote_deadline`) to each
attached entity. When an entity's deadline has passed the widget renders disabled and passes
`disabled` / `deadline_disabled` to the summary template.

## Where votes go

Votes are stored in VotingAPI's `votingapi_vote` table, tagged with the widget machine name
in its `rate_widget` column. Voting is AJAX-only; users can undo a vote where allowed.

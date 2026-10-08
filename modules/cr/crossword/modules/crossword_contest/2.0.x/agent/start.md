<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Contest (crossword_contest) — agent index

Submodule of **crossword**. A low-stakes "solve to unlock" contest built on a `crossword_contest`
media type with server-side answer checking. Deps: `crossword:crossword`, `crossword:crossword_media`.
Core `^10.2 || ^11`. GPL-2.0-or-later.

## Provides

- **Media type** `crossword_contest` (config in `config/install/`): fields
  `field_crossword_contest_xword` (crossword), `field_correct_message`, `field_incorrect_message`;
  view modes `crossword_contest_play`, `crossword_contest_correct`, `crossword_contest_incorrect`.
- **Formatter** `crossword_contest` ("Crossword Contest", `CrosswordContestFormatter` extends base
  `CrosswordFormatter`). `isApplicable()` restricts it to a `crossword` field on the
  `crossword_contest` **media** bundle. `viewElements()` **forces `redacted = TRUE`**, adds library
  `crossword_contest/crossword.contest` and `drupalSettings.crossword.mid`, strips the show-errors
  class. Buttons: Clear, **Solution→"Submit"**, Undo, Redo, Instructions. Schema
  `field.formatter.settings.crossword_contest`.
- **Route** `crossword.contest` → `/crossword-contest/{mid}/{answer}` (`mid: \d+`), requirements:
  `_permission: 'view media'` **and** `_custom_access:
  CrosswordContestController::validateMid`. Controller `CrosswordContestController::build()` returns an
  AJAX `OpenModalDialogCommand`. → [contest/contest.md](contest/contest.md)
- **Library** `crossword_contest/crossword.contest` (`js/crossword-contest.js`, deps drupal.ajax +
  dialog + base crossword).

## Access model (from source)

`validateMid()` requires: media exists, `$media->access('view', currentUser)`, bundle ==
`crossword_contest`, and the crossword field is set — else `AccessResult::forbidden()`. The answer is
compared server-side to the true solution (`isCorrectAnswer()` → `crossword.data_service::getSolution`);
the client never receives the answers (redaction forced). Explicitly a **low-stakes** framework per
its README — not for money/legal use.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up and running a contest

## Install & enable

```bash
drush en crossword_contest -y
```

Pulls in `crossword` + `crossword_media`. Installation creates the `crossword_contest` media type,
its three fields, and the three view modes (`config/install/*`).

## Configure (from README)

1. Add a **media reference** field to a node type, restricted to `crossword_contest` media.
2. On the node display, show that field as a rendered entity in the **`crossword_contest_play`**
   view mode (already wired to the **Crossword Contest** formatter).
3. Adjust the Crossword Contest formatter settings as desired (it forces redaction regardless).
4. Configure the **`crossword_contest_correct`** view mode — rendered in a modal on a correct
   submission (put the reward here: coupon, link, message).
5. Configure the **`crossword_contest_incorrect`** view mode — rendered in a modal on a wrong
   submission (hint/encouragement). Both are fully templatable and use the normal hooks.

## Runtime flow (source)

- Play view uses `CrosswordContestFormatter` (extends base `CrosswordFormatter`). It sets
  `redacted = TRUE` so the solution is **never** placed in `drupalSettings`, relabels the "Solution"
  button to "Submit", and exposes `drupalSettings.crossword.mid` (the media id).
- `js/crossword-contest.js` posts the solver's grid as a JSON `answer` to
  `/crossword-contest/{mid}/{answer}`.
- Route `crossword.contest` is gated by `_permission: 'view media'` **and** the custom access callback
  `CrosswordContestController::validateMid($mid)`, which returns `forbidden()` unless: the media
  exists, the current user has `view` access to it, the bundle is `crossword_contest`, and
  `field_crossword_contest_xword` has a target. `{mid}` must match `\d+`.
- `CrosswordContestController::build()` loads the media and calls `isCorrectAnswer()`:
  `getSolution()` from `crossword.data_service` on the referenced crossword file, then
  `strtolower($answer) == strtolower(json_encode($solution))`. Correct → view builder renders
  `crossword_contest_correct`; incorrect → `crossword_contest_incorrect`. The result is wrapped in an
  `OpenModalDialogCommand` (`AjaxResponse`) titled with the media label.

Because checking is server-side against the real solution and the play formatter redacts the answers,
the client cannot read the solution out of page data; the only "answer" that unlocks the reward is the
full, correct grid.

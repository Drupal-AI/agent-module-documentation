<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword Contest is a simple framework for a low-stakes "solve the puzzle to unlock content" contest: it installs a `crossword_contest` media type and three view modes, renders the puzzle with the answers redacted, and checks a submitted solution server-side, opening a "correct" or "incorrect" view mode in a modal.

---

This submodule of Crossword (requires `crossword` and `crossword_media`) ships a `crossword_contest` media type with a crossword field (`field_crossword_contest_xword`) plus correct/incorrect message fields, and three media view modes: `crossword_contest_play`, `crossword_contest_correct`, `crossword_contest_incorrect`. The `crossword_contest` field formatter (`CrosswordContestFormatter`, extends the base `CrosswordFormatter`) is used in the play view mode; it **forces solution redaction** (the answer is never sent to the browser), turns the "Solution" button into a "Submit" button, and attaches `js/crossword-contest.js`, which posts the solver's grid to the site. The route `crossword.contest` (`/crossword-contest/{mid}/{answer}`, permission `view media` plus a custom access check that the media exists, is viewable by the user, is a `crossword_contest` bundle, and has a crossword) runs `CrosswordContestController::build()`, which compares the submitted answer against the puzzle's real solution server-side (`CrosswordContestController::isCorrectAnswer()` using `crossword.data_service::getSolution()`) and returns the correct or incorrect view mode in an AJAX modal. Everything — the reward content, the encouragement message — is configured in the UI through the two message view modes; no code is required. The README stresses it is only for low-stakes contests (nothing involving money or legal implications) and is meant as a starting point for more sophisticated integrations.

---

- Run a "solve this crossword to reveal a coupon" style promotion.
- Reward a correct solution with a modal of special content (link, code, message).
- Show an encouraging hint in a modal when the submitted solution is wrong.
- Keep the puzzle's answers off the client — the solution is redacted and checked server-side.
- Use the ready-made `crossword_contest` media type without writing code.
- Configure the reward content by editing the `crossword_contest_correct` media view mode.
- Configure the "try again" content by editing the `crossword_contest_incorrect` media view mode.
- Embed the contest puzzle on a node via a media-reference field displayed in the play view mode.
- Reuse one contest puzzle across multiple pieces of content (it's a media entity).
- Turn the Solution button into a Submit button so solving = entering the contest.
- Restrict who can play using core media view access (permission `view media` + media access).
- Template or hook the correct/incorrect view modes for a richer reward experience.
- Use it as a starting point for a more sophisticated, higher-stakes integration of your own.

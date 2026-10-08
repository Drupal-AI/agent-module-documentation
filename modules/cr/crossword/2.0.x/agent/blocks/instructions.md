<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Instructions block

`src/Plugin/Block/CrosswordInstructionsBlock.php`, `@Block(id = "crossword_instructions",
admin_label = "Crossword Instructions")`, extends core `BlockBase`.

Provides a standard, placeable block that documents the puzzle keyboard shortcuts. `build()` returns a
`#theme => 'crossword_instructions'` render array with `#field_formatter => 'block'` and attaches the
`crossword/crossword.instructions` library. Template: `templates/crossword-instructions.html.twig`.

## Configuration (`defaultConfiguration()` / schema `block.settings.crossword_instructions`)

| Key | Default | Effect |
|---|---|---|
| `cheat` | `TRUE` | Show the keyboard shortcut line for **Cheat**. |
| `rebus` | `TRUE` | Show the shortcut line for **Rebus** entry. |
| `errors` | `TRUE` | Show the shortcut line for **Toggle Errors**. |

`blockForm()` exposes those three as checkboxes; `blockSubmit()` saves them. Place the block via
*Structure → Block layout* (or config), typically on the same page as a playable puzzle. The same
`crossword_instructions` theme hook is also emitted inline by the puzzle formatter when its
**Instructions** button is enabled (`CrosswordFormatter::getInstructionsDetails()`), so the block is
an alternative way to surface the instructions independently of the button.

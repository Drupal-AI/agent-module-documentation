# Installation

## Requirements

Quiz 7 is a substantial module with several dependencies. It needs:

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- **PHP** compatible with that core release.
- A handful of contrib modules, which Composer installs for you:
  **Field Group**, **Entity API** (`drupal/entity`), **Paragraphs**, **Range**,
  **Rules**, and **Views Bulk Operations**.
- Core modules it builds on: Datetime, Datetime Range, Text, Views, and Options
  (enabled automatically).

Optionally, the **Replicate** module (`drupal/replicate`) lets you clone quizzes and
questions.

## Install with Composer

From the project root:

```bash
composer require drupal/quiz -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer pull
in and update Quiz's several dependencies (Rules, Paragraphs, Views Bulk
Operations, and so on).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quiz -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quiz -y
```

## Enable at least one question type

Quiz cannot do anything until at least one **question‑type submodule** is enabled.
Choose the types you need:

| Submodule | Machine name | Question type |
|-----------|--------------|---------------|
| Multiple choice | `quiz_multichoice` | Single/multiple correct answers from a list. |
| True/false | `quiz_truefalse` | A simple true‑or‑false question. |
| Short answer | `quiz_short_answer` | A short typed answer (auto or manual grading). |
| Long answer | `quiz_long_answer` | An essay‑style answer, graded manually. |
| Matching | `quiz_matching` | Match items in one column to another. |

Other optional submodules extend the experience:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Quiz Page | `quiz_page` | Group several questions onto one page/screen. |
| Quiz Directions | `quiz_directions` | Insert unscored instruction/direction pages between questions. |
| AJAX Quiz | `ajax_quiz` | A single‑page, AJAX quiz‑taking experience. |

For example, to enable multiple choice and true/false:

```bash
drush en quiz_multichoice quiz_truefalse -y
```

Once a question type is enabled, head to [Configuration](../configuration/index.md)
to set the global options and create your first quiz.

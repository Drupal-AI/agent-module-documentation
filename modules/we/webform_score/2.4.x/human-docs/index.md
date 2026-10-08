# Webform Score — manual setup guide

**Webform Score** (`webform_score`) adds automatic scoring to Webform
submissions, turning ordinary webforms into quizzes and assessments. It ships a set
of special "Quiz" form elements that carry a correct‑answer and scoring
configuration; when a submission is saved, the module computes a score (points and a
percentage) and stores it on the submission, ready to show on the submission page,
in a View, or inside confirmation messages and emails.

You build a graded form using Webform's normal authoring UI: add one of the four
Quiz elements — **Quiz textfield**, **Quiz radios**, **Quiz select**, or **Quiz
checkboxes** — and, in each element's *Quiz answer* section, pick a scoring
methodology and its settings (for example the expected answer and a maximum score).
To the person filling in the form, these elements look and behave exactly like the
core textfield/radios/select/checkboxes; the scoring is applied behind the scenes on
save. You can freely mix scored and non‑scored elements in one form — only the Quiz
elements contribute to the total.

The scoring logic itself is pluggable. Built‑in methods include **equals** (exact
text match, with a case‑sensitive option), **contains** (substring match), and
aggregation methods **sum**, **maximum**, and **set equals** for multi‑value
answers. Developers can add new algorithms by writing a `webform_score` plugin, and
alter the discovered plugins via `hook_webform_score_info_alter()`.

The computed score is stored as a read‑only field (it's calculated, never edited
directly), and its visibility is controlled by two permissions — **view any
submission score** and **view own submission score** — so you decide who sees
results. This module has no global settings page; scoring is configured per Quiz
element. It depends on the **Webform** and **Fraction** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with Webform and
   Fraction) with Composer and enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You add and configure Quiz elements inside the
Webform builder (**Structure → Webforms → *(your form)* → Build**), and you grant
the score‑visibility permissions at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Open (or create) a webform and go to its **Build** tab.
2. **Add element** and choose one of the **Quiz** elements (Quiz textfield, Quiz
   radios, Quiz select, or Quiz checkboxes).
3. Configure the question as usual (label, options, etc.), then open the **Quiz
   answer** section on the element form:
   - **Scoring methodology** — choose a scoring plugin. The list is filtered to the
     methods compatible with that element's answer type. For example, *equals* for a
     text answer, or an aggregation method for checkboxes.
   - **Plugin configuration** — fill in the chosen method's settings, such as the
     **expected answer**, whether it's **case sensitive** (for text), and the
     **maximum score** (the points that question is worth).
4. Repeat for each question you want scored. Save the form.
5. Decide who can see scores: at **People → Permissions**, grant **view any
   submission score** (see the score on any submission the user can already view) or
   **view own submission score** (see it only on their own submissions). A user must
   be able to view the submission itself first — these permissions are additive.

When a submission is saved, Webform Score sums the awarded points and the maximum
across the Quiz elements and stores the result as a fraction (scored / maximum).

### Showing the score

- **On the submission page or in a View** — the score field ships a percentage
  display; add it to the submission view display or to a submissions View (handy for
  a gradebook or leaderboard).
- **In messages/emails** — use the tokens `[webform_submission:webform_score]` (the
  percentage), plus `[webform_submission:webform_score_numerator]` and
  `[webform_submission:webform_score_denominator]` (for computing pass/fail
  downstream).

> **Note:** if a form has no Quiz element configured to score (maximum of 0), the
> score field is hidden entirely — even from administrators — since there's nothing
> meaningful to show.

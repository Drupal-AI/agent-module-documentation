# Configuration

Everything Dynamic Placeholder does is driven from its admin settings form. There
you build the list of placeholder phrases, tell the module which inputs they apply
to, and tune how the rotation feels.

## Open the settings form

1. Log in as an administrator.
2. Reach the Dynamic Placeholder settings form from the module's **Configure** /
   settings link on the **Extend** page (`/admin/modules`), or from under
   **Configuration**.

## The options

The form collects the following (as documented by the module):

- **Placeholder examples** — the list of strings that will rotate through the
  field, one per line or per row (for example `Search News`, `Search Events`,
  `Search Products`). This is the core of the configuration; each entry becomes one
  phrase in the cycle.
- **CSS selector(s)** — a selector that targets the specific input(s) the rotating
  placeholder should apply to (for example a search box's id or class). This lets
  you scope the effect precisely rather than affecting every text input on the
  page.
- **Rotation interval** — how long each phrase is shown before the next one appears.
- **Pause on focus** — when enabled, the rotation stops while the user has clicked
  into (focused) the field, so the hint doesn't keep changing while they read or
  type.
- **Randomized rotation** — when enabled, phrases appear in a random order instead
  of always cycling top‑to‑bottom.
- **Transition effect** — a simple animated transition between phrases, rather than
  an instant swap.

## Save and check

Save the form, then load a page that contains a field matching your CSS selector.
The placeholder text should begin cycling through your list at the interval you
set. If nothing happens, the most common causes are a CSS selector that doesn't
match the field, or an empty placeholder list — revisit the form and confirm both.

> **Tip:** Keep the phrase list short and genuinely helpful. Rotating placeholders
> are a nudge toward what a field accepts; a long or slow‑cycling list is more
> distracting than useful, and remember that placeholder text disappears as soon as
> the user starts typing, so never rely on it to convey required information.

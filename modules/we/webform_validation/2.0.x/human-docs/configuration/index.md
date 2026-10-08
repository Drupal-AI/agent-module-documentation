# Configuration

Webform Validation has no central settings page. Every rule is configured **on an
individual element** inside a webform, under a fieldset called **Form extra
validation**.

## Where the settings live

1. Go to **Structure → Webforms** and open the form you want to validate.
2. On its **Build** tab, click **Edit** next to the element that should carry the
   check.
3. Scroll to the **Form extra validation** fieldset. It only appears on supported
   element types (see [Supported element types](#supported-element-types) below).

Inside that fieldset you'll find the three rules. You can enable more than one on the
same element.

## Equal values

Turn this on when a group of elements must all hold the **same** value — the classic
"Confirm email" or "re-enter your account number" pattern.

- **Enable** — tick to switch the rule on for this element.
- **Components** — choose the other elements that must match this one. All the selected
  elements (including this one) are compared, and they all have to be equal for the
  form to pass. Email values are compared **case-insensitively**, so `Me@Example.com`
  and `me@example.com` count as equal.

## Compare two values

Turn this on to compare **this** element against **one other** element using a
mathematical operator — for instance, requiring an end date to be later than a start
date, or a maximum budget to be at least the minimum.

- **Enable** — tick to switch the rule on.
- **Component** — the other element to compare against.
- **Operator** — one of **greater than (`>`)**, **greater than or equal (`>=`)**,
  **less than (`<`)**, or **less than or equal (`<=`)**. The comparison reads as "the
  compared-with element *operator* this element" — for example, with `>` and an *End
  date* element comparing against a *Start date* component, submission passes only when
  the start date is earlier than the end date.
- **Custom error message** — optional. If set, this text is shown instead of the
  generic error when the comparison fails — for example, *"End date must be after start
  date."*

Note that **Compare two values** only works on a narrower set of element types — see
below.

## Some of several

Turn this on to require that a certain number of elements in a group be filled in — for
example, "provide at least one of phone or email", "choose exactly 3 of 5 options", or
"select at most 2 add-ons".

- **Enable** — tick to switch the rule on.
- **Components** — the group of elements the requirement applies to.
- **Completed requirement** — how many must be completed, written as an operator plus a
  number: **`>=1`** (at least one), **`=3`** (exactly three), **`<=2`** (at most two),
  and so on.
- **Validate only on the final page** — for multi-step (wizard) webforms, tick this so
  the rule is only checked on the last page rather than as the user moves between steps.

## Supported element types

The **Form extra validation** fieldset only appears on these element types: **date,
datetime, email, hidden, number, select, tel, textarea, textfield, document file
(`webform_document_file`), checkboxes (`webform_entity_checkboxes`), signature
(`webform_signature`), and time (`webform_time`)**.

The **Compare two values** rule is stricter — it is only available on **date, datetime,
number, and time** elements, since those are the types that can be meaningfully ordered.

## Saving

When you save the element, the module double-checks your entries — for example, it
requires at least one component when *Equal values* or *Some of several* is enabled, and
requires both a component and an operator when *Compare* is enabled. Fix any reported
problem, save the element, then save the whole webform. The rules run automatically on
every submission from then on.

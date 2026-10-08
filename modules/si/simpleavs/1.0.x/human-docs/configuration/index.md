# Configuration

Everything about the age gate is set on one settings form, and the options are
intended to be intuitive.

## Open the settings form

1. Log in as a user with the module's configure permission.
2. Navigate to **`/admin/config/simpleavs`**.

## Choose the verification method

Pick one of two ways to ask the visitor's age:

- **Yes/No question** — a single "Are you over the age of [your configured age]?"
  prompt with confirm/deny buttons.
- **Date of birth** — the visitor enters their date of birth.

Both paths are self-reported (see the [main guide](../index.md)): the Yes/No answer
is taken at face value and the date of birth is whatever the visitor types.

## Set the minimum age and how often it appears

- **Minimum age** — any number you like: 18, 21, or another threshold.
- **Frequency** — how often the modal shows up (for example, on every page load, or
  less often once passed). "On Every Page Load" is handy while testing.

## Choose which pages it covers

Define **include** and **exclude** rules for the pages where the gate should appear.
By default it shows on the front page.

## Set the redirects

- **Success redirect** — where to send a visitor who passes (is old enough).
- **Failure redirect** — where to send a visitor who is underage.

## Customise the text and appearance

- **Labels and buttons** — edit the text shown on the prompt's various labels and
  buttons to match your site's tone or language.
- **Colours** — use one of the preset colour schemes, or design your own with the
  colour picker in the UI.

## Who can skip the gate

Simple AVS provides two permissions: one controlling who may configure the module,
and one letting chosen roles bypass the modal entirely. Assign these under **People →
Permissions** so that, for example, logged-in staff never see the prompt.

## Save and test

Save the form, then — as noted in installation — set the frequency to "On Every Page
Load" and open a fresh browser window as an anonymous user to confirm the overlay
behaves as configured.

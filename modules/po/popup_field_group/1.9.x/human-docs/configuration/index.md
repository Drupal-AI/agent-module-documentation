# Configuration

Popup Field Group has no central settings page. Instead, every popup is
configured on the group itself, on the display screen where you create it. The
options below are the ones you set when you add or edit a Popup group.

## Add a Popup group

1. Go to the **Manage form display** (for edit forms) or **Manage display** (for
   rendered output) screen of the bundle you want — for example
   `/admin/structure/types/manage/article/form-display`.
2. Scroll to the bottom and click **Add group**.
3. Choose **Popup** in the group‑type drop‑down, give the group a label, and
   click **Save and continue**.
4. Set the popup options (described below), then click **Create group**.
5. Drag the fields you want to hide into the new group, and click **Save**.

At render time the group's fields are hidden and an **Open popup** link appears
in their place; clicking it opens the fields in a dialog.

## Popup link options

These control the trigger the visitor clicks to open the dialog.

- **Show link** — whether to render the "Open popup" link at all. Turn it off if
  you want to open the dialog from your own custom control instead (the dialog's
  hidden container carries a `data-target` id you can point at).
- **Link text** — the caption of the trigger link, for example *Show popup* or
  *More details*.
- **Classes** — extra CSS classes to add to the link, handy if you want to style
  it as a button using your theme's classes.

## Popup label options

- **Title** — the heading shown at the top of the dialog window. Leave it empty
  for no title.
- **Close button text** — a custom caption for the dialog's close button.

## Popup (dialog) settings

These control how the dialog itself looks and behaves.

- **Modal** — when on, the dialog is *modal*: it blocks the rest of the page
  behind an overlay until closed. When off, it is a floating, non‑blocking
  window the visitor can leave open while working elsewhere on the page.
- **Dialog class** — an extra CSS class applied to the dialog container for
  custom styling.
- **Close on escape** — when on, pressing the **Escape** key closes the dialog.
- **Height / Min height / Max height** and **Width / Min width / Max width** —
  the dialog's size. Leave the main height/width on `auto` to let the content
  size the dialog, or set explicit pixel values (and optional minimums and
  maximums) to constrain it.
- **Horizontal position** — where the dialog sits across the screen: **left**,
  **center**, or **right**. This is required.
- **Vertical position** — where the dialog sits down the screen: **top**,
  **center**, or **bottom**. This is required.
- **Append to** — a CSS selector naming the DOM element the dialog markup should
  be attached to. Leave empty to use the default. Useful when a themed container
  needs the dialog nested inside it.

## Custom CSS (optional)

If you have the **System Stream Wrapper** module installed, an **extra CSS**
field appears where you can point the dialog at custom CSS files using
stream‑wrapper paths, for bespoke styling of that specific popup. Without that
module the field is not available.

## Save and reuse

Click **Save** on the display screen to store everything. All of these choices
are saved into the display's configuration, so you can export them and deploy
the same popup group to other environments — or copy the pattern to other
content types.

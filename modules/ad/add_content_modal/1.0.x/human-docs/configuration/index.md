# Configuration

Nothing changes until you configure the module — you have to tell it which content
types should open in a dialog. This page walks through the settings form.

## Open the settings form

1. Log in as a user with the **Manage add_content_modal settings** permission (an
   administrator has it by default).
2. Go to **Configuration → Content authoring → Manage content modal**, or navigate
   directly to `/admin/config/content/add-content-modal`.

## The settings

The form has three things to set:

- **Dialog type** — choose whether the affected links open as a **modal** (a
  centered pop-up that dims the page behind it) or **off-canvas** (a panel that
  slides in from the side of the screen, leaving the page visible). Pick whichever
  suits your editors' workflow.
- **Modal width** — how wide the dialog should be. Set this to fit your admin
  theme and the node forms you'll be editing; a form with many fields usually
  wants a wider dialog so it isn't cramped.
- **Content types** — tick the content types whose **Add / Edit / Delete /
  Translate** actions should open in the chosen dialog. Only the types you tick
  here are affected; everything you leave unticked keeps the standard full-page
  forms.

## Save

Click **Save configuration**. The module clears caches on save so the altered
links, tabs, and operation buttons take effect immediately. Try adding or editing
a node of a configured type — the form should now open in your chosen dialog
instead of loading a new page.

> **Tip:** if a dialog looks cramped or too wide, come back and adjust the **Modal
> width**, then re-save.

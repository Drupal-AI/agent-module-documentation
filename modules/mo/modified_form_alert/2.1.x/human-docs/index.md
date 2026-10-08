# Modified Form Alert — manual setup guide

**Modified Form Alert** (`modified_form_alert`) warns users about unsaved changes
when they try to leave a form they have been editing. If someone edits a form and
then navigates away — closing the tab, hitting back, or reloading — the browser
shows its native leave-confirmation prompt (in Chrome, "Reload site? Changes that
you made may not be saved"), giving them a chance to stay and save first.

It is a small, focused content-editing/UX safeguard against accidental loss of
edits. It is inspired by the
[Node Edit Protection](https://www.drupal.org/project/node_edit_protection)
module but is more general — it can add the unsaved-changes alert to **any** form,
not just node edit forms. The module changes only the leave-page behavior; it does
not change any content or access, and it plays no access-control role. It requires
**PHP 8.0** and works on Drupal 8 through 11.

There is no dedicated settings page, so this guide folds setup into this page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Its behavior is described in
"How to use it" below.

## Where it lives in the admin menu

Modified Form Alert adds no admin settings page of its own. Its effect is felt on
the forms it guards: when a form has been edited and the user tries to leave, the
browser shows a leave-confirmation prompt.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a covered form (for example a node add/edit form), change a value, then
   try to navigate away without saving.
3. The browser prompts you to confirm leaving the page, protecting your unsaved
   edits. Saving or explicitly discarding the changes clears the warning.

This is a client-side guard built on the browser's own "leave site?"
confirmation, so the exact wording of the prompt comes from the browser, not from
Drupal.

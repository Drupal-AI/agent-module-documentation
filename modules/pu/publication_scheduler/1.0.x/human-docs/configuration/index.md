# Configuration

Publication Scheduler is largely automatic — its form improvements apply as soon
as it's enabled on content types that use Scheduler. There is just one optional
behavior to adjust and two permissions to consider.

## The "Authored on" field toggle

By default, the module **hides the "Authored on" (Created) field** on the node
add/edit form, on the assumption that the *Published on* date from the
Publication Date module is what you actually care about. If your team still needs
to edit the creation date as a matter of course, the module provides a setting to
**turn this hiding off**, restoring the standard "Authored on" field for
everyone. Leave the setting at its default if you want the streamlined form.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

| Permission | What it allows |
|------------|----------------|
| **Allow editing of created date** (`allow editing of created date`) | Lets the chosen roles edit the "Authored on" (Created) date even while the module hides it for everyone else. Use this to give trusted editors the ability to override the creation date when they genuinely need to. |
| **Allow to unhide fields** (`allow to unhide fields`) | Lets the chosen roles see fields the module would otherwise hide on the node form. |

Give both permissions only to roles you trust with the underlying date and
publishing fields, since they let those users step outside the streamlined
workflow the module enforces.

## A note on scope

Publication Scheduler adjusts the **node editing form**. The actual scheduling
(the *publish on* / *unpublish on* dates and whether scheduled publishing is
required) is configured in the **Scheduler** module and per content type; the
recorded publication date comes from the **Publication Date** module. This module
simply makes the three work together cleanly, so most of your setup happens in
those two modules' own settings.

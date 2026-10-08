# Buttons Config — manual setup guide

**Buttons Config** (`buttons_config`) lets you change the text on the **submit
button** of content and media type forms. Out of the box every form's button says
"Save", but "Save" is the right word for a page and the wrong one for a good many
other things: a job application is *submitted*, an incident report is *filed*, and
a moderated item is *sent for review* rather than saved. When the button says
something other than what the action does, editors hesitate — and on a public form
they hesitate visibly.

This module lets you set the label per content type and per media type, and it
does so as **configuration** rather than as a form-alter buried in a site module
where nobody will find it later. That keeps the change discoverable and exportable.

A couple of things worth keeping in mind: the label is a promise about what
happens, so match the word to the real outcome — labelling a moderated type's
button "Publish" when the item actually goes to review makes the interface *less*
truthful, not friendlier. And because the button text is user-facing copy, on a
multilingual site it should be translated through the usual translation route
rather than typed once in one language. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the submit-button labels per
   content and media type.

## Where it lives in the admin menu

Buttons Config stores its labels as site configuration, edited from a form in the
admin **Configuration** area where you set the label for each content type and
media type.

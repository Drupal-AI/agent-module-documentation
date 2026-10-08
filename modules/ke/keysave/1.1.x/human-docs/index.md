# Key Save — manual setup guide

**Key Save** (`keysave`) adds an IDE-style keyboard shortcut to Drupal's admin
forms: press **Ctrl-S** (or **Cmd-S** on a Mac) and the form saves, instead of
your browser popping up its "Save this web page" dialog. For anyone who does a
lot of content or configuration editing, it turns the familiar save gesture into
a real save — no more scrolling to the bottom of a long form to find the button.

It works by finding the form's primary submit button and clicking it for you, so
all the normal validation and submit behavior runs exactly as if you'd clicked
*Save* yourself. It even hooks into CKEditor, so Ctrl-S works while your cursor is
inside a rich-text field. The shortcut looks for the usual save buttons in order
(*Save*, *Save and continue*, and so on) and quietly does nothing if a form has
none.

Out of the box, Key Save is applied automatically to the forms where it's most
useful: every entity add/edit form (nodes, media, taxonomy terms, users) and
every configuration form that extends Drupal's standard config form base. A short
settings page lets you fine-tune this with two lists — one to *force* the shortcut
onto specific forms that don't fit those categories, and one to *exclude* forms
where you don't want it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the include/exclude form lists and
   how the automatic behavior works.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Key Save**
(`/admin/config/user-interface/keysave`), gated by the standard **Administer site
configuration** permission. Most sites never need to open it — the shortcut works
on entity and config forms as soon as the module is enabled.

## How to use it

Just enable the module, then open any node/user/term edit form or config form and
press **Ctrl-S** (Windows/Linux) or **Cmd-S** (Mac). The form saves through its
normal submit handler. Because Key Save clicks the real button, validation errors
and confirmation messages behave exactly as usual.

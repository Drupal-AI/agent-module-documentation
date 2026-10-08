# Multistep Form Advanced — manual setup guide

**Multistep Form Advanced** (`msf`) turns a long entity form into a
wizard‑style, multi‑step experience. Instead of confronting a person with one
enormous form, it lets you group the fields into stages and reveal them one step
at a time, complete with *Next*/*Previous* navigation and a step indicator that
shows progress. It is a fork of *Simple Multistep Form* with extra polish — most
notably support for user account/profile fields, email validation on the account
form, and the ability to save each step as you go.

The clever part is that it adds no new form of its own. It plugs into the
**Field Group** module as a field‑group formatter called **Form step**. You
group your fields into field groups on a form display, choose the *Form step*
formatter for those groups, and the module does the rest: at render time it shows
only the current step's fields, hides the others, adds the navigation buttons and
step indicator, and scopes validation so each step only checks its own fields.

Because everything is driven through Drupal's standard *Manage form display*
screen, there is nothing to configure in a settings form and no admin page of its
own. It depends on **Field Group** and **Account Field Split** (the latter lets
the user registration form's account fields be spread across steps). It is purely
a form‑display feature, so it adds no anonymous or public HTTP surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Field Group and Account Field Split dependencies.

This module has **no settings form**, so there is no separate configuration page.
Everything is set up on your form display, described in "How to use it" below.

## Where it lives in the admin menu

Multistep Form Advanced adds no admin page of its own. You use it entirely from
**Structure → Content types (or the relevant entity) → *(bundle)* → Manage form
display**, and for the registration wizard from the account form's display.

## How to use it

1. Decide which fields belong to each step and, on the entity's **Manage form
   display**, create a **field group** for each step (Field Group provides the
   *Add group* button).
2. Place the fields for that step inside its field group, and arrange the groups
   in the order you want the steps to appear.
3. For each step's field group, set its **format** to **Form step**. Give each
   step its label/step text as needed.
4. Save the form display and open the entity's add/edit form: it now shows one
   step at a time with *Next*/*Previous* buttons and a step indicator, validating
   only the current step as the person advances.

To build a multi‑step **user registration** wizard, do the same on the user
account form display; **Account Field Split** makes the core account fields
(username, email, password) available to place into individual steps.

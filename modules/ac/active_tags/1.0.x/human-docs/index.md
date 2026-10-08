# Active Tags — manual setup guide

**Active Tags** (`active_tags`) is a better editing widget for free-tagging
taxonomy fields. Drupal's built-in free-tagging widget is a single text box
holding a comma-separated list of tags — a data format leaking into the
interface. That design causes familiar problems: a tag that contains a comma has
to be quoted and nobody knows that; removing a tag from the middle of the list
means hand-editing a string; the existing tags aren't shown as separate items;
and there's no signal about which tags are new versus existing until after you
save — which is exactly how a vocabulary ends up with "Marketing", "marketing"
and "Marketing " as three different terms.

Active Tags replaces that box with a **chip-based widget**: each tag is a
discrete, removable "chip" you can see, add, and delete individually. Adding a
tag, seeing the tags you already have, and removing one all become obvious
actions rather than string surgery.

It depends on core's **Field** and **Taxonomy** modules and runs on Drupal 9.5,
10, and 11. Two things are worth keeping in mind. First, a chip widget needs to
work with the keyboard as well as the mouse — type-and-Enter to add, Backspace at
the start to remove the previous chip, arrow keys to move between chips — so test
that keyboard flow before rolling it out. Second, a nicer widget makes tag entry
tidier but doesn't stop a vocabulary from growing: free tagging is a governance
decision, and if term sprawl is a real problem, pair this with a review process
or a restricted term set.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Active Tags has no settings page of its own — you turn it on per field by
choosing it as the widget:

1. Go to the entity you tag — for example **Structure → Content types →
   Article → Manage form display**.
2. Find your tags field (a taxonomy term reference field configured for
   autocomplete / free tagging).
3. In the **Widget** column, select the **Active Tags** widget instead of the
   default autocomplete (tags) widget.
4. **Save** the form display.

Now, when editors open that content form, the tags field renders as chips: each
existing tag is its own removable item, and new tags are added one chip at a
time. Repeat for any other content type, media type, or entity that uses a
free-tagging field.

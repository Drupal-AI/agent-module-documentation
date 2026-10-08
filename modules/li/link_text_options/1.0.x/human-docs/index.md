# Link Text Options — manual setup guide

**Link Text Options** (`link_text_options`) adds a setting to core Link fields
that turns the free‑text **link text** input into a **select/options** element,
restricting what an editor can enter for the link's label. Instead of typing
anything they like, editors pick from a predefined list of allowed labels.

This is handy wherever link text should be standardized rather than arbitrary — a
node whose link field is rendered as a button that should only ever say "Learn
more", "Read more", or "Contact us", for example. It keeps calls‑to‑action and
button labels consistent and on‑brand. The URL portion of the field behaves
exactly as normal; only the text is constrained. It depends only on core **Link**.

A couple of behaviours are worth knowing. The module **does not validate** the
stored value against the list — so if you change the allowed options later,
existing link fields that were saved with an old value are not re‑checked and may
hold text that is no longer in the list. And if you configure only **one** option,
that single option is used as the default and the link‑text input is disabled
entirely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings page** for this module. You define the allowed
labels in each link field's own settings, described below.

## Where it lives in the admin menu

The module adds no admin page. You configure the allowed link‑text options on the
individual link field, under **Structure → Content types → *(your type)* → Manage
fields → *(your link field)* → the field's settings**.

## How to use it

1. Enable the module.
2. Edit the settings of the **Link** field you want to constrain (via **Manage
   fields** for its content type).
3. In the field's settings you will find the new option that turns the link‑text
   input into a select list — enter the **allowed link‑text options** you want
   editors to choose from.
4. Save. From now on, when editing content, the link‑text input for that field is
   a dropdown of your allowed labels. (Remember the notes above: a single option
   disables the input, and changing the options later does not re‑validate values
   already saved.)

# Configuration

## Open the settings form

1. Log in as a user with the **Administer metatag content**
   (`administer metatag content`) permission. This is a trusted‑admin permission,
   and it is also the permission an editor needs for the "Generate Metatag"
   button to show up on node forms.
2. Go to **Configuration → Content authoring → Metatag AI**, or navigate directly
   to `/admin/config/content/metatag-ai`.

All values are saved to the `metatag_ai.content_settings` configuration object.

## Content types

Choose which content types expose the **"Generate Metatag"** button on their
add/edit forms. Only the types you tick here get the feature — leave a type
unchecked and its editors see no button.

## Metatag field

The machine name of the Metatag field the generated values are written into.
The default is **`field_metatag`**. If you added your Metatag field under a
different name, enter that name here. The field must already exist on the
selected content type(s), or there will be nowhere for the results to go.

## AI provider / model

Optionally pick a specific AI provider and model — for example an OpenAI GPT
model — from the providers you've configured in the AI module. Leave it empty and
the module falls back to the AI module's **default chat provider**. This is where
you'd point metatag generation at a cheaper or higher‑quality model than your
site default, if you want to.

The provider's API key is not entered here — it lives with the AI module's
provider configuration, sourced from an environment variable / Key entity.

## Per‑language system prompt

This is the heart of the form. For **each enabled interface language** you get a
fieldset that lets you shape the instructions sent to the AI:

- **System message** — banner text shown at the top of this settings form for
  that language (a note to yourself/other admins).
- **Title**, **Description**, and **Abstract** instructions — text fields where
  you state the rules for each, typically including a length limit (for example
  "title, maximum 60 characters"). The module prefixes each with "title with…",
  "description with…", and "abstract with…".
- **Keywords** — a number field (1–50) for how many keywords to generate, plus an
  optional extra instruction.
- **Additional instructions** — any free‑form guidance you want to add.

On save, these pieces are assembled into a single system prompt per language. The
module always appends two fixed instructions of its own: "Suggest content for SEO
ranking." and a "reply in JSON" instruction so the response maps cleanly onto the
four metatag fields. A quick validity check is applied — a usable prompt has to
mention title/description/abstract/keyword and a maximum — so if you strip the
prompt down too far the generator will refuse it and fall back.

At generation time the module uses the prompt for the node's language, falling
back to the site default language, and finally to a sensible built‑in prompt
(title ≤ 60, description ≤ 160, abstract ≤ 160, up to 10 keywords) if nothing
else is configured.

## Save

Click **Save configuration**. Now open a node of an enabled content type: the
**Generate Metatag** button appears near the Metatag field. Clicking it fills the
basic title/description/abstract/keywords fields via AJAX — the editor still
reviews the values and **saves the node** to keep them.

## A note on permissions

The module defines two permissions. **Administer metatag content** is the one
that matters: it gates this settings form *and* whether the button renders on
node forms. A second permission, *Administer metatag AI*, is declared but not
actually wired to anything in this version, so granting it has no effect on its
own.

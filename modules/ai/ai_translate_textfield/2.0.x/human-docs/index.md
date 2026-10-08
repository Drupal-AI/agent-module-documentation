# AI Textfield Translation — manual setup guide

**AI Textfield Translation** (`ai_translate_textfield`) helps editors translate
the content of a text field into another language using an AI model, without
leaving the content-editing form. It builds on Drupal's **AI** module, which
handles the connection to whichever AI provider you have configured, and it slots
into the normal multilingual editing flow so translating a field is a quick
in-place action rather than a separate copy-paste job.

Think of it as a productivity aid for multilingual sites: when you are creating or
editing a translation, the module lets the AI produce a first-pass translation of
a field's text that the editor can then review and refine. It provides its own
permissions so you can control who is allowed to use the feature.

One thing to be deliberate about: when a field is translated, its content is sent
to the configured AI provider. Treat that as the field text **leaving your site**,
store the provider's credentials as secrets (via the AI module / Key module), and
think twice before using it on fields that hold sensitive information. The module
supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI module.

## Where it lives in the admin menu

There is no big configuration area to learn. The module ships a small settings
form (`ai_translate_textfield.settings_form`) under the site's AI configuration
where you tune its behavior, and it adds its own permission (see **People →
Permissions**) so you decide which roles may trigger AI translation. The
translation action itself appears in the content-editing form, on the text fields
it applies to.

## How to use it

1. Make sure the **AI** module has a working provider configured, with its API
   key stored as a secret.
2. Grant the module's permission to the roles that should be allowed to translate
   fields (**People → Permissions**).
3. On your multilingual site, edit or add a translation of a piece of content.
   For a supported text field, use the AI translation action to generate a
   translation into the target language, then review and save. Remember the field
   text is sent to your AI provider each time.

# Configuration

Configuration is a single idea: create **mappings** that say "when a translation
is downloaded for locale A, also save it into locale B (and C, …)." After that the
copying happens automatically every time Lingotek downloads a matching translation.

## Grant the permission

The mapping form is gated by the **Configure lingotek copy target** permission.
Grant it (under **People → Permissions**) only to the administrators who should
manage these mappings.

## Add a locale mapping

1. Go to **Configuration → Regional and language → Languages** and **edit** the
   language whose locale you want to copy *into* another (the mapping form is
   linked from the language edit form). The mapping form is provided at the
   `lingotek_copy_target.config` route.
2. Choose the **original locale** (the one Lingotek actually translates and
   downloads) and the **copy target locale(s)** that should receive the same data.
   A typical example is copying `es-ES` into `es-MX`, or `en-GB` into `en-AU`.
3. Save. You can define **several mappings** at once, and remove one later through
   a confirm‑delete form.

If a chosen target language is not yet configured on the site, the module warns
you — add the language first.

## What happens after that

- When Lingotek **downloads** a translation for a mapped original locale, the
  module intercepts the content and configuration translation presave and writes
  the same downloaded data into each mapped target locale, using Lingotek's own
  save‑target services.
- This covers **both content and configuration** translations.
- The result is that your mirror locales stay in sync automatically, and you avoid
  paying to translate the same text again for a locale that should simply match
  another.

There are no other settings — the mappings are the whole configuration.

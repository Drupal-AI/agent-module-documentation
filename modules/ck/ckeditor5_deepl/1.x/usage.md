Adds a DeepL button to CKEditor 5 that machine-translates the selected text, plus an optional always-available translation block, using DeepL API keys stored through the Key module.

---

CKEditor 5 DeepL integrates the DeepL translation service into Drupal's CKEditor 5 rich-text editor. Editors select text in the editor, click the DeepL toolbar button, pick a target language (and, on Pro keys, a formality), and the selection is replaced in place with the translation. Translation runs server-side: the browser posts the selected HTML to a Drupal route, which loads the DeepL API key from a Key entity and calls the official `deeplcom/deepl-php` library, so the API key is never exposed to the client. Each CKEditor text format is configured independently (its own key, split-sentences, tag handling, preserve-formatting, formality and the list of source/target languages), and available languages are fetched live from DeepL and cached. The module also ships a "Deepl Translation" block that renders a standalone translate form (toggleable on any admin page), a per-key usage-statistics page, and a dedicated "DeepL API Key" Key type that validates keys against the DeepL API.

---

- Let content editors translate a highlighted passage inside CKEditor 5 without leaving the editor.
- Offer in-editor translation into any of DeepL's supported target languages, chosen per text format.
- Restrict the source/target language dropdowns to just the languages a site actually needs.
- Use a DeepL Pro key to expose formality options (default / more / less / prefer_more / prefer_less) to editors.
- Fall back gracefully on DeepL Free keys, where the formality option is automatically hidden.
- Preserve original formatting during translation via the preserve-formatting option.
- Control sentence splitting behaviour (none / on punctuation and newlines / punctuation only).
- Choose tag handling (off / xml / html) so inline markup survives translation.
- Store DeepL API keys securely through the Key module instead of plaintext configuration.
- Manage keys with a purpose-built "DeepL API Key" key type that validates the key against DeepL on save.
- Configure a different DeepL key per CKEditor text format (e.g. separate keys for different teams or billing).
- Place a "Deepl Translation" block in an admin region to translate arbitrary text on any admin page.
- Toggle the block's translator open/closed with a floating button.
- Review DeepL usage (character counts and limits) per configured key at an admin statistics page.
- Distinguish Free vs Paid keys at a glance on the usage-statistics page.
- Give editors a quick one-click alternative to copy-pasting text into deepl.com.
- Speed up multilingual content authoring by drafting in one language and translating sections inline.
- Provide translators a consistent formality/tone setting across a text format.
- Enable translation only on specific text formats (e.g. full-HTML for trusted editors) by adding the button to that format's toolbar.
- Cache the DeepL language list to avoid repeated remote calls on every editor load.
- Integrate DeepL into existing CKEditor 5 workflows without a separate translation UI or module.

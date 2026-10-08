# Configuration

## Before you start: an AI provider

This module produces nothing on its own — it sends the image to a model through
the **AI (AI Core)** module. So before the button will work you need one of:

- a **default provider/model for the `chat_with_image_vision` operation** set in
  AI Core (at `/admin/config/ai/settings`, in the *Default Providers* area), or
- an explicit model chosen on this module's own settings form (below).

If neither is set, the **Generate with AI** button does not appear, and admins
with the AI settings permission see a warning on image forms telling them to
configure a provider.

## Open the settings form

1. Log in as a user with the **Administer AI** (`administer ai`) permission.
2. Go to **Configuration → AI → AI Image Alt Text Settings**, or navigate directly
   to `/admin/config/ai/ai_image_alt_text`.

## The fields

### Prompt

The instruction sent to the AI model. It is rendered through Twig before being
sent, so you can include two tokens:

- `{{ entity_lang_name }}` — the human-readable name of the content's language,
  which drives the language the alt text is written in.
- `{{ filename }}` — the original filename of the uploaded image.

The shipped default prompt tells the model to act as an accessibility expert,
keep the alt text under 100 characters, avoid phrases like "image of…", not
keyword-stuff, and reply with only the alt text. Edit it to match your house
style. This field is required.

### Image style

The image style applied to the picture *before* it is sent to the model — the
module ships one named **ai_image_alt_text** that downscales and reformats to
PNG, which lowers the token cost of each request. You can pick a different style,
or leave it empty to send the original full-resolution image (not recommended, as
it costs more).

### AI model

Which AI provider and model to use, chosen as a single "provider + model"
option. The list is filtered to chat models that support the *vision* capability
(`ChatWithImageVision`). Leave it empty to fall back to the site's default
`chat_with_image_vision` provider/model configured in AI Core. Set it to pin this
feature to a specific model regardless of the site default.

### Autogenerate

When ticked, alt text is generated **automatically on upload**, with no editor
click required. Off by default. Turn it on if you'd rather not rely on editors
pressing the button.

### Hide button

Hides the manual **Generate with AI** button. This only makes sense together with
**Autogenerate** — if autogenerate is off, the button is always shown regardless
of this setting. Use it to keep the widget tidy on sites where generation is fully
automatic.

## Save

Click **Save configuration**. The changes apply to image widgets immediately.

## The button on image fields

Once configured, the **Generate with AI** button shows up on an image field only
when all of these are true: the widget is an image widget, the field has alt text
enabled, the current user has the *Generate AI alt tags* permission, a working
provider is available, and an image has already been uploaded. Clicking it writes
the AI suggestion into the alt field for review.

## Permissions

| Permission | Controls |
|------------|----------|
| **Generate AI alt tags** (`generate ai alt tags`) | Whether a user sees the button and can trigger generation. |
| **Administer AI** (`administer ai`) | Access to this settings form. |
| **Administer AI settings** (`administer ai settings`, from AI Core) | Only used to decide whether to show the "no provider configured" warning. |

Grant *Generate AI alt tags* to your content-editor roles so they can use the
button.

## Doing it from the command line

The settings are a config object, so Drush works as usual:

```bash
drush cset ai_image_alt_text.settings autogenerate 1
drush config:export
```

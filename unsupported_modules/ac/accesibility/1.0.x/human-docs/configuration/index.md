# Configuration

The module works the moment it is enabled — the accessibility widget is attached
to every non-admin page automatically. The only thing to configure is the wording
of two helper messages, and even that is optional.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission (an
   administrator by default).
2. Go to **Configuration → Accesibilidad**, or navigate directly to
   `/admin/config/accesibility/adminsettings`.

## The two message fields

The form holds two textareas, whose text is stored in the module's
`accesibility.adminsettings` configuration:

- **Night mode message** — the helper text shown in connection with the
  high-contrast / night-mode toggle. Edit it to explain, in your own words, what
  the night-mode option does for visitors.
- **Simple navigation message** — the helper text shown in connection with the
  simplified-navigation reading mode. Edit it to describe that mode.

Because the module ships in Spanish, you may want to reword these to match your
site's language and tone. Both strings can also be translated through Drupal's
configuration translation if you run a multilingual site.

## Save

Save the form to store the messages. The widget itself needs no further setup — it
already appears on all content pages and stays off the `/admin/*` pages.

## Optional: styling and behaviour

The widget's appearance and behaviour come from the module's own front-end library
(`accesibility/accesibility-library`). If you want to change how it looks or
behaves, override that library's CSS or JavaScript from your theme — there are no
settings for this on the form itself.

# Configuration

Speech to Text has one job to configure: telling it which fields should get the
dictation control.

## Open the settings form

1. Log in as a user with permission to administer the module's settings.
2. Go to `/admin/config/systems/speech-to-text`.

## Choose which fields get dictation

On this page you configure the **input selectors** — the CSS selectors that
identify the text-input and textarea fields you want dictation enabled on. The
module attaches its voice-input control to the fields matching those selectors, so
you can target exactly the fields where dictation is useful (for example a
particular content type's body or a comment field) rather than every field on the
site.

Save the form when you are done. Then open a form that contains one of the
targeted fields and confirm the dictation control appears and captures speech into
the field.

## Remember the privacy consideration

Because dictation uses the browser's Web Speech API, in some browsers the captured
audio is sent to the browser vendor's servers to be transcribed (see the
[main guide](../index.md)). It is good practice to let the people who will use
dictation know this, especially where the content being dictated may be sensitive.

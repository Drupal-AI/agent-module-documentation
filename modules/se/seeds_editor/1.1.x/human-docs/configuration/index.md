# Configuration

Seeds Editor applies a working CKEditor 5 and text-format configuration the moment
it is enabled, so you do not have to build anything before you can start writing.
The module's own settings form is a small layer on top of that: it is where the
distribution loads custom styling for the editor, including separate styles for
left-to-right and right-to-left content.

## Open the settings form

1. Log in as a user with the **Administer Seeds editor**
   (`administer seeds editor`) permission — this single permission is what gates
   the page.
2. Go to **Configuration → Content authoring → Seeds Editor**, or navigate
   directly to `/admin/config/content/seeds-editor`.

## What the form governs

The settings page is primarily about **editor styling**. Seeds Editor's headline
feature is the ability to load custom CSS into CKEditor for both LTR and RTL text
directions, so that what an author sees inside the editor matches how the content
will render on the site — and so that right-to-left languages (Arabic, Hebrew,
Persian) are handled correctly in the editing surface, which is the part that is
hardest to retrofit later.

Beyond this form, most of what Seeds Editor delivers lives in the standard Drupal
places its dependencies configure: the **Text formats and editors** screen
(`/admin/config/content/formats`) for the CKEditor 5 toolbars and filters, plus
the individual settings pages of Linkit, Entity Embed, Smart Trim, and the other
bundled modules. Seeds Editor's job is to have wired those together for you with
sensible defaults; you only need to revisit them when you want to change the
out-of-the-box behaviour.

## Save

Click **Save configuration** to store your changes. Reload a content-edit page to
see the updated editor styling take effect.
